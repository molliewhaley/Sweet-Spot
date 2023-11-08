//
//  DessertsClient.swift
//  SweetSpot
//
//  Created by Mollie Whaley on 11/7/23.
//

import Foundation

class DessertsClient {
    
    static let shared = DessertsClient()

    func getDesserts() async throws -> [DessertInfo] {
        
        let urlString =  "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
         
         guard let url = URL(string: urlString) else {
             throw ApiError.badURL
         }
         
         let (data, response) = try await URLSession.shared.data(from: url)
         
         guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
             throw ApiError.requestFailed
         }
         
         do {
             let decoder = JSONDecoder()
             let decodedData = try decoder.decode(Desserts.self, from: data)

             return decodedData.meals
             
         } catch {
             throw ApiError.dataError
         }
    }
}
