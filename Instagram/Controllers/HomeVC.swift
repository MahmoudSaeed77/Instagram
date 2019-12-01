//
//  HomeVC.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 10/12/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    var homeView = HomeView()
    let cellId = "cellId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
        setupDelegate()
        setupNavigation()
        fetchPosts()
        fetchFollowingPosts()
    }
    
    fileprivate func setupDelegate() {
        homeView.collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
    }
    
    
    var posts = [Post]()
    fileprivate func fetchPosts() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let userRef = Database.database().reference().child("users").child(uid)
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let userValues = snapshot.value as? [String:Any] else {return}
            let user = User(dictionary: userValues)
            let dataRef = Database.database().reference().child("posts").child(uid)
            dataRef.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionaries = snapshot.value as? [String:Any] else {return}
                dictionaries.forEach({ (key, value) in
                    guard let dictionary = value as? [String:Any] else {return}
                    let post = Post(user: user, dictionary: dictionary)
                    self.posts.append(contentsOf: [post])
                })
                self.homeView.collectionView.reloadData()
            }) { (err) in
                print("error fetching posts:", err)
            }
            
        }) { (err) in
            print("fetch name error:", err)
        }
    }
    
    fileprivate func fetchFollowingPosts() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let dataRef = Database.database().reference().child("following").child(uid)
        dataRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let valuesDict = snapshot.value as? [String: Any] else {return}
            print(valuesDict)
            valuesDict.forEach({ (key, value) in
                print(key)
                let userRef = Database.database().reference().child("users").child(key)
                userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    guard let userValues = snapshot.value as? [String:Any] else {return}
                    print(userValues)
                    let user = User(dictionary: userValues)
                    let dataRef = Database.database().reference().child("posts").child(key)
                    dataRef.observeSingleEvent(of: .value, with: { (snapshot) in
                        guard let dictionaries = snapshot.value as? [String:Any] else {return}
                        print(dictionaries)
                        dictionaries.forEach({ (key, value) in
                            guard let dictionary = value as? [String:Any] else {return}
                            print(dictionary)
                            let post = Post(user: user, dictionary: dictionary)
                            self.posts.append(contentsOf: [post])
                        })
                        self.homeView.collectionView.reloadData()
                    }) { (err) in
                        print("error fetching posts:", err)
                    }
                }) { (err) in
                    print("fetch name error:", err)
                }
            })
        }) { (err) in
            print("error fetching following users:", err)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    fileprivate func setupNavigation() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "Bitmap")?.withRenderingMode(.alwaysOriginal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "new_Message")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: nil)
    }
}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
        cell.post = posts[indexPath.item]
        return cell
    }
    
    
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = collectionView.frame.width + 70
        return CGSize(width: collectionView.frame.width - 18, height: height)
    }
}

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
