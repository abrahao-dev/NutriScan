//
//  FoodInformation.swift
//  NutriScan
//
//  Created by Mateus Andreatta on 27/09/25.
//
import Foundation

struct FoodInformation: Identifiable, Hashable, Codable {
    var id = UUID()
    let name: String
    let brand: String
    let imageUrl: URL
    let score: NumberScore
    var barcode: String?
    var fat100g: Double?
    var saturatedFat100g: Double?
    var proteins100g: Double?
    var fiber100g: Double?
    var ingredientsText: String?

    init(
        name: String,
        brand: String,
        imageUrl: URL,
        score: NumberScore,
        barcode: String? = nil,
        fat100g: Double? = nil,
        saturatedFat100g: Double? = nil,
        proteins100g: Double? = nil,
        fiber100g: Double? = nil,
        ingredientsText: String? = nil
    ) {
        self.name = name
        self.brand = brand
        self.imageUrl = imageUrl
        self.score = score
        self.barcode = barcode
        self.fat100g = fat100g
        self.saturatedFat100g = saturatedFat100g
        self.proteins100g = proteins100g
        self.fiber100g = fiber100g
        self.ingredientsText = ingredientsText
    }

    /// Chave estável para comparar produtos (favoritos/recentes),
    /// já que `id` é gerado a cada decode da API.
    var identityKey: String {
        if let barcode, !barcode.isEmpty { return barcode }
        return "\(name)|\(brand)".lowercased()
    }
}

// MARK: - Geração de InfoItems a partir dos nutrientes reais

extension FoodInformation {

    /// Monta a lista de destaques nutricionais exibida na tela de Detalhes
    /// e na comparação de produtos, com base nos valores por 100g da API.
    func makeInfoItems() -> [InfoItem] {
        var items: [InfoItem] = []

        if let fat = fat100g {
            if fat < 3.0 {
                items.append(.init(
                    icon: .system(name: .heart),
                    foregroundColor: .icon2,
                    title: "Bom para o coração",
                    subtitle: "Baixo em gordura: \(Self.format(fat))",
                    backgroundColor: .iconBackground
                ))
            } else if fat >= 17.5 {
                items.append(.init(
                    icon: .asset(name: .fat),
                    foregroundColor: nil,
                    title: "Atenção ao consumo",
                    subtitle: "Alto em gordura: \(Self.format(fat))",
                    backgroundColor: .secondary1
                ))
            } else {
                items.append(.init(
                    icon: .asset(name: .fat),
                    foregroundColor: nil,
                    title: "Gordura em nível moderado",
                    subtitle: "Gordura total: \(Self.format(fat))",
                    backgroundColor: .secondary3
                ))
            }
        }

        if let saturated = saturatedFat100g, saturated >= 5.0 {
            items.append(.init(
                icon: .asset(name: .brokenHeart),
                foregroundColor: nil,
                title: "Alto em gordura saturada",
                subtitle: "Gordura saturada: \(Self.format(saturated))",
                backgroundColor: .secondary1
            ))
        }

        if let proteins = proteins100g, proteins >= 10.0 {
            items.append(.init(
                icon: .asset(name: .muscleArm),
                foregroundColor: nil,
                title: "Construção de Ossos e Músculos",
                subtitle: "Alto em proteínas: \(Self.format(proteins))",
                backgroundColor: .secondary3
            ))
        }

        if let fiber = fiber100g, fiber >= 6.0 {
            items.append(.init(
                icon: .asset(name: .intestine),
                foregroundColor: nil,
                title: "Auxilia no funcionamento do intestino",
                subtitle: "Rico em fibras: \(Self.format(fiber))",
                backgroundColor: .secondary1
            ))
        }

        if items.isEmpty {
            items.append(.init(
                icon: .system(name: .warning),
                foregroundColor: .icon1,
                title: "Informação nutricional limitada",
                subtitle: "A base Open Food Facts não possui os nutrientes deste produto",
                backgroundColor: .primary1
            ))
        }

        return items
    }

    private static func format(_ value: Double) -> String {
        String(format: "%.1fg", value).replacingOccurrences(of: ".", with: ",")
    }
}
