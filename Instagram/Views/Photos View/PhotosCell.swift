//
//  PhotosCell.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 11/23/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = UIColor.flatNavyBlue
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.flatTeal
        addSubview(imageView)
        
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
