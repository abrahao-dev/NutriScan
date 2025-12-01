//
//  FoodInformationItemView.swift
//  NutriScan
//
//  Created by Mateus Andreatta on 27/09/25.
//

import SwiftUI

struct FoodInformationItemView: View {
    
    let foodInformation: FoodInformation
    
    var body: some View {
        HStack {
            AsyncImage(url: foodInformation.imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color(.systemGray5))
            }
            .frame(width: 60, height: 60)
            .clipped()
            .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(foodInformation.name)
                    .foregroundStyle(.neutralColor1)
                Text(foodInformation.brand)
                    .foregroundStyle(.neutralColor2)
            }
            
            Spacer()
            
            NumberScoreView(numberScore: foodInformation.score)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

#Preview {
    guard let url = URL(string: "https://placehold.co/60") else { return EmptyView() }
    let foodInformation = FoodInformation(
        name: "Leite condensado",
        brand: "Italac",
        imageUrl: url,
        score: .scoreE
    )
    return FoodInformationItemView(foodInformation: foodInformation)
}
