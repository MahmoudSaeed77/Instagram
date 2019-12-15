//
//  HomeView.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 10/12/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = #colorLiteral(red: 0.9317496827, green: 0.9317496827, blue: 0.9317496827, alpha: 1)
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
        addSubview(collectionView)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -75),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor)
            
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
