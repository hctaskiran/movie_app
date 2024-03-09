//
//  MovieDBModelView.swift
//  movie_app
//
//  Created by Haktan Can Taşkıran on 26.02.2024.
//

import Foundation



@MainActor
class MovieDiscoverViewModel: ObservableObject {
    
    @Published var trending: [Movie] = []
    @Published var searchResults: [Movie] = []
    
    
    static let apiKey = "fd74fe032e11c9477a0b4d05311caf67"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZDc0ZmUwMzJlMTFjOTQ3N2EwYjRkMDUzMTFjYWY2NyIsInN1YiI6IjY1ZDc5MDFiYzM5MGM1MDE2M2ZiMTdiNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.OeynCMxQ9o8HgaaAVm37whT3b1TLO9NQ1Rw3JKU-8Cw"
    
    
    func loadTrending() {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(MovieDiscoverViewModel.apiKey)")!
            do {
                let (data, _ ) = try await URLSession.shared.data(from: url)
                
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                trending = trendingResults.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func search(term: String) {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(MovieDiscoverViewModel.apiKey)&language=en-US&page=1&include_adult=true&query=\(term)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!
            do {
                let (data, _ ) = try await URLSession.shared.data(from: url)
                
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                searchResults = trendingResults.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
    
