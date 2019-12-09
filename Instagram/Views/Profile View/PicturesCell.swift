//
//  PicturesCell.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 10/14/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Kingfisher

class PicturesCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            guard let imageUrl = post?.imageUrl else {return}
            guard let url = URL(string: imageUrl) else {return}
            pictureImageView.kf.setImage(with: url)
        }
    }
    
    let pictureImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.tintColor = UIColor.lightGray
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(pictureImageView)
        
        NSLayoutConstraint.activate([
            pictureImageView.widthAnchor.constraint(equalTo: widthAnchor),
            pictureImageView.heightAnchor.constraint(equalTo: heightAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
