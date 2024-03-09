//
//  CastView.swift
//  movie_app
//
//  Created by Haktan Can Taşkıran on 10.03.2024.
//

import Foundation
import SwiftUI



struct CastView: View {
    let cast: CastProfiles
    
    var body: some View {
        VStack {
            
            AsyncImage(url: cast.photoURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
            } placeholder: {
                ProgressView().frame(width: 100, height: 120)
            }
            Text(cast.name)
                .lineLimit(1)
                .frame(width: 100)
        }
    }
    
}

