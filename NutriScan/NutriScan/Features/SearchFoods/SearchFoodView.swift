//
//  Untitled.swift
//  NutriScan
//
//  Created by Rapha Vidal on 23/10/25.
//

import SwiftUI

struct SearchFoodView: View {
    @StateObject private var viewModel = SearchFoodsViewModel()
    @State private var selectedItem: FoodInformation?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.filteredProducts) { foodInfo in
                    Button {
                        selectedItem = foodInfo
                    } label: {
                        FoodInformationItemView(foodInformation: foodInfo)
                    }
        Group {
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
        .sheet(item: $selectedItem) { item in
            DetailsView(foodInfo: item)
        }
            
            if viewModel.filteredProducts.isEmpty &&
                !viewModel.searchText.isEmpty &&
                !viewModel.isLoading {
                EmptyStateComponentView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
            }
        }
        .overlay(
            Group {
                if viewModel.isLoading {
                    ProgressView("Buscando produtos...")
                        .padding()
                        .background(Color.secondary.opacity(0.8))
                        .cornerRadius(10)
                }
            }
        )
        .navigationTitle("Busca")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchText, prompt: viewModel.prompt)
    }
}

#Preview {
    SearchFoodView()
}
