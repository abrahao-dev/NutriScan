//
//  OpenFoodFactsService.swift
//  NutriScan
//
//  Created by Rapha Vidal on 19/11/25.
//

import Foundation

/// Abstração da camada de rede para permitir injeção de dependência
/// (ViewModels testáveis com mocks).
protocol ProductServiceProtocol {
    func searchProducts(query: String, completion: @escaping (Result<[FoodInformation], Error>) -> Void)
    func fetchProduct(barcode: String, completion: @escaping (Result<FoodInformation, Error>) -> Void)
}

class OpenFoodFactsService: ProductServiceProtocol {
    
    private let baseURL = "https://world.openfoodfacts.org/cgi/search.pl"
    private let countryCode = "br"
    
    func searchProducts(query: String, completion: @escaping (Result<[FoodInformation], Error>) -> Void) {
        
        guard var components = URLComponents(string: baseURL) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "search_terms", value: query),
            URLQueryItem(name: "search_simple", value: "1"),
            URLQueryItem(name: "json", value: "1"),
            URLQueryItem(name: "page_size", value: "20"),
            URLQueryItem(name: "cc", value: countryCode)
        ]
        
        guard let url = components.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let data = data else {
                return completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Dados vazios"])))
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(OpenFoodFactsResponse.self, from: data)
                
                let foodInfos = apiResponse.products.compactMap { self.mapToFoodInformation(product: $0) }
                
                completion(.success(foodInfos))
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // Função de mapeamento (API Model -> Internal Model)
    // Internal (não private) para permitir testes unitários diretos.
    func mapToFoodInformation(product: ProductAPI) -> FoodInformation? {

        // O nome é obrigatório para um FoodInformation válido
        guard let name = product.product_name, !name.isEmpty else { return nil }

        // Mapeamento simples do Nutri-Score para o seu Enum (se aplicável)
        let score: NumberScore
        if let grade = product.nutrition_grades?.uppercased(),
           let mappedScore = NumberScore(rawValue: grade) {
            score = mappedScore
        } else {
             score = .scoreE
        }

        return FoodInformation(
            name: name,
            brand: product.brands ?? "Marca Desconhecida",
            imageUrl: URL(string: product.image_url ?? "https://placehold.co/60") ?? URL(string: "https://placehold.co/60")!,
            score: score,
            barcode: product.code,
            fat100g: product.nutriments?.fat_100g,
            saturatedFat100g: product.nutriments?.saturated_fat_100g,
            proteins100g: product.nutriments?.proteins_100g,
            fiber100g: product.nutriments?.fiber_100g,
            ingredientsText: product.ingredients_text
        )
    }
    
    func fetchProduct(barcode: String, completion: @escaping (Result<FoodInformation, Error>) -> Void) {
        
        let barcodeURL = "https://world.openfoodfacts.org/api/v0/product/\(barcode).json"
        
        guard var components = URLComponents(string: barcodeURL) else { completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Erro components"])))
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "cc", value: countryCode)
        ]
        
        guard let url = components.url else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL de código de barras inválida"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                return completion(.failure(error))
            }
            
            guard let data = data else {
                return completion(.failure(NSError(domain: "Network", code: 0, userInfo: [NSLocalizedDescriptionKey: "Dados vazios recebidos. Nenhum produto encontrado."])))
            }
            
            do {
                
                let decoder = JSONDecoder()
                let barcodeResponse = try decoder.decode(BarcodeResponse.self, from: data)
                
                guard barcodeResponse.status == 1,
                      let productAPI = barcodeResponse.product,
                      let foodInfo = self.mapToFoodInformation(product: productAPI)
                else {
                    return completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Produto não encontrado para este código de barras."])))
                }
                
                completion(.success(foodInfo))
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    struct BarcodeResponse: Decodable, Sendable {
        let status: Int
        let product: ProductAPI?
    }
}
