//
//  SearchFoodsViewModel.swift
//  NutriScan
//
//  Created by Rapha Vidal on 23/10/25.
//

import Foundation
import Combine

class SearchFoodsViewModel: ObservableObject {
    @Published var allFoods: [FoodInformation] = []
    
    @Published var searchText = ""
    
    let prompt: String = "Digite o nome ou marca"
    
    var filteredProducts: [FoodInformation] {
        if searchText.isEmpty {
            return allFoods
        } else {
            return allFoods.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.brand.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    init() {
        loadMockData()
    }
    
    func loadMockData() {
        self.allFoods = [
            FoodInformation(name: "Leite condensado", brand: "Italac", imageUrl: URL(string: "https://placehold.co/60?text=Leite")!, score: .scoreE),
            FoodInformation(name: "Iogurte Grego", brand: "Vigor", imageUrl: URL(string: "https://placehold.co/60?text=Iogurte")!, score: .scoreB),
            FoodInformation(name: "Peito de Frango", brand: "Sadia", imageUrl: URL(string: "https://placehold.co/60?text=Frango")!, score: .scoreA),
            FoodInformation(name: "Bolacha Recheada", brand: "Oreo", imageUrl: URL(string: "https://placehold.co/60?text=Bolacha")!, score: .scoreE),
            FoodInformation(name: "Arroz Integral", brand: "Tio João", imageUrl: URL(string: "https://placehold.co/60?text=Arroz")!, score: .scoreA),
            FoodInformation(name: "Atum em Óleo", brand: "Coqueiro", imageUrl: URL(string: "https://placehold.co/60?text=Atum")!, score: .scoreC)
        ]
    }
}
