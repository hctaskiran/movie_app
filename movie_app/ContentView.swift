//
//  ContentView.swift
//  movie_app
//
//  Created by Haktan Can Taşkıran on 22.02.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = MovieDBViewModel()
    
    var body: some View {
        VStack {
            if viewModel.trending.isEmpty {
                Text("No results")
            } else {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.trending) { trendingItem in
                            TrendingCard(trendingItem: trendingItem )
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear{
            viewModel.loadTrending()
        }
    }
}

struct TrendingCard: View {
    
    let trendingItem: TrendingItem
    
    var body: some View {
        ZStack {
//            AsyncImage(url: trendingItem.poster_path) { image in
//                image
//                    .resizable()
//                    .scaledToFill()
//            } placeholder: {
//                ProgressView()
//            }
            
            VStack {
                HStack {
                    Text(trendingItem.title)
                    Spacer()
                    Image(systemName: "heart.fill").foregroundStyle(.red)
                }
                
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                    Text("\(trendingItem.vote_average)")
                    Spacer()
                }.foregroundStyle(.yellow)
            }
        }
    }
}

@MainActor
class MovieDBViewModel: ObservableObject {
    
    @Published var trending: [TrendingItem] = []
    
    static let apiKey = "fd74fe032e11c9477a0b4d05311caf67"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZDc0ZmUwMzJlMTFjOTQ3N2EwYjRkMDUzMTFjYWY2NyIsInN1YiI6IjY1ZDc5MDFiYzM5MGM1MDE2M2ZiMTdiNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.OeynCMxQ9o8HgaaAVm37whT3b1TLO9NQ1Rw3JKU-8Cw"
     
    
    func loadTrending() {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(MovieDBViewModel.apiKey)")!
            do {
                let (data, _ ) = try await URLSession.shared.data(from: url)
                
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                trending = trendingResults.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
 
}

struct TrendingResults: Decodable {
    let page: Int
    var results = [TrendingItem]()
    let total_pages: Int
    let total_results: Int
}

struct TrendingItem: Identifiable, Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String
    let title: String
    let vote_average: Float
}

#Preview {
    ContentView()
}
 
