//
//  MovieViewModel1.swift
//  TestPanda
//
//  Created by Sergey Shcheglov on 10.05.2022.
//

import Foundation

class PopularMovieViewModel {
    
    var movieVM = [MovieViewModel]()

    func getMovies(query: String, completion: @escaping ([MovieViewModel]) -> Void) {
        NetworkManager.shared.getMovies(query: query) { movie in
            guard let movie = movie else {
                return
            }

            let movieVM = movie.map(MovieViewModel.init)
            DispatchQueue.main.async {
                self.movieVM = movieVM
                completion(movieVM)
            }
            
            print(movieVM)
        }
    }
}
