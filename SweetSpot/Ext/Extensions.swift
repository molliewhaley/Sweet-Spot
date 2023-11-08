//
//  Extensions.swift
//  SweetSpot
//
//  Created by Mollie Whaley on 11/7/23.
//

import SwiftUI

extension Text {
    func recipeRowName() -> some View {
        self
            .multilineTextAlignment(.trailing)
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .padding(.horizontal, 20)
    }
    
    func detailHeader() -> some View {
        self
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.bottom, 5)
    }
}

extension View {
    func navigationBarModifier(title: String) -> some View {
        self
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.black, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

extension Image {
    func imageForRecipeDetails() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity)
            .frame(height: 150)
            .clipped()
            .padding(.bottom, 20)
    }
}
