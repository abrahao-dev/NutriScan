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
        List {
            ForEach(viewModel.filteredProducts) { foodInfo in
                Button {
                    selectedItem = foodInfo
                } label: {
                    FoodInformationItemView(foodInformation: foodInfo)
                }
            }
            
            if let errorMessage = viewModel.errorMessage {
                VStack(spacing: 8) {
                    Image(systemName: "wifi.exclamationmark")
                        .font(.title)
                        .foregroundColor(.secondary)
                    Text(errorMessage)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    Button("Tentar novamente") {
                        viewModel.searchText.isEmpty
                            ? viewModel.fetchInitialProducts()
                            : viewModel.search(query: viewModel.searchText)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
            } else if viewModel.filteredProducts.isEmpty &&
                !viewModel.searchText.isEmpty &&
                !viewModel.isLoading {
                EmptyStateComponentView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
            }
        }
        .listStyle(.plain)
        .sheet(item: $selectedItem) { item in
            DetailsView(foodInfo: item)
        }
        .overlay(
            Group {
                if viewModel.isLoading {
                    ProgressView("Buscando produtos...")
                        .padding()
                        .background(Color.secondary.opacity(0.6))
                        .cornerRadius(10)
                }
            }
        )
        .navigationTitle("Busca")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: viewModel.prompt)
    }
}

#Preview {
    SearchFoodView()
}
