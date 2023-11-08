//
//  ImageView.swift
//  SweetSpot
//
//  Created by Mollie Whaley on 11/7/23.
//

import SwiftUI

struct ImageView: View {
    
    let imageUrlString: String
    let shouldApplyDetailModifier: Bool
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrlString)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                if shouldApplyDetailModifier {
                    image
                        .imageForRecipeDetails()
                } else {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                }
            case .failure:
                Image(systemName: "photo.artframe")
                    .frame(width: 150, height: 150)
            @unknown default:
                EmptyView()
            }
        }
    }
}
