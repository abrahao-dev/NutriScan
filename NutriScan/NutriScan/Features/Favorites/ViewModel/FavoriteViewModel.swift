//
//  FavoriteViewModel.swift
//  NutriScan
//
//  Created by Elena Diniz on 11/14/25.
//

import Foundation
import Combine

final class FavoriteViewModel: ObservableObject {

    @Published private(set) var allFoods: [FoodInformation] = []

    private let store: ProductStore
    private var cancellables = Set<AnyCancellable>()

    init(store: ProductStore = .shared) {
        self.store = store

        // Reflete os favoritos persistidos e reage a qualquer mudança
        store.$favorites
            .receive(on: DispatchQueue.main)
            .sink { [weak self] favorites in
                self?.allFoods = favorites
            }
            .store(in: &cancellables)
    }

    func remove(_ food: FoodInformation) {
        store.toggleFavorite(food)
    }
}
