//
//  SearchFoodsViewModel.swift
//  NutriScan
//
//  Created by Rapha Vidal on 23/10/25.
//

import Foundation
import Combine

class SearchFoodsViewModel: ObservableObject {
    @Published var filteredProducts: [FoodInformation] = []
    @Published var searchText = ""
    @Published var isLoading = false
    
    private var service = OpenFoodFactsService()
    private var cancellables = Set<AnyCancellable>()
    
    let prompt: String = "Digite o nome ou marca"
    
    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                
                if query.count > 2 {
                    self.search(query: query)
                } else if query.isEmpty {
                    self.fetchInitialProducts()
                } else {
                    self.filteredProducts = []
                }
            }
            .store(in: &cancellables)
        
        fetchInitialProducts()
    }
    
    func fetchInitialProducts() {
            let defaultQuery = ""
            
            self.isLoading = true
            
            service.searchProducts(query: defaultQuery) { [weak self] result in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    switch result {
                    case .success(let products):
                        self?.filteredProducts = products
                    case .failure(let error):
                        print("Erro ao carregar produtos iniciais: \(error.localizedDescription)")
                        self?.filteredProducts = []
                    }
                }
            }
        }
    
    func search(query: String) {
        guard !query.isEmpty else {
            self.filteredProducts = []
            return
        }
        
        self.isLoading = true
        
        service.searchProducts(query: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let products):
                    self?.filteredProducts = products
                case .failure(let error):
                    print("Erro ao buscar API: \(error.localizedDescription)")
                    self?.filteredProducts = []
                }
            }
        }
    }
}
