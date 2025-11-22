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
        List {
            ForEach(viewModel.allFoods) { foodInfo in
                Button {
                    selectedItem = foodInfo
                } label: {
                    FoodInformationItemView(foodInformation: foodInfo)
                }
            }
        }
        .listStyle(.plain)
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
