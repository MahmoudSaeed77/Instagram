//
//  HomeCell.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 10/12/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

protocol HomeCellProtocol {
    func commentTapped(post: Post)
    func likeTapped(cell: HomeCell)
}

class HomeCell: UICollectionViewCell {
    var delegate: HomeCellProtocol?
    
    
    var post: Post? {
        didSet {
            handleLike()
            fetchUserImage()
            fetchPostsImages()
            self.nameLabel.text = post?.user.fullName
            self.descriptionLabel.text = post?.caption
            self.timeCountLabel.text = post?.postData.timeAgoSinceDate()
        }
    }
    
    fileprivate func handleLike() {
        if self.post?.isLiked == true {
            likeIcon.setImage(UIImage(named: "heart2")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            likeIcon.setImage(UIImage(named: "heart1")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    fileprivate func fetchUserImage() {
        guard let profileUrl = post?.user.imageUrl else {return}
        guard let Url = URL(string: profileUrl) else {return}
        profileImage.kf.setImage(with: Url)
    }
    
    fileprivate func fetchPostsImages() {
        guard let imageUrl = post?.imageUrl else {return}
        guard let url = URL(string: imageUrl) else {return}
        postImage.kf.setImage(with: url)
    }
    
    
    var homeVC = HomeVC()
    var shareView = ShareViewVC()
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.lightGray
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 25
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mahmoud Saeed"
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    
    let postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = false
        return image
    }()
    
    let descriptionLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .left
        text.textColor = UIColor.black
        text.font = UIFont.systemFont(ofSize: 18)
        text.numberOfLines = 0
        return text
    }()
    
    lazy var likeIcon: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "heart1")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func likeTapped() {
        print("like from cell...")
        delegate?.likeTapped(cell: self)
    }
    
    lazy var commentIcon: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(commentAction), for: .touchUpInside)
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "share")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let timeCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "3 Days"
        label.textAlignment = .left
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.cornerRadius = 12
        clipsToBounds = true
        
        
        
        let tapgusterRecognizer = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tapgusterRecognizer.numberOfTapsRequired = 2
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(tapgusterRecognizer)
        
        
        shareButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        
        addSubview(profileImage)
        addSubview(nameLabel)
        addSubview(postImage)
        addSubview(descriptionLabel)
        addSubview(separatorView)
        addSubview(likeIcon)
        addSubview(commentIcon)
        addSubview(shareButton)
        addSubview(timeCountLabel)
        
        
        
        
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            profileImage.heightAnchor.constraint(equalToConstant: 50),
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 10),
            
            postImage.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 5),
            postImage.widthAnchor.constraint(equalTo: widthAnchor),
            postImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            
            descriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 5),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            separatorView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            separatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.3),
            separatorView.bottomAnchor.constraint(equalTo: likeIcon.topAnchor, constant: -10),
            
            likeIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            likeIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            commentIcon.leadingAnchor.constraint(equalTo: likeIcon.trailingAnchor, constant: 20),
            commentIcon.centerYAnchor.constraint(equalTo: likeIcon.centerYAnchor),
            
            likeIcon.heightAnchor.constraint(equalToConstant: 30),
            likeIcon.widthAnchor.constraint(equalToConstant: 30),
            
            commentIcon.heightAnchor.constraint(equalToConstant: 30),
            commentIcon.widthAnchor.constraint(equalToConstant: 30),
            
            shareButton.heightAnchor.constraint(equalToConstant: 30),
            shareButton.widthAnchor.constraint(equalToConstant: 30),
            
            shareButton.leadingAnchor.constraint(equalTo: commentIcon.trailingAnchor, constant: 20),
            shareButton.centerYAnchor.constraint(equalTo: commentIcon.centerYAnchor),
            
            
            timeCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            timeCountLabel.centerYAnchor.constraint(equalTo: commentIcon.centerYAnchor)
            ])
    }
    
    @objc func shareTapped(sender: UIButton) {
        shareView.showView()
    }
    @objc fileprivate func commentAction() {
        guard let post = self.post else {return}
        delegate?.commentTapped(post: post)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
