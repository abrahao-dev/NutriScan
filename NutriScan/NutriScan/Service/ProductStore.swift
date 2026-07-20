//
//  ProductStore.swift
//  NutriScan
//
//  Camada de persistência local de Favoritos e Recentes,
//  usando UserDefaults + JSON (Codable).
//

import Foundation
import Combine

extension Notification.Name {
    static let productStoreDidChange = Notification.Name("productStoreDidChange")
}

final class ProductStore: ObservableObject {

    static let shared = ProductStore()

    @Published private(set) var favorites: [FoodInformation] = []
    @Published private(set) var recents: [FoodInformation] = []

    private let defaults: UserDefaults
    private let favoritesKey = "nutriscan.favorites"
    private let recentsKey = "nutriscan.recents"
    private let maxRecents = 10

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        favorites = load(key: favoritesKey)
        recents = load(key: recentsKey)
    }

    // MARK: - Favoritos

    func isFavorite(_ food: FoodInformation) -> Bool {
        favorites.contains { $0.identityKey == food.identityKey }
    }

    /// Adiciona ou remove dos favoritos. Retorna o novo estado (true = favoritado).
    @discardableResult
    func toggleFavorite(_ food: FoodInformation) -> Bool {
        if let index = favorites.firstIndex(where: { $0.identityKey == food.identityKey }) {
            favorites.remove(at: index)
            persist(favorites, key: favoritesKey)
            return false
        } else {
            favorites.insert(food, at: 0)
            persist(favorites, key: favoritesKey)
            return true
        }
    }

    // MARK: - Recentes

    /// Registra um produto visualizado. Remove duplicatas e limita a lista.
    func addRecent(_ food: FoodInformation) {
        recents.removeAll { $0.identityKey == food.identityKey }
        recents.insert(food, at: 0)
        if recents.count > maxRecents {
            recents = Array(recents.prefix(maxRecents))
        }
        persist(recents, key: recentsKey)
    }

    // MARK: - Persistência

    private func load(key: String) -> [FoodInformation] {
        guard let data = defaults.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([FoodInformation].self, from: data)) ?? []
    }

    private func persist(_ foods: [FoodInformation], key: String) {
        if let data = try? JSONEncoder().encode(foods) {
            defaults.set(data, forKey: key)
        }
        NotificationCenter.default.post(name: .productStoreDidChange, object: self)
    }
}
