//
//  ProfileHeaderViewCell.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 11/22/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import ProgressHUD

protocol HeaderCellDelegate {
    func gridView()
    func listView()
}

class ProfileHeaderViewCell: UICollectionViewCell {
    
    var delegate: HeaderCellDelegate?
    
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
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    lazy var gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "thumb-filled")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(gridTapped), for: .touchUpInside)
        button.tintColor = UIColor.purple
        return button
    }()
    
    @objc func gridTapped() {
        print("grid in cell")
        delegate?.gridView()
        gridButton.setImage(UIImage(named: "thumb-filled")?.withRenderingMode(.alwaysTemplate), for: .normal)
        gridButton.tintColor = UIColor.purple
        listButton.setImage(UIImage(named: "card")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    lazy var listButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "card")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(listTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func listTapped() {
        print("list in cell")
        delegate?.listView()
        listButton.setImage(UIImage(named: "card-filled")?.withRenderingMode(.alwaysTemplate), for: .normal)
        listButton.tintColor = UIColor.purple
        gridButton.setImage(UIImage(named: "thumb")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    
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
        button.tintColor = .red
        return button
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(hexString: "#C5C5C5")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        check()
        setupView()
        setupConstraints()
    }
    
    fileprivate func check() {
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
                    DispatchQueue.main.async {
                        self.followButton.tintColor = UIColor.green
                    }
                } else {
                    DispatchQueue.main.async {
                        self.followButton.tintColor = UIColor.red
                    }
                }
            }) { (err) in
                print("error obtain data", err)
            }
        }
    }
    
    @objc func followAction() {
        ProgressHUD.show()
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        guard let uid = user?.uid else {return}
        
        if followButton.tintColor == UIColor.green {
            let dataRef = Database.database().reference().child("following").child(currentUid).child(uid)
            dataRef.removeValue { (err, refernce) in
                if let err = err {
                    print("follow remove error:", err)
                    ProgressHUD.showError("Error unfollowing account!", interaction: true)
                    return
                }
                print("success remove follow")
                ProgressHUD.showSuccess("Successfully unfollowed!")
                self.self.followButton.tintColor = UIColor.red
            }
        } else {
            let dataRef = Database.database().reference().child("following").child(currentUid)
            let values = [uid: 1]
            dataRef.updateChildValues(values) { (err, refernce) in
                if let err = err {
                    print("error following:", err)
                    ProgressHUD.showError("Error following account!", interaction: true)
                    return
                }
                print("successfully following ", self.user?.fullName ?? "")
                ProgressHUD.showSuccess("Successfully followed!")
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
                        DispatchQueue.main.async {
                            self.followButton.tintColor = UIColor.green
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.followButton.tintColor = UIColor.red
                        }
                    }
                }) { (err) in
                    print("error obtain data", err)
                }
            }
            
            DispatchQueue.main.async {
                self.nameLabel.text = self.user?.fullName
            }
        }
    }
    
    func downloadProfileImage(){
        guard let url = URL(string: self.user?.imageUrl ?? "") else {return}
        profileImage.kf.setImage(with: url)
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
        addSubview(separatorView)
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
            
            separatorView.widthAnchor.constraint(equalTo: widthAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
