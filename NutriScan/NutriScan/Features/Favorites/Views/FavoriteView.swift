//
//  FavoriteView.swift
//  NutriScan
//
//  Created by Elena Diniz on 11/14/25.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject private var viewModel = FavoriteViewModel()
    @State private var selectedItem: FoodInformation?
    
    var body: some View {
        Group {
            if viewModel.allFoods.isEmpty {
                VStack(spacing: 12) {
                    EmptyStateComponentView()
                    Text("Nenhum favorito ainda.\nEscaneie ou busque um produto e toque em \"Salvar nos Favoritos\".")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(viewModel.allFoods) { foodInfo in
                        Button {
                            selectedItem = foodInfo
                        } label: {
                            FoodInformationItemView(foodInformation: foodInfo)
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.map { viewModel.allFoods[$0] }.forEach(viewModel.remove)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Favoritos")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $selectedItem) { item in
            DetailsView(foodInfo: item)
        }
    }
}

#Preview {
    FavoriteView()
}
