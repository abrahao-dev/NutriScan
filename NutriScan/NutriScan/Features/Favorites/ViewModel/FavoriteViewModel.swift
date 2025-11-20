//
//  FavoriteViewModel.swift
//  NutriScan
//
//  Created by Elena Diniz on 11/14/25.
//

import Foundation
import Combine

final class FavoriteViewModel: ObservableObject {
    
    @Published private(set) var allFoods: [FoodInformation] = []
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        allFoods = [
            FoodInformation(
                name: "Leite condensado",
                brand: "Italac",
                imageUrl: URL(string: "https://placehold.co/60?text=Leite")!,
                score: .scoreE
            ),
            FoodInformation(
                name: "Iogurte Grego",
                brand: "Vigor",
                imageUrl: URL(string: "https://placehold.co/60?text=Iogurte")!,
                score: .scoreB
            ),
            FoodInformation(
                name: "Peito de Frango",
                brand: "Sadia",
                imageUrl: URL(string: "https://placehold.co/60?text=Frango")!,
                score: .scoreA
            ),
            FoodInformation(
                name: "Bolacha Recheada",
                brand: "Oreo",
                imageUrl: URL(string: "https://placehold.co/60?text=Bolacha")!,
                score: .scoreE
            ),
            FoodInformation(
                name: "Arroz Integral",
                brand: "Tio João",
                imageUrl: URL(string: "https://placehold.co/60?text=Arroz")!,
                score: .scoreA
            ),
            FoodInformation(
                name: "Atum em Óleo",
                brand: "Coqueiro",
                imageUrl: URL(string: "https://placehold.co/60?text=Atum")!,
                score: .scoreC
            )
        ]
    }
}

