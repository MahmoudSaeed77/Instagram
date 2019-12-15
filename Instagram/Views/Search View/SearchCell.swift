//
//  SearchCell.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 11/27/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Kingfisher

class SearchCell: UICollectionViewCell {
    
    var user: User? {
        didSet {
            nameLabel.text = user?.fullName
            
            guard let imageUrl = user?.imageUrl else {return}
            guard let url = URL(string: imageUrl) else {return}
            profileImage.kf.setImage(with: url)
        }
    }
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = UIColor.lightGray
        image.clipsToBounds = true
        image.layer.cornerRadius = 45
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mahmoud Saeed"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(profileImage)
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            profileImage.heightAnchor.constraint(equalToConstant: 90),
            profileImage.widthAnchor.constraint(equalToConstant: 90),
            profileImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
