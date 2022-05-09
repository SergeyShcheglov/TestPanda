//
//  CustomTableViewCell.swift
//  TestPanda
//
//  Created by Sergey Shcheglov on 09.05.2022.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    
    static let identifier = "CustomTableViewCell"

    private let coverImage: UIImageView = {
        let v = UIImageView()
//        v.images = []
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        coverImage.frame = CGRect(x: <#T##Double#>,
                                  y: <#T##Double#>,
                                  width: <#T##Double#>,
                                  height: contentView.frame.size.height)
        movieTitle.frame = CGRect(x: <#T##Double#>,
                                  y: <#T##Double#>,
                                  width: <#T##Double#>,
                                  height: <#T##Double#>)
        rating.frame = CGRect(x: <#T##Double#>,
                              y: <#T##Double#>,
                              width: <#T##Double#>,
                              height: <#T##Double#>)
        overview.frame = CGRect(x: <#T##Double#>,
                                y: <#T##Double#>,
                                width: <#T##Double#>,
                                height: <#T##Double#>)
    }
}
