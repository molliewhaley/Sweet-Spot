//
//  DessertsModel.swift
//  SweetSpot
//
//  Created by Mollie Whaley on 11/7/23.
//

struct Desserts: Codable, Hashable {
    let meals: [DessertInfo]
}

struct DessertInfo: Codable, Hashable {
    let name: String
    let image: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case image = "strMealThumb"
        case id = "idMeal"
    }
}
