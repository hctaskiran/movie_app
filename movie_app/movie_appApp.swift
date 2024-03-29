//
//  movie_appApp.swift
//  movie_app
//
//  Created by Haktan Can Taşkıran on 22.02.2024.
//

import SwiftUI

@main
struct movie_appApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Image(systemName: "popcorn")
                    }
                Text("Favorites")
                    .tabItem {
                        Image(systemName: "heart.fill")
                    }
                Text("Tickets")
                    .tabItem {
                        Image(systemName: "bookmark.fill")
                    }
            }
            
        }
    }
}
