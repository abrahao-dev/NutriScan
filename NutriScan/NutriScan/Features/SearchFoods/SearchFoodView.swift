//
//  Untitled.swift
//  NutriScan
//
//  Created by Rapha Vidal on 23/10/25.
//

import SwiftUI

struct SearchFoodView: View {
    @StateObject private var viewModel = SearchFoodsViewModel()
    
    let title: String = "Busca"
    
    var body: some View {
        List(viewModel.filteredProducts) { foodInfo in
            FoodInformationItemView(foodInformation: foodInfo)
                .listRowInsets(EdgeInsets())
        }
        .listStyle(.plain)
        .navigationTitle("Busca")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchText, prompt: viewModel.prompt)
    }
}

#Preview {
    SearchFoodView()
}
