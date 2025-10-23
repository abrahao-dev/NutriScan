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
    
    let mockInfoItems: [InfoItem] = [
        .init(icon: .system(name: .heart), foregroundColor: .icon2,  title: "Bom para o coração", subtitle: "Baixo em gordura: 2,80g", backgroundColor: .iconBackground),
        .init(icon: .asset(name: .muscleArm), foregroundColor: nil, title: "Construção de Ossos e Músculos", subtitle: "Alto em proteínas: 14g", backgroundColor: .secondary3)
    ]
    
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
                // TODO: Você precisa buscar os InfoItems reais do produto
                // Esta é uma recriação simplificada do seu layout
                // Você deve usar seu 'DetailsView' ou sua lógica aqui
                ForEach(mockInfoItems, id: \.title) { item in
                    HStack {
                        // TODO: Reconstrua sua IconCircleView aqui
                        Image(systemName: "heart.fill") // Placeholder
                            .foregroundColor(item.foregroundColor)
                            .padding(8)
                            .background(item.backgroundColor)
                            .clipShape(Circle())
                        
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
