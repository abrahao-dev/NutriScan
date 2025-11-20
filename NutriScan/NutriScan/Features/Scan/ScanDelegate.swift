//
//  ScanDelegat.swift
//  NutriScan
//
//  Created by Rapha Vidal on 19/11/25.
//

import Combine
import SwiftUI

class ScanDelegate: ObservableObject {
    @Published var foundProduct: FoodInformation?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service = OpenFoodFactsService()
    
    // AÇÃO QUE A API CHAMA
    func handleBarcode(_ barcode: String) {
        guard !isLoading else { return }
        errorMessage = nil
        isLoading = true
        
        service.fetchProduct(barcode: barcode) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let foodInfo):
                    self?.foundProduct = foodInfo // Isso aciona o .onReceive na View
                case .failure(let error):
                    self?.errorMessage = "Não foi possível encontrar o produto com o código \(barcode)."
                    print("Erro API Barcode: \(error.localizedDescription)")
                }
            }
        }
    }
}
