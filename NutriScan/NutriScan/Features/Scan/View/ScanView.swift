//
//  InitialScanView.swift
//  NutriScan
//
//  Created by Rapha Vidal on 19/11/25.
//

import SwiftUI

struct ScanView: View {
    
    var onProductFound: (FoodInformation) -> Void
    var onNavigationCompleted: () -> Void
    var productOne: FoodInformation?
    
    @StateObject private var delegate = ScanDelegate()
    @State private var isManualEntryActive = false
    
    var body: some View {
        ZStack {
            
            ScanViewControllerWrapper(delegate: delegate, isLinkActive: $isManualEntryActive)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                if let productOne = productOne {
                    ProductSummaryCard(product: productOne)
                }
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
            
            if delegate.isLoading {
                ProgressView("Carregando...")
                
            } else if let errorMessage = delegate.errorMessage {
                ErrorOverlay(
                    errorMessage: errorMessage,
                    onRestart: delegate.restartScan,
                    onManualEntry: delegate.startManualEntry
                )
            }
            
            NavigationLink(
                destination: ManualBarcodeEntryView(),
                isActive: $isManualEntryActive
            ) { EmptyView() }.hidden()
    
        }
        .onReceive(delegate.$foundProduct) { product in
            guard let product = product else { return }
            
            onProductFound(product)
            onNavigationCompleted()
        }
        .onReceive(delegate.$isShowingManualEntry) { isIntent in
            if isIntent { isManualEntryActive = true }
        }
        .navigationTitle(productOne == nil ? "Escanear" : "Escanear Produto")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Digitar") {
                    delegate.startManualEntry()
                }
            }
        }
    }
}
