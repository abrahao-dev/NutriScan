//
//  OpenFoodFactsResponse.swift
//  NutriScan
//
//  Created by Rapha Vidal on 19/11/25.
//

struct OpenFoodFactsResponse: Decodable, Sendable {
    let products: [ProductAPI]
    
}

struct ProductAPI: Decodable, Sendable {
    let code: String?
    let product_name: String?
    let brands: String?
    let image_url: String?
    let nutrition_grades: String?
    let nutriments: NutrimentsAPI?
    let ingredients_text: String?
    
    
    enum CodingKeys: String, CodingKey {
        case code, product_name, brands, image_url, nutrition_grades
        case nutriments, ingredients_text
    }
}

struct NutrimentsAPI: Decodable, Sendable {
    let fat_100g: Double?
    let saturated_fat_100g: Double?
    let proteins_100g: Double?
    let fiber_100g: Double?
    
    enum CodingKeys: String, CodingKey {
        case fat_100g
        case saturated_fat_100g = "saturated-fat_100g"
        case proteins_100g
        case fiber_100g
    }
}
