//
//  Product.swift
//  NutriScan
//
//  Created by Eder Junior Alves Silva on 23/10/25.
//

import Foundation

struct Product {
    let id: UUID = UUID()
    let name: String
    let brand: String
    let imageName: String
    let score: NumberScore
}
