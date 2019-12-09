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
    let homeId = "homeId"
    
    var userId: String?
    
    var cellSelected = false
    
    var profileView = ProfileView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = profileView
        
        
        let name = NSNotification.Name(rawValue: "loadPosts")
        NotificationCenter.default.addObserver(self, selector: #selector(loadPosts), name: name, object: nil)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        profileView.MainCollectionView.refreshControl = refreshControl
        
        
        collectionViewsConfigrations()
        fetchUser()
    }
    
    @objc fileprivate func refreshAction() {
        self.posts.removeAll()
        self.profileView.MainCollectionView.reloadData()
        fetchPosts()
        posts.sort { (p1, p2) -> Bool in
            return p1.postData.compare(p2.postData) == .orderedAscending
        }
    }
    
    @objc fileprivate func loadPosts() {
        refreshAction()
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
        profileView.MainCollectionView.register(HomeCell.self, forCellWithReuseIdentifier: homeId)
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
                    var post = Post(user: user, dictionary: dictionary)
                    let likeRef = Database.database().reference().child("likes").child(key).child(uid)
                    likeRef.observeSingleEvent(of: .value, with: { (snapshot) in
                        if let value = snapshot.value as? Int, value == 1 {
                            post.isLiked = true
                        } else {
                            post.isLiked = false
                        }
                        self.posts.append(post)
                        self.profileView.MainCollectionView.reloadData()
                    }, withCancel: { (err) in
                        print("fetch likes error:", err)
                    })
                })
                self.profileView.MainCollectionView.refreshControl?.endRefreshing()
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
        
        if cellSelected == true {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeId, for: indexPath) as! HomeCell
            cell.post = posts[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picturesId, for: indexPath) as! PicturesCell
            cell.post = posts[indexPath.item]
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ProfileHeaderViewCell
        header.delegate = self
        header.user = self.user
        header.nameLabel.text = self.navigationItem.title
        return header
    }
}
extension ProfileVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if cellSelected == true {
            let height: CGFloat = self.profileView.MainCollectionView.frame.width + 100
            return CGSize(width: self.profileView.MainCollectionView.frame.width - 18, height: height)
        } else {
            return CGSize(width: profileView.MainCollectionView.frame.width / 3 - 1, height: profileView.MainCollectionView.frame.width / 3)
        }
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


extension ProfileVC: HeaderCellDelegate {
    func gridView() {
        cellSelected = false
        self.profileView.MainCollectionView.reloadData()
    }
    
    func listView() {
        cellSelected = true
        self.profileView.MainCollectionView.reloadData()
    }
    
    
}
