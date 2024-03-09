//
//  File.swift
//  movie_app
//
//  Created by Haktan Can Taşkıran on 8.03.2024.
//

import Foundation
import SwiftUI

struct MovieDetailView: View {
    
    @Environment (\.dismiss) var dismiss
    @StateObject var model = MovieDetailsViewModel()
    let movie: Movie
    let headerHeight: CGFloat = 400
    
    
    
    var body: some View {
        ZStack {
            Color(red:61/255, green:  61/255, blue: 88/255)
            
            GeometryReader { geo in
                VStack {
                    AsyncImage(url: movie.backdropURL) { image in
                            image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: geo.size.width, maxHeight: headerHeight)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    } placeholder: {
                        ProgressView()
                    }
                    Spacer()
                }
            }
            ScrollView{
                VStack(spacing: 5){
                    Spacer().frame(height: headerHeight)
                    HStack {
                        Text(movie.title).fontWeight(.bold).font(.title)
                        Spacer()
                        HStack {
                            Image(systemName: "hand.thumbsup.fill")
                            Text("\(movie.vote_average, specifier: "%.1f")")
                        }.foregroundStyle(.yellow)
                    }
                    
                    HStack {
                        // genre
                        
                        // time
                    }
                    
                    HStack{
                        Text("About Film").fontWeight(.bold).font(.title3)
                        Spacer()
                        // see all
                    }
                    Text(movie.overview).lineLimit(2).foregroundColor(.secondary)
                    
                    HStack{
                        Text("Cast & Crew").fontWeight(.bold).font(.title3)
                        Spacer()
                        // see all
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(model.castProfiles) { cast in
                                CastView(cast: cast)
                            }
                            
                        }
                    }
                }
                .padding()
            }
        }.ignoresSafeArea()
        .overlay(alignment: .topLeading) {
            Button {
               dismiss()
            } label: {
                Image(systemName: "chevron.left").imageScale(.large).fontWeight(.bold)
            }.padding()
        }.toolbar(.hidden, for: .navigationBar)
            .task {
                await model.movieCrew(for: movie.id)
                await model.loadCast()
            }
    }
}

struct MovieDetailView_Preview: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: .mock)
    }
}
