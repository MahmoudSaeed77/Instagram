//
//  SearchView.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 11/27/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.alwaysBounceVertical = true
        layout.scrollDirection = .vertical
        collection.backgroundColor = UIColor.lightGray
        return collection
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        
        
        addSubview(collectionView)
        
        
        
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
