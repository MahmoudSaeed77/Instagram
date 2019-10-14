//
//  ProfileView.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 10/12/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    var portrait = [NSLayoutConstraint]()
    var landScape = [NSLayoutConstraint]()
    
    
    let coverImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "image")?.withRenderingMode(.alwaysOriginal))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "more")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let followButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "follow")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "doda")?.withRenderingMode(.alwaysOriginal))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mahmoud Saeed"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.white
        return label
    }()
    
    let bioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "IOS Developer & #LIFE RUNS ON CODE"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.white
        return label
    }()
    
    let overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.brown
        view.layer.opacity = 0.3
        return view
    }()
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.white
        collection.alwaysBounceHorizontal = false
        return collection
    }()
    
    let picturesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.white
        collection.alwaysBounceVertical = true
        layout.scrollDirection = .vertical
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        addSubview(coverImage)
        addSubview(overlayView)
        addSubview(moreButton)
        addSubview(followButton)
        addSubview(profileImage)
        addSubview(nameLabel)
        addSubview(bioLabel)
        addSubview(categoryCollectionView)
        addSubview(picturesCollectionView)
        
        NSLayoutConstraint.activate([
            coverImage.widthAnchor.constraint(equalTo: widthAnchor),
            coverImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            coverImage.topAnchor.constraint(equalTo: topAnchor),
            
            overlayView.widthAnchor.constraint(equalTo: widthAnchor),
            overlayView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            
            
            
            moreButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            moreButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            
            followButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            followButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            
            bioLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            
            categoryCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 60),
            categoryCollectionView.topAnchor.constraint(equalTo: coverImage.bottomAnchor),
            
            picturesCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
            picturesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            picturesCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor)
            ])
        
        portrait = [
            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImage.widthAnchor.constraint(equalToConstant: 80),
            profileImage.heightAnchor.constraint(equalToConstant: 80),
        ]
        
        landScape = [
            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImage.widthAnchor.constraint(equalToConstant: 40),
            profileImage.heightAnchor.constraint(equalToConstant: 40),
        ]
        NSLayoutConstraint.activate(portrait)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
