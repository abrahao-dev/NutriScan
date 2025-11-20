//
//  DetailsView.swift
//  NutriScan
//
//  Created by Elena Diniz on 11/17/25.
//

import SwiftUI

struct DetailsView: View {
    @State var foodInfo: FoodInformation
    
    var body: some View {
        NavigationView {
            DetailsViewControllerWrapper(foodInfo: foodInfo)
                .navigationTitle("Detalhes do Produto")
                .navigationBarTitleDisplayMode(.inline)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    var foodInfo: FoodInformation = .init(name: "Leite Condensado", brand: "Italac", imageUrl: URL(string: "https://placehold.co/60?text=Leite")!, score: .scoreD)
    DetailsView(foodInfo: foodInfo)
}
