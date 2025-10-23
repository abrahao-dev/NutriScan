//
//  Untitled.swift
//  NutriScan
//
//  Created by Rapha Vidal on 23/10/25.
//

import SwiftUI

struct SearchFoodView: View {
    @StateObject private var viewModel = SearchFoodsViewModel()
    
    var body: some View {
        List(viewModel.filteredProducts) { foodInfo in
            NavigationLink(
                destination:
                    DetailsViewControllerWrapper(foodInfo: foodInfo)
                    .ignoresSafeArea()
                    .navigationTitle("Detalhes do Produto")
                    .navigationBarTitleDisplayMode(.inline)
            ){
                FoodInformationItemView(foodInformation: foodInfo)
            }
            .listRowInsets(EdgeInsets())
        }
        .padding(.horizontal)
        .listStyle(.plain)
        .navigationTitle("Busca")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchText, prompt: viewModel.prompt)
    }
}

#Preview {
    SearchFoodView()
}
