//
//  NetworkManager.swift
//  TestPanda
//
//  Created by Sergey Shcheglov on 09.05.2022.
//

import Foundation

class NetworkManager {
    let imageCache = NSCache<NSString, NSData>()
    
    static let shared = NetworkManager()
    private init() {
        
    }
    private let baseUrlString = "https://api.themoviedb.org/3/"
    private let searchMovies = "search/movie"
    private let movies = "movie"
    private let popularMovies = "movie/popular"
    
    
    private let imageUrl = "https://image.tmdb.org/t/p/original/"
    
    func getPopularMovies(completion: @escaping ([Movie]?) -> Void) {
        let urlString = "\(baseUrlString)\(popularMovies)&api_key=\(APIKey.key)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data)
            movieResponse == nil ? completion(nil) : completion(movieResponse!.results)
            
        }.resume()
    }
    
    func getMovies(query: String, completion: @escaping ([Movie]?) -> Void) {
        let urlString = "\(baseUrlString)\(searchMovies)?api_key=\(APIKey.key)&query=\(query)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            
            let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data)
            movieResponse == nil ? completion(nil) : completion(movieResponse!.results)
//            print("session \(movieResponse)")
        }.resume()
    }
    //
    func getImage(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage as Data)
        } else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil, let data = data else {
                    completion(nil)
                    return
                }
                
                self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
                completion(data)
            }.resume()
        }
    }
}
