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
                NetworkManager.shared.getImage(urlString: "https://image.tmdb.org/t/p/original\(movieVM.posterPath)") { data in
                    guard let data = data else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.coverImage.image = UIImage(data: data)
                    }
                }
                
            }
        }
    }
    
    static let identifier = "CustomTableViewCell"

    private let coverImage: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "mcconaughey")
        return v
    }()
    
    private let movieTitle: UILabel = {
        let v = UILabel()
        v.text = "Unpredictable"
        v.textColor = .lightGray
        return v
    }()
    
    private let rating: UILabel = {
        let v = UILabel()
        v.text = "7.8"
        v.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return v
    }()
    
    private let overview: UILabel = {
        let v = UILabel()
        v.text = "cool movie filmed by cool guys"
        v.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        v.textColor = UIColor(red: 86/255, green: 139/255, blue: 67/255, alpha: 1)
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
                                  y: 0,
                                  width: 80,
                                  height: contentView.frame.size.height)
        movieTitle.frame = CGRect(x: 8 + coverImage.frame.size.width,
                                  y: 0,
                                  width: contentView.frame.size.width - coverImage.frame.size.width,
                                  height: 20)
        rating.frame = CGRect(x: 8 + coverImage.frame.size.width,
                              y: 8 + movieTitle.frame.size.height ,
                              width: contentView.frame.size.width - coverImage.frame.size.width,
                              height: 20)
        overview.frame = CGRect(x: 8 + coverImage.frame.size.width,
                                y: 8 + movieTitle.frame.size.height + rating.frame.size.height,
                                width: contentView.frame.size.width - coverImage.frame.size.width,
                                height: contentView.frame.size.height / 2)
    }
}
