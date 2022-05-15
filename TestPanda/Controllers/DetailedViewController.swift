//
//  DetailedViewController.swift
//  TestPanda
//
//  Created by Sergey Shcheglov on 10.05.2022.
//

import UIKit

class DetailedViewController: UIViewController {
    
    var movie: MovieViewModel
    
    init(movie: MovieViewModel) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var posterImage: UIImageView = {
        let poster = UIImageView()
        poster.translatesAutoresizingMaskIntoConstraints = false
        NetworkManager.shared.getImage(urlString: "https://image.tmdb.org/t/p/original\(movie.posterPath)") { data in
            guard let data = data else {
                print("error")
                return
            }
            DispatchQueue.main.async {
                poster.image = UIImage(data: data)
            }
        }
        poster.contentMode = .scaleAspectFit        
        return poster
    }()
    
    private lazy var releaseYear: UILabel = {
        let year = UILabel()
        year.translatesAutoresizingMaskIntoConstraints = false
        year.text = "Year: " + String(movie.releaseYear)
        return year
    }()
    
    private lazy var movieTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = movie.title
        title.font = .preferredFont(forTextStyle: .title3)
        title.textAlignment = .center
        title.numberOfLines = 0
        title.lineBreakMode = .byTruncatingTail
        return title
    }()
    
    private lazy var rating: UILabel = {
        let rating = UILabel()
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.text = "Rating: " + String(movie.rating)
        return rating
    }()
    
    private lazy var overview: UILabel = {
        let overview = UILabel()
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.text = movie.overview
        overview.font = .preferredFont(forTextStyle: .body)
        overview.numberOfLines = 0
        overview.lineBreakMode = .byWordWrapping
        overview.layer.position = CGPoint(x: 0, y: 0)
        overview.sizeToFit()
        return overview
    }()
    
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        view.addSubview(posterImage)
        view.addSubview(movieTitle)
        view.addSubview(releaseYear)
        view.addSubview(rating)
        view.addSubview(overview)
        setupView()
        
    }
    
    
    private func setupView() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            posterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            posterImage.heightAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 8),
            movieTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            movieTitle.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            releaseYear.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 8),
            releaseYear.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            releaseYear.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            releaseYear.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        NSLayoutConstraint.activate([
            rating.topAnchor.constraint(equalTo: releaseYear.bottomAnchor, constant: 8),
            rating.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            rating.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            rating.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        NSLayoutConstraint.activate([
            overview.topAnchor.constraint(equalTo: rating.bottomAnchor, constant: 20),
            overview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            overview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            overview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//            overview.autopin
        ])
    }
}
