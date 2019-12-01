//
//  SliderCell.swift
//  Login Firebase Demo
//
//  Created by Mohamed Ibrahem on 11/11/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class SliderCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    var image:UIImage! {
        didSet{
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor)
            ])
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
