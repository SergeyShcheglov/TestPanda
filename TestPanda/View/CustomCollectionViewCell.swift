//
//  CustomCollectionViewCell.swift
//  TestPanda
//
//  Created by Sergey Shcheglov on 13.05.2022.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    var popularMovieVM: PopularMovieViewModel? {
        didSet {
            if let popularMovieVM = popularMovieVM {
                NetworkManager.shared.getImage(urlString: "https://image.tmdb.org/t/p/original/\(popularMovieVM.posterPath)") { data in
                    guard let data = data else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
        
    static let identifier = "CustomCollectionViewCell"
    
    let imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: 90,
                                 height: 120)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}
