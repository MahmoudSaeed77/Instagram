//
//  ProfileView.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 10/12/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import ChameleonFramework

class ProfileView: UIView {
    
    let MainCollectionView: UICollectionView = {
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
        
        addSubview(MainCollectionView)
        
        
        NSLayoutConstraint.activate([
            MainCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
            MainCollectionView.heightAnchor.constraint(equalTo: heightAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
