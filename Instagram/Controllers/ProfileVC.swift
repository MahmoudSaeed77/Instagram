//
//  ProfileVC.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 10/12/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Firebase



class ProfileVC: UIViewController {
    let picturesId = "picturesId"
    let headerId = "headerId"
    
    var userId: String?
    
    var profileView = ProfileView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = profileView
        collectionViewsConfigrations()
        fetchUser()
//        fetchPosts()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        let rightButton = UIBarButtonItem(image: UIImage(named: "setting25"), style: .done, target: self, action: #selector(moreAction))
        rightButton.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = rightButton
    }

    
    
    func collectionViewsConfigrations(){
        profileView.MainCollectionView.delegate = self
        profileView.MainCollectionView.dataSource = self
        profileView.MainCollectionView.register(ProfileHeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        profileView.MainCollectionView.register(PicturesCell.self, forCellWithReuseIdentifier: picturesId)
    }
    
    
    
    
    @objc func moreAction(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        self.present(alert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
        let action = UIAlertAction(title: "Logout", style: .destructive) { (_) in
            self.signingOut()
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(action)
    }
    
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func signingOut(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let vc = StartController()
            let rootNavigation = UINavigationController(rootViewController: vc)
            self.present(rootNavigation, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
    
    var user: User? {
        didSet {
            fetchPosts()
        }
    }
    fileprivate func fetchUser() {
        
        let uid = userId ?? Auth.auth().currentUser?.uid ?? ""
        
        let userRef = Database.database().reference().child("users").child(uid)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictValues = snapshot.value as? [String: Any] else {return}
            self.user = User(dictionary: dictValues)
            self.title = self.user?.fullName
            self.profileView.MainCollectionView.reloadData()
        }) { (err) in
            print("fetching user info error:", err)
        }
    }
    var posts = [Post]()
    fileprivate func fetchPosts() {
        guard let uid = self.user?.uid else {return}
            let dataRef = Database.database().reference().child("posts").child(uid)
            dataRef.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionaries = snapshot.value as? [String:Any] else {return}
                dictionaries.forEach({ (key, value) in
                    guard let dictionary = value as? [String:Any] else {return}
                    guard let user = self.user else {return}
                    let post = Post(user: user, dictionary: dictionary)
                    self.posts.append(post)
                })
                self.profileView.MainCollectionView.reloadData()
            }) { (err) in
                print("error fetching posts:", err)
            }
    }
}

extension ProfileVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picturesId, for: indexPath) as! PicturesCell
        cell.post = posts[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ProfileHeaderViewCell
        header.user = self.user
        header.nameLabel.text = self.navigationItem.title
        return header
    }
}
extension ProfileVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: profileView.MainCollectionView.frame.width / 3 - 1, height: profileView.MainCollectionView.frame.width / 3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: profileView.MainCollectionView.frame.width, height: 300)
    }
}
