//
//  Movie.swift
//  TestPanda
//
//  Created by Sergey Shcheglov on 09.05.2022.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case rating = "vote_average"
        case posterPath = "poster_path"
        case releaseYear = "release_date"
        case title
        case overview
    }
    
    var title: String?
    var rating: Double?
    var overview: String?
    var backdropPath: String?
    var posterPath: String?
    var releaseYear: String?
}
