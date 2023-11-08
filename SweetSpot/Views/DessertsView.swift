//
//  ContentView.swift
//  SweetSpot
//
//  Created by Mollie Whaley on 11/6/23.
//

import SwiftUI

struct DessertsView: View {
    
    @StateObject private var dessertsVM = DessertsVM()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(dessertsVM.dessertsArray, id: \.id) { recipe in
                    NavigationLink(destination: DessertDetailView(dessert: recipe)) {
                        RowView(recipe: recipe)
                    }
                }
                .alert(isPresented: $dessertsVM.presentError) {
                    Alert(
                        title: Text("Error"), message: Text(dessertsVM.errorMessage), dismissButton: .default(Text("OK")) {
                            dessertsVM.presentError = false
                            dessertsVM.errorMessage = ""
                    })
                }
            }
            .scrollIndicators(.hidden)
            .padding()
            .navigationBarModifier(title: "Desserts")
        }
        .task {
           await dessertsVM.getDesserts()
        }
    }
}

struct RowView: View {
    
    let recipe: DessertInfo
    
    var body: some View {
        HStack {
            ImageView(
                imageUrlString: recipe.image,
                shouldApplyDetailModifier: false
            )
            Spacer()
            Text(recipe.name)
                .recipeRowName()
        }
    }
}
