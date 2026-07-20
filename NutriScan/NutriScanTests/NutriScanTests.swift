//
//  NutriScanTests.swift
//  NutriScanTests
//
//  Created by Elena Diniz on 9/24/25.
//

import Testing
import Foundation
@testable import NutriScan

// MARK: - Mocks

/// Mock do serviço de produtos para testar ViewModels sem rede (DI via protocolo).
final class ProductServiceMock: ProductServiceProtocol {
    var searchResult: Result<[FoodInformation], Error> = .success([])
    var fetchResult: Result<FoodInformation, Error>?
    private(set) var searchQueries: [String] = []

    func searchProducts(query: String, completion: @escaping (Result<[FoodInformation], Error>) -> Void) {
        searchQueries.append(query)
        completion(searchResult)
    }

    func fetchProduct(barcode: String, completion: @escaping (Result<FoodInformation, Error>) -> Void) {
        if let fetchResult { completion(fetchResult) }
    }
}

private func makeFood(
    name: String = "Iogurte Grego",
    brand: String = "Vigor",
    barcode: String? = "789100010001",
    fat: Double? = nil,
    saturatedFat: Double? = nil,
    proteins: Double? = nil,
    fiber: Double? = nil
) -> FoodInformation {
    FoodInformation(
        name: name,
        brand: brand,
        imageUrl: URL(string: "https://placehold.co/60")!,
        score: .scoreB,
        barcode: barcode,
        fat100g: fat,
        saturatedFat100g: saturatedFat,
        proteins100g: proteins,
        fiber100g: fiber
    )
}

// MARK: - FoodInformation (InfoItems dinâmicos)

struct FoodInformationTests {

    @Test func baixaGorduraGeraItemBomParaOCoracao() {
        // Given
        let food = makeFood(fat: 2.5)

        // When
        let items = food.makeInfoItems()

        // Then
        #expect(items.contains { $0.title == "Bom para o coração" })
    }

    @Test func altaProteinaGeraItemDeMusculos() {
        // Given
        let food = makeFood(proteins: 14.0)

        // When
        let items = food.makeInfoItems()

        // Then
        #expect(items.contains { $0.title == "Construção de Ossos e Músculos" })
    }

    @Test func semNutrientesGeraItemDeInformacaoLimitada() {
        // Given
        let food = makeFood()

        // When
        let items = food.makeInfoItems()

        // Then
        #expect(items.count == 1)
        #expect(items.first?.title == "Informação nutricional limitada")
    }

    @Test func identityKeyUsaBarcodeQuandoDisponivel() {
        // Given
        let comBarcode = makeFood(barcode: "123")
        let semBarcode = makeFood(barcode: nil)

        // Then
        #expect(comBarcode.identityKey == "123")
        #expect(semBarcode.identityKey == "iogurte grego|vigor")
    }
}

// MARK: - ProductStore (persistência UserDefaults + JSON)

struct ProductStoreTests {

    private func makeStore() -> ProductStore {
        let suiteName = "test.nutriscan.\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        return ProductStore(defaults: defaults)
    }

    @Test func toggleFavoritaEDesfavorita() {
        // Given
        let store = makeStore()
        let food = makeFood()

        // When / Then
        #expect(store.toggleFavorite(food) == true)
        #expect(store.isFavorite(food))
        #expect(store.toggleFavorite(food) == false)
        #expect(!store.isFavorite(food))
    }

    @Test func favoritosPersistemEntreInstancias() {
        // Given
        let suiteName = "test.nutriscan.persist.\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        let food = makeFood()

        // When
        ProductStore(defaults: defaults).toggleFavorite(food)
        let reloaded = ProductStore(defaults: defaults)

        // Then
        #expect(reloaded.isFavorite(food))
    }

    @Test func recentesRemovemDuplicatasELimitamADez() {
        // Given
        let store = makeStore()

        // When: 12 produtos distintos + 1 repetido
        for index in 1...12 {
            store.addRecent(makeFood(name: "Produto \(index)", barcode: "\(index)"))
        }
        store.addRecent(makeFood(name: "Produto 12", barcode: "12"))

        // Then
        #expect(store.recents.count == 10)
        #expect(store.recents.first?.barcode == "12")
        #expect(store.recents.filter { $0.barcode == "12" }.count == 1)
    }
}

// MARK: - OpenFoodFactsService (mapeamento API -> modelo interno)

struct OpenFoodFactsServiceTests {

    @Test func mapeiaProdutoCompletoDaAPI() {
        // Given
        let service = OpenFoodFactsService()
        let api = ProductAPI(
            code: "789",
            product_name: "Aveia em Flocos",
            brands: "Quaker",
            image_url: "https://example.com/aveia.jpg",
            nutrition_grades: "a",
            nutriments: NutrimentsAPI(fat_100g: 7.0, saturated_fat_100g: 1.2, proteins_100g: 14.0, fiber_100g: 9.1),
            ingredients_text: "Aveia integral"
        )

        // When
        let food = service.mapToFoodInformation(product: api)

        // Then
        #expect(food != nil)
        #expect(food?.name == "Aveia em Flocos")
        #expect(food?.score == .scoreA)
        #expect(food?.barcode == "789")
        #expect(food?.proteins100g == 14.0)
        #expect(food?.fiber100g == 9.1)
    }

    @Test func produtoSemNomeEhDescartado() {
        // Given
        let service = OpenFoodFactsService()
        let api = ProductAPI(
            code: "1",
            product_name: nil,
            brands: nil,
            image_url: nil,
            nutrition_grades: nil,
            nutriments: nil,
            ingredients_text: nil
        )

        // When / Then
        #expect(service.mapToFoodInformation(product: api) == nil)
    }

    @Test func nutriScoreInvalidoViraScoreE() {
        // Given
        let service = OpenFoodFactsService()
        let api = ProductAPI(
            code: "2",
            product_name: "Produto X",
            brands: nil,
            image_url: nil,
            nutrition_grades: "unknown",
            nutriments: nil,
            ingredients_text: nil
        )

        // When
        let food = service.mapToFoodInformation(product: api)

        // Then
        #expect(food?.score == .scoreE)
    }

    @Test func decodificaChaveDeGorduraSaturadaComHifen() throws {
        // Given: JSON real da Open Food Facts usa "saturated-fat_100g"
        let json = Data("""
        { "fat_100g": 10.0, "saturated-fat_100g": 4.5, "proteins_100g": 3.0, "fiber_100g": 1.0 }
        """.utf8)

        // When
        let nutriments = try JSONDecoder().decode(NutrimentsAPI.self, from: json)

        // Then
        #expect(nutriments.saturated_fat_100g == 4.5)
    }
}

// MARK: - SearchFoodsViewModel (DI com mock)

@MainActor
struct SearchFoodsViewModelTests {

    @Test func buscaComSucessoPreencheProdutos() async throws {
        // Given
        let mock = ProductServiceMock()
        mock.searchResult = .success([makeFood()])
        let viewModel = SearchFoodsViewModel(service: mock)

        // When
        viewModel.search(query: "iogurte")
        try await Task.sleep(nanoseconds: 200_000_000)

        // Then
        #expect(viewModel.filteredProducts.count == 1)
        #expect(viewModel.errorMessage == nil)
        #expect(mock.searchQueries.contains("iogurte"))
    }

    @Test func falhaDeRedeExibeMensagemDeErro() async throws {
        // Given
        let mock = ProductServiceMock()
        mock.searchResult = .failure(NSError(domain: "test", code: -1009))
        let viewModel = SearchFoodsViewModel(service: mock)

        // When
        viewModel.search(query: "iogurte")
        try await Task.sleep(nanoseconds: 200_000_000)

        // Then
        #expect(viewModel.filteredProducts.isEmpty)
        #expect(viewModel.errorMessage != nil)
    }
}
