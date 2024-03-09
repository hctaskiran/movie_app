//
//  Movie.swift
//  movie_app
//
//  Created by Haktan Can Taşkıran on 26.02.2024.
//

import Foundation


struct Movie: Identifiable, Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String
    let title: String
    let overview: String
    let vote_average: Float
    let backdrop_path: String

    
    var backdropURL: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseURL?.appending(path: backdrop_path)
    }
    
    var posterThumbnail: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w100")
        return baseURL?.appending(path: poster_path)
    }
    
    var poster: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseURL?.appending(path: poster_path)
    }
    
    static var mock: Movie {
        return Movie(adult: false, 
                     id: 23834,
                     poster_path: "https://image.tmdb.org/t/p/w300",
                     title: "Free Guy",
                     overview: "alofis alocis",
                     vote_average: 3.6,
                     backdrop_path: "https://image.tmdb.org/t/p/w300")
    }
}


