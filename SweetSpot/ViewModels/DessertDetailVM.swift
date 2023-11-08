//
//  DessertDetailVM.swift
//  SweetSpot
//
//  Created by Mollie Whaley on 11/7/23.
//

import Foundation

extension DessertDetailView {
    
    @MainActor final class DessertDetailVM: ObservableObject {
        
        @Published private(set) var dessertDetails: Details? = nil
        @Published var presentError: Bool = false
        @Published var errorMessage: String = ""

        func getDetails(for id: String) async {
            do {
                let details = try await DessertDetailClient.shared.getDetails(id: id)
                self.dessertDetails = details
                
            } catch ApiError.badURL {
                self.errorMessage = "Problem on our side. We're fixing it."
                self.presentError = true
                
            } catch ApiError.dataError {
                self.errorMessage = "Issue getting details."
                self.presentError = true

            } catch ApiError.requestFailed {
                self.errorMessage = "Server error."
                self.presentError = true

            } catch {
                self.errorMessage = "Unexpected problem. Try again."
                self.presentError = true
            }
        }
    }
}

