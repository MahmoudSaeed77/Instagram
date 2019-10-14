//
//  CategoryCell.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 10/14/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    let categoryImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor.lightGray
        return image
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                categoryImageView.tintColor = UIColor.blue
            }else {
                categoryImageView.tintColor = UIColor.lightGray
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(categoryImageView)
        
        NSLayoutConstraint.activate([
            categoryImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
