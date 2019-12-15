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
        image.layer.borderWidth = 0.5
        image.layer.borderColor = UIColor.black.cgColor
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
    
    let commentLabel: UITextView = {
        let label = UITextView()
        label.isScrollEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = NSTextAlignment.natural
        label.layoutIfNeeded()
        label.backgroundColor = UIColor.clear
        label.isEditable = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.textAlignment = .left
        return label
    }()
    
    let photoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.cornerRadius = 20
        clipsToBounds = true
        
        addSubview(photoView)
        addSubview(nameView)
        addSubview(textView)
        addSubview(dateView)
        photoView.addSubview(profileImage)
        nameView.addSubview(nameLabel)
        textView.addSubview(commentLabel)
        dateView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            
            photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            photoView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            photoView.widthAnchor.constraint(equalToConstant: 50),
            photoView.heightAnchor.constraint(equalToConstant: 50),
            
            nameView.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 10),
            nameView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            nameView.heightAnchor.constraint(equalToConstant: 20),
            
            dateView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            dateView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            dateView.heightAnchor.constraint(equalToConstant: 15),
            
            textView.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            textView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 5),
            textView.bottomAnchor.constraint(equalTo: dateView.topAnchor, constant: -5),
            
            profileImage.widthAnchor.constraint(equalTo: photoView.widthAnchor),
            profileImage.heightAnchor.constraint(equalTo: photoView.heightAnchor),
            
            nameLabel.widthAnchor.constraint(equalTo: nameView.widthAnchor),
            nameLabel.heightAnchor.constraint(equalTo: nameView.heightAnchor),
            
            dateLabel.widthAnchor.constraint(equalTo: dateView.widthAnchor),
            dateLabel.heightAnchor.constraint(equalTo: dateView.heightAnchor),
            
            commentLabel.widthAnchor.constraint(equalTo: textView.widthAnchor),
            commentLabel.heightAnchor.constraint(equalTo: textView.heightAnchor),
            
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
