//
//  PhotoSelectorController.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 11/23/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Photos

class PhotoSelectorController: UIViewController {
    
    let photosView = PhotosView()
    let cellId = "cellId"
    let headerId = "headerId"
    var selectdImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = photosView
        setupDelegate()
        setupNavigationButtons()
        fetchPhotos()
    }
    var images = [UIImage]()
    var assets = [PHAsset]()
    var header = PhotosHeader()
    fileprivate func fetchPhotos() {
        let fetchOptions = PHFetchOptions()
//        fetchOptions.fetchLimit = 30
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        DispatchQueue.global(qos: .background).async {
            allPhotos.enumerateObjects ({ (asset, count, stop) in
                print(asset)
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 350, height: 350)
                let imageRequestOptions = PHImageRequestOptions()
                imageRequestOptions.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: imageRequestOptions, resultHandler: { (image, info) in
                    if let image = image {
                        self.images.append(image)
                        self.assets.append(asset)
                        if self.selectdImage == nil {
                            self.selectdImage = image
                        }
                    }
                    
                    if count == allPhotos.count - 1 {
                        DispatchQueue.main.async {
                            self.photosView.collectionView.reloadData()
                        }
                        
                    }
                })
            })
        }
    }
    
    fileprivate func setupNavigationButtons() {
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextAction))
    }
    
    @objc func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func nextAction() {
        let vc = SharePhotoController()
        vc.selectedImage = header.imageView.image
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupDelegate() {
        photosView.collectionView.delegate = self
        photosView.collectionView.dataSource = self
        photosView.collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: cellId)
        photosView.collectionView.register(PhotosHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
}



extension PhotoSelectorController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotosCell
        cell.imageView.image = images[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId, for: indexPath) as! PhotosHeader
        header.imageView.image = selectdImage
        self.header = header
        if let selectedImage = selectdImage {
            if let index = self.images.index(of: selectedImage) {
                let selectedAsset = self.assets[index]
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 600, height: 600)
                imageManager.requestImage(for: selectedAsset, targetSize: targetSize, contentMode: .aspectFit, options: nil) { (image, info) in
                    header.imageView.image = image
                }
            }
        }
        return header
    }
    
}

extension PhotoSelectorController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = photosView.collectionView.frame.width
        let height = photosView.collectionView.frame.width
        return CGSize(width: (width / 3) - 2 , height: (height / 3) - 2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = photosView.collectionView.frame.width
        return CGSize(width: width, height: 400)
    }
}

extension PhotoSelectorController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectdImage = images[indexPath.item]
        self.photosView.collectionView.reloadData()
        
        let index = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: index, at: .bottom, animated: true)
    }
}
