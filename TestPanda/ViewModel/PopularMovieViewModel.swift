//
//  PopularMovieViewModel.swift
//  TestPanda
//
//  Created by Sergey Shcheglov on 13.05.2022.
//

import Foundation

class PopularMovieListViewModel {
    
    var popularMovieVM = [PopularMovieViewModel]()

    func getPopularMovies(completion: @escaping ([PopularMovieViewModel]) -> Void) {
        NetworkManager.shared.getPopularMovies { movie in
            guard let movie = movie else {
                return
            }

            let popularMovieVM = movie.map(PopularMovieViewModel.init)
            DispatchQueue.main.async {
                self.popularMovieVM = popularMovieVM
                completion(popularMovieVM)
            }
        }
    }
}
