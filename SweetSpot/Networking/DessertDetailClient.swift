//
//  DessertDetailClient.swift
//  SweetSpot
//
//  Created by Mollie Whaley on 11/7/23.
//
import Foundation

class DessertDetailClient {
    
    static let shared = DessertDetailClient()

    func getDetails(id: String) async throws -> Details {
        
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
         
         guard let url = URL(string: urlString) else {
             throw ApiError.badURL
         }
         
         let (data, response) = try await URLSession.shared.data(from: url)
         
         guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
             throw ApiError.requestFailed
         }
         
         do {
             let decoder = JSONDecoder()
             let decodedData = try decoder.decode(DessertDetails.self, from: data)

             return decodedData.meals[0]
             
         } catch {
             throw ApiError.dataError
         }
    }
}
