//
//  PhotosView.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 11/23/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class PhotosView: UIView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.alwaysBounceVertical = true
        layout.scrollDirection = .vertical
        collection.backgroundColor = UIColor.flatWhite
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    
    func setupView() {
        backgroundColor = UIColor.flatGray
        
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor)
            ])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
