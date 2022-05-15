//
//  PopularMovie.swift
//  TestPanda
//
//  Created by Sergey Shcheglov on 13.05.2022.
//

import Foundation

struct PopularMovieResponse: Decodable {
    let results: [PopularMovie]
}

struct PopularMovie: Decodable {
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    var posterPath: String?
    var backdropPath: String?
}
