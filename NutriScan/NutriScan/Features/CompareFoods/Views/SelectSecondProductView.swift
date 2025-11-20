//
//  SelectSecondProductView.swift
//  NutriScan
//
//  Created by Rapha Vidal on 23/10/25.
//
import SwiftUI

struct SelectSecondProductView: View {
    @ObservedObject var viewModel: CompareFoodsViewModel
    
    @State private var isScanLinkActive = false
    @State private var isSearchLinkActive = false
    
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
            
            NavigationLink(
                destination: ScanSecondProductView(
                    compareViewModel: viewModel,
                    isLinkActive: $isScanLinkActive
                ),
                isActive: $isScanLinkActive
            ) {
                Label("Escanear Produto", systemImage: "barcode.viewfinder")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            NavigationLink(
                destination: SearchSecondProductView(
                    compareViewModel: viewModel,
                    isLinkActive: $isSearchLinkActive
                )
            ) {
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
    
    @Binding var isLinkActive: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            
            ProductSummaryCard(product: compareViewModel.productOne)
            
            List(searchViewModel.filteredProducts) { foodInfo in
                Button(action: {
                    compareViewModel.setProductForComparison(foodInfo)
                    self.isLinkActive = false
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
    @Binding var isLinkActive: Bool
    
    @StateObject private var delegate = ScanDelegate()
    
    var body: some View {
        VStack(spacing: 0) {
            
            ProductSummaryCard(product: compareViewModel.productOne)
                .frame(maxHeight: 120)
            
            ScanViewControllerWrapper(delegate: delegate, isLinkActive: $isLinkActive)
                .ignoresSafeArea(.container, edges: .bottom)
            
            if delegate.isLoading {
                VStack {
                    Spacer()
                    ProgressView("Buscando produto...")
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            } else if delegate.errorMessage != nil {
                // ... (Sua lógica para mostrar o erro e a opção de digitar manualmente)
                Text(delegate.errorMessage ?? "Erro Desconhecido")
                    .foregroundColor(.red)
            }
        }
        .onReceive(delegate.$foundProduct) { product in
            guard let product = product else { return }
            
            compareViewModel.setProductForComparison(product)
            
            isLinkActive = false
        }
        .navigationTitle("Escanear Produto")
        .navigationBarTitleDisplayMode(.inline)
    }
}
