//
//  PicturesCell.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 10/14/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class PicturesCell: UICollectionViewCell {
    let pictureImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
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
