//
//  HomeView.swift
//  Login Firebase Demo
//
//  Created by Mohamed Ibrahem on 11/11/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import ChameleonFramework

class StartView: UIView {

    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.backgroundColor = FlatRed()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.tintColor = UIColor.flatWhite
        return button
    }()

    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Signup", for: .normal)
        button.backgroundColor = FlatRed()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.tintColor = UIColor.flatWhite
        return button
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.black
        collection.alwaysBounceHorizontal = true
        layout.scrollDirection = .horizontal
        collection.isPagingEnabled = true
        layout.minimumLineSpacing = 0
        return collection
    }()
    let pageController: UIPageControl = {
        let page = UIPageControl()
        page.translatesAutoresizingMaskIntoConstraints = false
        page.tintColor = UIColor.white
        page.currentPageIndicatorTintColor = UIColor.blue
        return page
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupConstraints()
    }

    fileprivate func setupView(){
        backgroundColor = UIColor.white
        
        addSubview(collectionView)
        addSubview(pageController)
        addSubview(loginButton)
        addSubview(signupButton)
    }

    fileprivate func setupConstraints(){
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor),
            
            pageController.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageController.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200),
            
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            loginButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            
            signupButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            signupButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            signupButton.heightAnchor.constraint(equalToConstant: 50),
            signupButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4)
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
