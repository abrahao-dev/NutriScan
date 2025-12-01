//
//  ProfileRootView.swift
//  NutriScan
//
//  Created by Eder Junior Alves Silva on 22/10/25.
//

import SwiftUI

struct ScanRootView: View {
    @State private var isDetailsLinkActive = false
    @State private var scannedProduct: FoodInformation? = nil
    
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
        VStack {
            NavigationLink(
                destination: DetailsViewControllerWrapper(foodInfo: scannedProduct ?? placeholderProduct),
                isActive: $isDetailsLinkActive
            ) { EmptyView() }.hidden()
            
            ScanView(
                onProductFound: { product in
                    scannedProduct = product
                    isDetailsLinkActive = true
                },
                onNavigationCompleted: {
                }
            )
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ScanRootView()
}
