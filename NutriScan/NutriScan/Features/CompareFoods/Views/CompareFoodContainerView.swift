//
//  CompareFoodRootView.swift
//  NutriScan
//
//  Created by Rapha Vidal on 23/10/25.
//

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
            List(viewModel.filteredProducts) { foodInfo in
                Button(action: {
                    onSelected(foodInfo)
                }) {
                    FoodInformationItemView(foodInformation: foodInfo)
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
