//
//  MovieDetailsViewModel.swift
//  movie_app
//
//  Created by Haktan Can Taşkıran on 9.03.2024.
//

import Foundation
import SwiftUI


@MainActor
class MovieDetailsViewModel: ObservableObject {

    @Published var credits: MovieCredits?
    @Published var cast: [MovieCredits.Cast] = []
    @Published var castProfiles: [CastProfiles] = []
    
    func movieCrew(for movieID: Int) async {
            let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=\( MovieDiscoverViewModel.apiKey)&language=en-US")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let credits = try JSONDecoder().decode(MovieCredits.self, from: data)
                self.credits = credits
                self.cast = credits.cast.sorted(by: { $0.order < $1.order})
            } catch {
                print(error.localizedDescription)
            }
    }
    
    func loadCast() async {
        do {
            for member in cast {
                let url = URL(string: "https://api.themoviedb.org/3/person/\(member.id)?api_key=\( MovieDiscoverViewModel.apiKey)&language=en-US")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let profile = try JSONDecoder().decode(CastProfiles.self, from: data)
                castProfiles.append(profile)
//                castProfiles[member.order] = profile
            }
        } catch {
            print(error.localizedDescription)
        }

    }
}

struct CastProfiles: Decodable, Identifiable {
    let birthday: String?
    let id: Int
    let name: String
    let profile_path: String?
    
    var photoURL: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseURL?.appending(path: profile_path ?? "")
    }
}

struct MovieCredits: Decodable {
    let id: Int
    let cast: [Cast]
    
    struct Cast: Decodable, Identifiable {
        let name: String
        let id: Int
        let character: String
        let order: Int
    }
}



