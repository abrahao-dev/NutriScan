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
    @Published var isShowingManualEntry = false
    
    private let service = OpenFoodFactsService()
    
    var restartScanAction: (() -> Void)?
    
    func handleBarcode(_ barcode: String) {
        guard !isLoading else { return }
        errorMessage = nil
        isLoading = true
        
        service.fetchProduct(barcode: barcode) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let foodInfo):
                    self?.foundProduct = foodInfo
                case .failure(let error):
                    self?.errorMessage = "Não foi possível encontrar o produto com o código \(barcode). Tente digitar manualmente ou escanear novamente."
                    print("Erro API Barcode: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func restartScan() {
        errorMessage = nil
        restartScanAction?()
    }
    
    func startManualEntry() {
        self.errorMessage = nil
        self.isShowingManualEntry = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.isShowingManualEntry = false
        }
    }
}
