//
//  TrendingResults.swift
//  movie_app
//
//  Created by Haktan Can Taşkıran on 26.02.2024.
//

import Foundation


struct TrendingResults: Decodable {
    let page: Int
    var results = [Movie]()
    let total_pages: Int
    let total_results: Int
}
