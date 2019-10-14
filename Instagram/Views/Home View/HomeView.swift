//
//  HomeView.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 10/12/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9646012187, green: 0.9647662044, blue: 0.9645908475, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let directMessegeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "new_Message")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let titleImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Bitmap")?.withRenderingMode(.alwaysOriginal))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = #colorLiteral(red: 0.9646012187, green: 0.9647662044, blue: 0.9645908475, alpha: 1)
        collection.translatesAutoresizingMaskIntoConstraints = false
        layout.scrollDirection = .vertical
        collection.alwaysBounceVertical = true
        return collection
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    func setupView(){
        backgroundColor = UIColor.white
        addSubview(topView)
        addSubview(collectionView)
        topView.addSubview(directMessegeButton)
        topView.addSubview(titleImage)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            
            topView.widthAnchor.constraint(equalTo: widthAnchor),
            topView.heightAnchor.constraint(equalToConstant: 100),
            topView.topAnchor.constraint(equalTo: topAnchor),
            
            directMessegeButton.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -10),
            directMessegeButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20),
            
            
            titleImage.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            titleImage.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -75),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor)
            
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
