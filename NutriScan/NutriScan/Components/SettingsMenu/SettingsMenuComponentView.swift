//
//  SettingsMenuComponentView.swift
//  NutriScan
//
//  Created by Matheus Abrahao Martins Alvares on 29/09/25.
//

import SwiftUI

struct SettingsMenuComponentView: View {
    var body: some View {
        VStack(spacing: 0) {
            SettingsMenuItem(icon: "person.fill", title: "Perfil")
            SettingsMenuItem(icon: "heart.fill", title: "Salvos")
            SettingsMenuItem(icon: "gearshape.fill", title: "Configurações")
            SettingsMenuItem(icon: "arrow.right.square.fill", title: "Sair")
        }
        .padding(.horizontal, 16) // dá um respiro nas laterais
    }
}

struct SettingsMenuItem: View {
    var icon: String
    var title: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28) // maior, mais próximo ao Figma
                .foregroundColor(Color(red: 1.0, green: 0.45, blue: 0.40)) // coral do Figma
            
            Text(title)
                .foregroundColor(Color(red: 0.29, green: 0.29, blue: 0.29)) // cinza escuro
                .font(.system(size: 16, weight: .regular))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 8)
    }
}

#Preview {
    SettingsMenuComponentView()
}

