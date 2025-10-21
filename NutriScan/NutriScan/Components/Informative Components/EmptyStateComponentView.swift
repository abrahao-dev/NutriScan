//
//  Untitled.swift
//  NutriScan
//
//  Created by Matheus Abrahao Martins Alvares on 29/09/25.
//

import SwiftUI

struct EmptyStateComponentView: View {
    var imageName: String = "cart"   // pode trocar para "empty_basket" se tiver no Assets
    var title: String = "Nenhum resultado encontrado"

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: imageName) // ou Image("empty_basket")
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72)
                .foregroundColor(.secondary)

            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    EmptyStateComponentView()
        .padding()
}
