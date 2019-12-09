//
//  CommentCell.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 12/3/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Kingfisher

class CommentCell: UICollectionViewCell {
    
    
    var comment: Comment? {
        didSet {
            self.nameLabel.text = comment?.user.fullName
            self.commentLabel.text = comment?.text
            self.dateLabel.text = comment?.commentDate.timeAgoSinceDate()
            guard let imageUrl = comment?.user.imageUrl else {return}
            let url = URL(string: imageUrl)
            profileImage.kf.setImage(with: url)
        }
    }
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.flatWhite
        addSubview(profileImage)
        addSubview(nameLabel)
        addSubview(commentLabel)
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            profileImage.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            
            commentLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            commentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            commentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            
            
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            
            
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
