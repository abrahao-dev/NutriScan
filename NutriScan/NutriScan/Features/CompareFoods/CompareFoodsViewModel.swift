//
//  CompareFoodsViewModel.swift
//  NutriScan
//
//  Created by Rapha Vidal on 23/10/25.
//

import Foundation
import Combine

class CompareFoodsViewModel: ObservableObject {
    @Published var productOne: FoodInformation
    @Published var productTwo: FoodInformation?
    
    var isReadyForComparison: Bool {
        productTwo != nil
    }
    
    init(productOne: FoodInformation) {
        self.productOne = productOne
        self.productTwo = nil
    }
    
    // Chamado pela tela de Scan ou Busca quando um produto é selecionado.
    func setProductForComparison(_ food: FoodInformation) {
        DispatchQueue.main.async {
            self.productTwo = food
        }
    }
    
    // remover o segundo produto e escolher outro (voltar para o Scan/Busca).
    func removeProductForComparison() {
        DispatchQueue.main.async {
            self.productTwo = nil
        }
    }
    
    // Trocar o produto "A" pelo "B"
    func swapProducts() {
        guard let productTwo = self.productTwo else { return }
        
        let tempProduct = self.productOne
        
        DispatchQueue.main.async {
            self.productOne = productTwo
            self.productTwo = tempProduct
        }
    }
}
