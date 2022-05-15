//
//  PopularMoviesViewModel.swift
//  TestPanda
//
//  Created by Sergey Shcheglov on 13.05.2022.
//

import Foundation

struct PopularMovieViewModel {
    let popularMovie: PopularMovie
    
    var backdropPath: String {
        popularMovie.backdropPath == nil
        ? "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"
        : "https://image.tmdb.org/t/p/original/\(popularMovie.backdropPath!)"
    }
    
    var posterPath: String {
        popularMovie.posterPath == nil
        ? "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"
        : "https://image.tmdb.org/t/p/original/\(popularMovie.posterPath!)"
    }
   
}
