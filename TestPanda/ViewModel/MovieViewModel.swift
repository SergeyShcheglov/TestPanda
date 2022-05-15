//
//  MovieViewModel.swift
//  TestPanda
//
//  Created by Sergey Shcheglov on 10.05.2022.
//

import Foundation

struct MovieViewModel {
    let movie: Movie
    
    var title: String {
       return movie.title ?? "unknown title"
    }
    var rating: Double {
        return movie.rating ?? 0.0
    }
    
    var overview: String {
        return movie.overview ?? "unknown overview"
    }
    
    var backdropPath: String {
        return movie.backdropPath ?? "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"
    }
    
    var posterPath: String {
        movie.posterPath == nil
        ? "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"
        : "https://image.tmdb.org/t/p/original/\(movie.posterPath!)"
    }
    
    var releaseYear: String {
        let date = movie.releaseYear ?? ""
        return String(date.prefix(4))
    }
}
