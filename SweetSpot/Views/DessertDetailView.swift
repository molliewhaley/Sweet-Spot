//
//  DessertDetailView.swift
//  SweetSpot
//
//  Created by Mollie Whaley on 11/6/23.
//

import SwiftUI

struct DessertDetailView: View {
    
    @StateObject private var dessertDetailVM = DessertDetailVM()
    let dessert: DessertInfo
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ImageView(
                    imageUrlString: dessert.image,
                    shouldApplyDetailModifier: true
                )
                
                if let details = dessertDetailVM.dessertDetails {
                    InstructionsAndIngredientsView(details: details)
                }
            }
            .padding(12)
            .scrollIndicators(.hidden)
            .alert(isPresented: $dessertDetailVM.presentError) {
                Alert(title: Text("Error"), message: Text(dessertDetailVM.errorMessage), dismissButton: .default(Text("OK")) {
                    dessertDetailVM.presentError = false
                    dessertDetailVM.errorMessage = ""
                })
            }
        }
        .navigationBarModifier(title: dessert.name)
        .task {
            await dessertDetailVM.getDetails(for: dessert.id)
        }
    }
}

struct InstructionsAndIngredientsView: View {
    
    let details: Details
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredients")
                .detailHeader()
            ForEach(Array(details.ingredientsAndMeasurementsDict), id: \.key) { keyValue in
                HStack(spacing: 0) {
                    Text("• " + keyValue.value + " ")
                    Text(keyValue.key)
                }
                .padding(.vertical, 3)
            }
        }
        .padding(.bottom, 20)
        
        Text("Instructions")
            .detailHeader()
        ForEach(details.separatedInstructions.indices, id: \.self) { index in
            Text(details.separatedInstructions[index])
        }
    }
}
