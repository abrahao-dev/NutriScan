//
//  ErrorOverlay.swift
//  NutriScan
//
//  Created by Rapha Vidal on 20/11/25.
//

import SwiftUI

struct ErrorOverlay: View {
    let errorMessage: String
    let onRestart: () -> Void
    let onManualEntry: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("⚠️ Produto Não Encontrado").font(.title3).fontWeight(.bold)
            Text(errorMessage).font(.subheadline).multilineTextAlignment(.center).padding(.horizontal)
            
            Button("Escanear Novamente") { onRestart() }
                .buttonStyle(.borderedProminent).tint(.red)
            
            // Opcional: Se quiser manter o botão manual no erro, use este bloco:
            /*
            Button("Digitar Código Manualmente") { onManualEntry() }
                .buttonStyle(.borderedProminent).tint(.blue)
            */
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.9))
        .foregroundColor(.white)
        .ignoresSafeArea()
    }
}
