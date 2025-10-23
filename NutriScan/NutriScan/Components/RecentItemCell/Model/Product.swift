//
//  Product.swift
//  NutriScan
//
//  Created by Eder Junior Alves Silva on 23/10/25.
//

import Foundation

struct Product {
    let id: UUID = UUID()
    let name: String
    let brand: String
    let imageName: String
    let score: NumberScore
}

// Dados de exemplo para a CollectionView
struct MockData {
    static let recentProducts: [Product] = [
        Product(name: "Leite cond. light",
                brand: "Piracanjuba",
                imageName: "leaf.fill",
                score: .scoreB),
        Product(name: "Leite condensado",
                brand: "Italac",
                imageName: "leaf.fill",
                score: .scoreD),
        Product(name: "Iogurte Grego",
                brand: "Vigor",
                imageName: "leaf.fill",
                score: .scoreA),
        Product(name: "Refrigerante",
                brand: "Coca-Cola",
                imageName: "leaf.fill",
                score: .scoreE)
    ]
}
