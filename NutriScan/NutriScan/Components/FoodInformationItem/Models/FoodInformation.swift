//
//  FoodInformation.swift
//  NutriScan
//
//  Created by Mateus Andreatta on 27/09/25.
//
import Foundation

struct FoodInformation: Identifiable, Hashable {
    var id = UUID()
    let name: String
    let brand: String
    let imageUrl: URL
    let score: NumberScore
}
