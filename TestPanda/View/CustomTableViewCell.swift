//
//  CustomTableViewCell.swift
//  TestPanda
//
//  Created by Sergey Shcheglov on 09.05.2022.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    var movieVM: MovieViewModel? {
        didSet {
            if let movieVM = movieVM {
                movieTitle.text = movieVM.title
                rating.text = String(movieVM.rating)
                overview.text = movieVM.overview
//                NetworkManager.shared.getImage(urlString: "https://image.tmdb.org/t/p/original\(movieVM.posterPath)") { data in
//                    guard let data = data else {
//                        return
//                    }
//                    DispatchQueue.main.async {
//                        self.coverImage.image = UIImage(data: data)
//                    }
//                }
            }
        }
    }
    
    static let identifier = "CustomTableViewCell"
    
    let coverImage: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    let movieTitle: UILabel = {
        let v = UILabel()
        v.text = "Unpredictable"
        v.font = .preferredFont(forTextStyle: .title3)
        return v
    }()
    
    let rating: UILabel = {
        let v = UILabel()
        v.text = "7.8"
        v.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return v
    }()
    
    let overview: UILabel = {
        let v = UILabel()
        v.text = "cool movie filmed by cool guys"
        v.numberOfLines = 0
        v.lineBreakMode = .byWordWrapping
        v.font = .preferredFont(forTextStyle: .caption1)
        v.sizeToFit()
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.addSubview(coverImage)
        contentView.addSubview(movieTitle)
        contentView.addSubview(rating)
        contentView.addSubview(overview)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        coverImage.frame = CGRect(x: 0,
                                  y: 4,
                                  width: 80,
                                  height: contentView.frame.size.height)
        movieTitle.frame = CGRect(x: 8 + coverImage.frame.size.width,
                                  y: 4,
                                  width: contentView.frame.size.width - coverImage.frame.size.width,
                                  height: 20)
        rating.frame = CGRect(x: 8 + coverImage.frame.size.width,
                              y: 8 + movieTitle.frame.size.height ,
                              width: contentView.frame.size.width - coverImage.frame.size.width,
                              height: 16)
        overview.frame = CGRect(x: 8 + coverImage.frame.size.width,
                                y: 8 + movieTitle.frame.size.height + rating.frame.size.height,
                                width: contentView.frame.size.width - coverImage.frame.size.width,
                                height: contentView.frame.size.height - rating.frame.size.height - movieTitle.frame.size.height - 8)
    }
}
