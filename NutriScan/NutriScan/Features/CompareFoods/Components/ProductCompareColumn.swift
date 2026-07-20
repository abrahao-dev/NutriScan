//
//  ProductCompareColumn.swift
//  NutriScan
//
//  Created by Rapha Vidal on 23/10/25.
//
import SwiftUI

struct ProductCompareColumn: View {
    
    let product: FoodInformation
    var isSecondProduct: Bool = false
    var onRemove: (() -> Void)?
    
    // InfoItems gerados a partir dos nutrientes reais do produto
    private var infoItems: [InfoItem] {
        product.makeInfoItems()
    }

    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: product.imageUrl) { $0.resizable().scaledToFit() }
                placeholder: { Color.gray.opacity(0.1) }
                .frame(height: 100)
            
            Text(product.name)
                .font(.headline)
                .multilineTextAlignment(.center)
            Text(product.brand)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(infoItems, id: \.title) { item in
                    HStack {
                        IconCircleView(
                            icon: item.icon,
                            backgroundColor: item.backgroundColor,
                            foregroundColor: item.foregroundColor
                        )
                        .frame(width: 44, height: 44)

                        VStack(alignment: .leading) {
                            Text(item.title).font(.caption.bold())
                            Text(item.subtitle).font(.caption2)
                        }
                    }
                }
            }
            
            NutriScoreView(selectedScore: product.score)
            
            // Botão de Favoritos (Lógica mockada)
            
            
            // Botão de Remover (só aparece para o produto 2)
            if let onRemove = onRemove {
                Button(action: onRemove) {
                    Text("Remover Produto")
                        .font(.caption)
                }
                .tint(.red)
            } else {
                // Espaçador para manter a altura igual
                Button("") {}.font(.caption).hidden()
            }
        }
    }
}
