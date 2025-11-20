//
//  InitialScanView.swift
//  NutriScan
//
//  Created by Rapha Vidal on 19/11/25.
//
import SwiftUI

struct InitialScanView: View {
    
    @State private var isDetailsLinkActive = false
    
    @State private var scannedProduct: FoodInformation? = nil
    
    @StateObject private var delegate = ScanDelegate()
    
    private var placeholderProduct: FoodInformation {
        guard let url = URL(string: "https://placehold.co/60") else {
            
            return FoodInformation(
                name: "Produto Padrão",
                brand: "Erro N/A",
                imageUrl: URL(string: "about:blank")!,
                score: .scoreE
            )
        }
        
        return FoodInformation(
            name: "Produto Padrão",
            brand: "N/A",
            imageUrl: url,
            score: .scoreE
        )
    }
    
    var body: some View {
        
        NavigationLink(
            destination: DetailsViewControllerWrapper(
                foodInfo: scannedProduct ?? placeholderProduct
            ),
            isActive: $isDetailsLinkActive
        ) {
            EmptyView()
        }
        
        ScanViewControllerWrapper(delegate: delegate)
            .onReceive(delegate.$foundProduct) { product in
                guard let product = product else { return }
                
                scannedProduct = product
                isDetailsLinkActive = true
            }
    }
}
