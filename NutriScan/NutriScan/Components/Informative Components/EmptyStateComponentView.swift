//
//  Untitled.swift
//  NutriScan
//
//  Created by Matheus Abrahao Martins Alvares on 29/09/25.
//

import SwiftUI

struct EmptyStateComponentView: View {
    var imageName: String = "basket.fill"
    var title: String = "Nenhum resultado encontrado"

    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72)
                .foregroundColor(.neutralColor3)
                .opacity(0.4)

            Text(title)
                .font(.regular24)
                .multilineTextAlignment(.center)
                .foregroundStyle(.neutralColor2)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    EmptyStateComponentView()
        .padding()
}
