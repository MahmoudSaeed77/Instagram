//
//  ShareViewVC.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 10/14/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class ShareViewVC: NSObject {
    let shareView = UIView()
    let overlayView = UIView()
    
    let mainId = "mainId"
    let socialArray = ["Facebook", "Twitter", "Pinterest", "Google+", "Mail", "Link"]
    let imageNames = ["doda", "2", "3", "4", "5", "6", "7", "8", "9", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let names = ["Mahmoud Saeed", "Abo Trika", "Barakat", "El Hadary", "Mahmoud Saeed", "Abo Trika", "Barakat", "El Hadary", "Mahmoud Saeed", "Abo Trika", "Barakat", "El Hadary", "Mahmoud Saeed", "Abo Trika", "Barakat", "El Hadary", "Mahmoud Saeed", "Abo Trika"]
    
    
    
    let search: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Search")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let shareTitle: UILabel = {
        let label = UILabel()
        label.text = "Share"
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let shareCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.white
        collection.alwaysBounceHorizontal = false
        layout.scrollDirection = .horizontal
        return collection
    }()
    
    let secondSeperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let socialCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        layout.scrollDirection = .horizontal
        collection.backgroundColor = .white
        return collection
    }()
    
    let thirdSeperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        return button
    }()
    
    override init() {
        super.init()
        
        shareView.addSubview(search)
        shareView.addSubview(shareTitle)
        shareView.addSubview(seperatorView)
        shareView.addSubview(shareCollectionView)
        shareView.addSubview(secondSeperatorView)
        shareView.addSubview(socialCollection)
        shareView.addSubview(thirdSeperatorView)
        shareView.addSubview(cancelButton)
        
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        
        shareCollectionView.delegate = self
        shareCollectionView.dataSource = self
        
        socialCollection.delegate = self
        socialCollection.dataSource = self
        
        shareCollectionView.register(MainCell.self, forCellWithReuseIdentifier: mainId)
        socialCollection.register(SocialCell.self, forCellWithReuseIdentifier: "socialId")
        
        
        NSLayoutConstraint.activate([
            search.leadingAnchor.constraint(equalTo: shareView.leadingAnchor, constant: 10),
            search.topAnchor.constraint(equalTo: shareView.topAnchor, constant: 10),
            
            shareTitle.centerXAnchor.constraint(equalTo: shareView.centerXAnchor),
            shareTitle.topAnchor.constraint(equalTo: shareView.topAnchor, constant: 10),
            
            seperatorView.topAnchor.constraint(equalTo: shareTitle.bottomAnchor, constant: 10),
            seperatorView.widthAnchor.constraint(equalTo: shareView.widthAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 0.5),
            
            shareCollectionView.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: 2),
            shareCollectionView.widthAnchor.constraint(equalTo: shareView.widthAnchor),
            shareCollectionView.heightAnchor.constraint(equalTo: shareView.heightAnchor, multiplier: 50 / 300),
            
            secondSeperatorView.topAnchor.constraint(equalTo: shareCollectionView.bottomAnchor),
            secondSeperatorView.widthAnchor.constraint(lessThanOrEqualTo: shareView.widthAnchor),
            secondSeperatorView.heightAnchor.constraint(equalToConstant: 0.5),
            
            socialCollection.topAnchor.constraint(equalTo: secondSeperatorView.bottomAnchor),
            socialCollection.widthAnchor.constraint(equalTo: shareView.widthAnchor),
            socialCollection.heightAnchor.constraint(equalTo: shareView.heightAnchor, multiplier: 20 / 300),
            
            thirdSeperatorView.topAnchor.constraint(equalTo: socialCollection.bottomAnchor),
            thirdSeperatorView.widthAnchor.constraint(lessThanOrEqualTo: shareView.widthAnchor),
            thirdSeperatorView.heightAnchor.constraint(equalToConstant: 0.5),
            
            cancelButton.centerXAnchor.constraint(lessThanOrEqualTo: shareView.centerXAnchor),
            cancelButton.topAnchor.constraint(equalTo: thirdSeperatorView.bottomAnchor, constant: 5)
            ])
        
    }
    
    @objc func cancelTapped(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.overlayView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.shareView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
            }
            
        }, completion: nil)
    }
    
    func showView(){
        if let window = UIApplication.shared.keyWindow {
            
            overlayView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            overlayView.alpha = 0
            
            window.addSubview(overlayView)
            window.addSubview(shareView)
            
            self.overlayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissTapped)))
            
            self.overlayView.frame = window.frame
            
            shareView.backgroundColor = UIColor.white
            let height: CGFloat = 300.0
            let y = window.frame.height - height
            self.shareView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.overlayView.alpha = 1
                self.shareView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: window.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func dismissTapped() {
        if let window = UIApplication.shared.keyWindow {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.overlayView.alpha = 0
                self.shareView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
            }, completion: nil)
        }
    }
    
}


extension ShareViewVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.socialCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialId", for: indexPath) as! SocialCell
            cell.button.setImage(UIImage(named: socialArray[indexPath.item])?.withRenderingMode(.alwaysOriginal), for: .normal)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainId, for: indexPath) as! MainCell
            cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
            cell.nameLabel.text = names[indexPath.item]
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.socialCollection {
            return socialArray.count
        } else {
            return imageNames.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.socialCollection {
            return CGSize(width: socialCollection.frame.height, height: socialCollection.frame.height)
        } else {
            return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
        }
    }
    
    
}

class MainCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "avatar")?.withRenderingMode(.alwaysOriginal))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.backgroundColor = UIColor.white
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 1.0
        image.layer.cornerRadius = 40
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mahmoud Saeed"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "dodasaeed"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        
        
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(nickNameLabel)
        
        
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            
            nickNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nickNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5)
            ])
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SocialCell: UICollectionViewCell {
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Twitter")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            button.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
            ])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
