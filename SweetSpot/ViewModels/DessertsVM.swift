//
//  DessertsVM.swift
//  SweetSpot
//
//  Created by Mollie Whaley on 11/7/23.
//

import Foundation

extension DessertsView {
    
    @MainActor final class DessertsVM: ObservableObject {
        
        @Published private(set) var dessertsArray: [DessertInfo] = []
        @Published var presentError: Bool = false
        @Published var errorMessage: String = ""

        func getDesserts() async {
            
            do {
                let desserts = try await DessertsClient.shared.getDesserts()
                self.dessertsArray = desserts
                
            } catch ApiError.badURL {
                self.errorMessage = "Problem on our side. We're fixing it."
                self.presentError = true
                
            } catch ApiError.dataError {
                self.errorMessage = "Issue getting deserts."
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
