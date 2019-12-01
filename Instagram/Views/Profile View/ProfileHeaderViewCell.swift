//
//  ProfileHeaderViewCell.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 11/22/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Firebase

class ProfileHeaderViewCell: UICollectionViewCell {
    
    var portrait = [NSLayoutConstraint]()
    var landScape = [NSLayoutConstraint]()
    
    let coverImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "image")?.withRenderingMode(.alwaysOriginal))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.flatWhite
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.white
        return label
    }()
    
    let bioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "IOS Developer & #LIFE RUNS ON CODE"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.white
        return label
    }()
    
    let overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.brown
        view.layer.opacity = 0.3
        return view
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "thumb")?.withRenderingMode(.alwaysTemplate), for: .normal)
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "card")?.withRenderingMode(.alwaysTemplate), for: .normal)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "photosOfYou")?.withRenderingMode(.alwaysTemplate), for: .normal)
        return button
    }()
    
    let mapButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "map")?.withRenderingMode(.alwaysTemplate), for: .normal)
        return button
    }()
    
    let categoryStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.backgroundColor = UIColor.white
        stack.tintColor = UIColor.black
        return stack
    }()
    
    lazy var followButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "follow")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(followAction), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    @objc func followAction() {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        guard let uid = user?.uid else {return}
        
        if followButton.tintColor == UIColor.green {
            let dataRef = Database.database().reference().child("following").child(currentUid).child(uid)
            dataRef.removeValue { (err, refernce) in
                if let err = err {
                    print("follow remove error:", err)
                    return
                }
                print("success remove follow")
                self.self.followButton.tintColor = UIColor.red
            }
        } else {
            let dataRef = Database.database().reference().child("following").child(currentUid)
            let values = [uid: 1]
            dataRef.updateChildValues(values) { (err, refernce) in
                if let err = err {
                    print("error following:", err)
                    return
                }
                print("successfully following ", self.user?.fullName ?? "")
                self.self.followButton.tintColor = UIColor.green
            }
        }
    }
    
    
    
    
    
    var user: User? {
        didSet {
            downloadProfileImage()
            
            guard let currentUserId = Auth.auth().currentUser?.uid else {return}
            
            guard let userId = user?.uid else {return}
            
            
            if currentUserId == userId {
                followButton.isHidden = true
            } else {
                followButton.isHidden = false
                let dataRef = Database.database().reference().child("following").child(currentUserId).child(userId)
                dataRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    guard let value = snapshot.value as? Int else {return}
                    if value == 1 {
                        self.followButton.tintColor = UIColor.green
                    } else {
                        self.followButton.tintColor = UIColor.red
                    }
                }) { (err) in
                    print("error obtain data", err)
                }
                
            }
            
            
        }
    }
    
    func downloadProfileImage(){
        guard let url = URL(string: self.user?.imageUrl ?? "") else {return}
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, err) in
            if let err = err {
                print("fetching profile image error", err)
            }
            guard let data = data else {return}
            guard let image = UIImage(data: data)?.withRenderingMode(.alwaysOriginal) else {return}
            DispatchQueue.main.async {
                self.profileImage.image = image
            }
        }).resume()
    }
    
    func setupView(){
        backgroundColor = UIColor.white
        
        addSubview(coverImage)
        addSubview(overlayView)
        addSubview(followButton)
        addSubview(profileImage)
        addSubview(nameLabel)
        addSubview(bioLabel)
        addSubview(categoryStack)
        categoryStack.addArrangedSubview(gridButton)
        categoryStack.addArrangedSubview(listButton)
        categoryStack.addArrangedSubview(bookmarkButton)
        categoryStack.addArrangedSubview(mapButton)
        
        followButton.isHidden = true
        
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            coverImage.widthAnchor.constraint(equalTo: widthAnchor),
            coverImage.topAnchor.constraint(equalTo: topAnchor),
            coverImage.bottomAnchor.constraint(equalTo: categoryStack.topAnchor),
            
            overlayView.widthAnchor.constraint(equalTo: widthAnchor),
            overlayView.bottomAnchor.constraint(equalTo: categoryStack.topAnchor),
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            
            followButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            followButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            
            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImage.widthAnchor.constraint(equalToConstant: 80),
            profileImage.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            
            bioLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            
            categoryStack.widthAnchor.constraint(equalTo: widthAnchor),
            categoryStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            categoryStack.heightAnchor.constraint(equalToConstant: 60),
            
            
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
