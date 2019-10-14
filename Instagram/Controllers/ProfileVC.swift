//
//  ProfileVC.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 10/12/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    let categoryId = "categoryId"
    let picturesId = "picturesId"
    let categoryImagesNames: [String] = ["thumb", "card", "map", "photosOfYou"]
    let imageNames = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    var profileView = ProfileView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view = profileView
        collectionViewsConfigrations()
        let indexPath = NSIndexPath(item: 0, section: 0)
        profileView.categoryCollectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            NSLayoutConstraint.deactivate(profileView.portrait)
            NSLayoutConstraint.activate(profileView.landScape)
            profileView.profileImage.layer.cornerRadius = 20
        }else{
            NSLayoutConstraint.deactivate(profileView.landScape)
            NSLayoutConstraint.activate(profileView.portrait)
            profileView.profileImage.layer.cornerRadius = 40
        }
    }
    
    func collectionViewsConfigrations(){
        profileView.categoryCollectionView.delegate = self
        profileView.categoryCollectionView.dataSource = self
        profileView.categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: categoryId)
        profileView.picturesCollectionView.delegate = self
        profileView.picturesCollectionView.dataSource = self
        profileView.picturesCollectionView.register(PicturesCell.self, forCellWithReuseIdentifier: picturesId)
    }
}

extension ProfileVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == profileView.categoryCollectionView {
            return categoryImagesNames.count
        }
        return imageNames.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == profileView.categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryId, for: indexPath) as! CategoryCell
            cell.categoryImageView.image = UIImage(named: categoryImagesNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picturesId, for: indexPath) as! PicturesCell
        cell.pictureImageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        return cell
    }
}
extension ProfileVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == profileView.categoryCollectionView {
            return CGSize(width: profileView.categoryCollectionView.frame.width / 4, height: profileView.categoryCollectionView.frame.height)
        }
        return CGSize(width: profileView.picturesCollectionView.frame.width / 3 - 1, height: profileView.picturesCollectionView.frame.width / 3 - 1)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == profileView.categoryCollectionView {
            return 0
        }
        return 0.1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
