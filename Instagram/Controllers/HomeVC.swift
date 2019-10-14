//
//  HomeVC.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 10/12/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    var homeView = HomeView()
    let cellId = "cellId"
    let imageNames = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
        homeView.collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
        
    }
}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
        cell.postImage.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        return cell
    }
    
    
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 18, height: 420)
    }
}

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Selected")
    }
}
