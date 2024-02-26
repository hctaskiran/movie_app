//
//  TrendingCard.swift
//  movie_app
//
//  Created by Haktan Can Taşkıran on 26.02.2024.
//

import Foundation
import SwiftUI


struct TrendingCard: View {
    
    let trendingItem: Movie
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: trendingItem.backdropURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 240)
            } placeholder: {
                Rectangle().fill(Color(red:61/255,green: 61/255, blue: 88/255))
                    .frame(width: 340, height: 240)
            }
            
            VStack {
                HStack {
                    Text(trendingItem.title)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        
                    Spacer()
                    Image(systemName: "heart.fill").foregroundStyle(.red)
                }
                
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                    Text("\(trendingItem.vote_average, specifier: "%.1f")")
                    Spacer()
                }
                .foregroundStyle(.yellow)
                .fontWeight(.heavy)
            }
            .padding()
            .background(Color(red:61/255,green: 61/255, blue: 88/255))
        }
        .cornerRadius(10)
    }
}

