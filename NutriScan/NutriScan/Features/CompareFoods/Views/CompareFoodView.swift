//
//  CompareFoodView.swift
//  NutriScan
//
//  Created by Rapha Vidal on 23/10/25.
//
import SwiftUI

struct CompareFoodView: View {
    
    @ObservedObject var viewModel: CompareFoodsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .top, spacing: 16) {
                    ProductCompareColumn(product: viewModel.productOne, onRemove: nil)
                    
                    if let productTwo = viewModel.productTwo {
                        ProductCompareColumn(
                            product: productTwo,
                            onRemove: {
                                viewModel.removeProductForComparison()
                            }
                        )
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Comparação")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.swapProducts()
                }) {
                    Image(systemName: "arrow.left.arrow.right.circle")
                }
            }
        }
    }
}
