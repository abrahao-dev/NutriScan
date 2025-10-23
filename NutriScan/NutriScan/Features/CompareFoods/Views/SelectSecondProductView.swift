//
//  SelectSecondProductView.swift
//  NutriScan
//
//  Created by Rapha Vidal on 23/10/25.
//
import SwiftUI

struct SelectSecondProductView: View {
    @ObservedObject var viewModel: CompareFoodsViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Selecione o segundo produto")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Você está comparando com:")
                .font(.headline)
            
            FoodInformationItemView(foodInformation: viewModel.productOne)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
            
            Spacer()
            
            NavigationLink(destination: ScanSecondProductView(compareViewModel: viewModel)) {
                Label("Escanear Produto", systemImage: "barcode.viewfinder")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            NavigationLink(destination: SearchSecondProductView(compareViewModel: viewModel)) {
                Label("Buscar Produto", systemImage: "magnifyingglass")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.accentColor)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            Spacer()
        }
        .padding(.top, 40)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SearchSecondProductView: View {
    @StateObject private var searchViewModel = SearchFoodsViewModel()
    
    @ObservedObject var compareViewModel: CompareFoodsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            ProductSummaryCard(product: compareViewModel.productOne)
            
            List(searchViewModel.filteredProducts) { foodInfo in
                Button(action: {
                    compareViewModel.setProductForComparison(foodInfo)
                }) {
                    FoodInformationItemView(foodInformation: foodInfo)
                        .foregroundColor(.primary)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
        }
        .navigationTitle("Buscar Produto")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchViewModel.searchText, prompt: searchViewModel.prompt)
    }
}

struct ProductSummaryCard: View {
    
    let product: FoodInformation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Comparando com:")
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack {
                AsyncImage(url: product.imageUrl) { $0.resizable().scaledToFit() }
                    placeholder: { Color.gray.opacity(0.1) }
                    .frame(width: 30, height: 30)
                    .cornerRadius(4)
                
                VStack(alignment: .leading) {
                    Text(product.name).font(.subheadline).bold()
                    Text(product.brand).font(.caption).foregroundColor(.secondary)
                }
                Spacer()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray5))
    }
}

struct ScanSecondProductView: View {
    
    @ObservedObject var compareViewModel: CompareFoodsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            ProductSummaryCard(product: compareViewModel.productOne)
            Spacer()
            
            Text("ScannerView")
            Spacer()
            
            Button("Simular Scan (Oreo)") {
                let oreo = FoodInformation(name: "Bolacha Recheada", brand: "Oreo", imageUrl: URL(string: "https://placehold.co/60?text=Bolacha")!, score: .scoreE)
                
                compareViewModel.setProductForComparison(oreo)
            }
            .padding()
        }
        .navigationTitle("Escanear Produto")
        .navigationBarTitleDisplayMode(.inline)
    }
}
