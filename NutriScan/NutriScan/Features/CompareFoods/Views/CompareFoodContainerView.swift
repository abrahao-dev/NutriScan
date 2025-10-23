//
//  CompareFoodRootView.swift
//  NutriScan
//
//  Created by Rapha Vidal on 23/10/25.
//

import SwiftUI

import SwiftUI

struct CompareFoodContainerView: View {
    @StateObject private var viewModel: CompareFoodsViewModel
    
    init(productOne: FoodInformation) {
        _viewModel = StateObject(wrappedValue: CompareFoodsViewModel(productOne: productOne))
    }
    
    var body: some View {
        
        if viewModel.isReadyForComparison {
            CompareFoodView(viewModel: viewModel)
        } else {
            SelectSecondProductView(viewModel: viewModel)
        }
    }
}

struct SearchFoodViewWithCallback: View {
    
    @StateObject private var viewModel = SearchFoodsViewModel()
    
    var onSelected: (FoodInformation) -> Void
    
    var body: some View {
        NavigationView {
            List(viewModel.filteredProducts) { foodInfo in
                // Em vez de NavigationLink, usamos um Button
                Button(action: {
                    // Chama o callback com o produto selecionado
                    onSelected(foodInfo)
                }) {
                    // Reutiliza sua view de item
                    FoodInformationItemView(foodInformation: foodInfo)
                        // Botões dentro de Listas podem mudar a cor
                        // do texto, então forçamos a cor primária.
                        .foregroundColor(.primary)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
            .navigationTitle("Buscar Produto")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchText, prompt: viewModel.prompt)
        }
    }
}

struct ScannerViewPlaceholder: View {
    var onFound: (FoodInformation) -> Void
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 20) {
            Text("Scanner Placeholder")
            Button("Simular Scan (Oreo)") {
                let oreo = FoodInformation(name: "Bolacha Recheada", brand: "Oreo", imageUrl: URL(string: "https://placehold.co/60?text=Bolacha")!, score: .scoreE)
                onFound(oreo)
            }
            Button("Cancelar") { dismiss() }
        }
    }
}
