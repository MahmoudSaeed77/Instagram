//
//  HomeVC.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 10/12/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD


class HomeVC: UIViewController {
    var homeView = HomeView()
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
        
        let name = NSNotification.Name(rawValue: "loadPosts")
        NotificationCenter.default.addObserver(self, selector: #selector(loadPosts), name: name, object: nil)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        homeView.collectionView.refreshControl = refreshControl
        
        setupDelegate()
        setupNavigation()
        fetchPosts()
        fetchFollowingPosts()
    }
    
    @objc fileprivate func refreshAction() {
        self.posts.removeAll()
        self.homeView.collectionView.reloadData()
        fetchPosts()
        fetchFollowingPosts()
        posts.sort { (p1, p2) -> Bool in
            return p1.postData.compare(p2.postData) == .orderedAscending
        }
        if posts.count == 0 {
            self.homeView.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    @objc fileprivate func loadPosts() {
        refreshAction()
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
                    var post = Post(user: user, dictionary: dictionary)
                    post.id = key
                    let likeRef = Database.database().reference().child("likes").child(key).child(uid)
                    likeRef.observeSingleEvent(of: .value, with: { (snapshot) in
                        if let value = snapshot.value as? Int, value == 1 {
                            post.isLiked = true
                        } else {
                            post.isLiked = false
                        }
                        self.posts.append(post)
                        self.homeView.collectionView.reloadData()
                    }, withCancel: { (err) in
                        print("fetch likes error:", err)
                        ProgressHUD.showError("Network error try again later!", interaction: true)
                    })
                })
            }) { (err) in
                print("error fetching posts:", err)
                ProgressHUD.showError("Network error try again later!", interaction: true)
            }
        }) { (err) in
            print("fetch name error:", err)
            ProgressHUD.showError("Network error try again later!", interaction: true)
        }
    }
    
    fileprivate func fetchFollowingPosts() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let dataRef = Database.database().reference().child("following").child(uid)
        dataRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let valuesDict = snapshot.value as? [String: Any] else {return}
            valuesDict.forEach({ (key, value) in
                let userRef = Database.database().reference().child("users").child(key)
                userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    guard let userValues = snapshot.value as? [String:Any] else {return}
                    let user = User(dictionary: userValues)
                    let dataRef = Database.database().reference().child("posts").child(key)
                    dataRef.observeSingleEvent(of: .value, with: { (snapshot) in
                        self.homeView.collectionView.refreshControl?.endRefreshing()
                        guard let dictionaries = snapshot.value as? [String:Any] else {return}
                        dictionaries.forEach({ (key, value) in
                            guard let dictionary = value as? [String:Any] else {return}
                            var post = Post(user: user, dictionary: dictionary)
                            post.id = key
                            let likeRef = Database.database().reference().child("likes").child(key).child(uid)
                            likeRef.observeSingleEvent(of: .value, with: { (snapshot) in
                                if let value = snapshot.value as? Int, value == 1 {
                                    post.isLiked = true
                                } else {
                                    post.isLiked = false
                                }
                                self.posts.append(post)
                                self.homeView.collectionView.reloadData()
                            }, withCancel: { (err) in
                                print("fetch likes error:", err)
                                ProgressHUD.showError("Network error try again later!", interaction: true)
                            })
                        })
                        
                    }) { (err) in
                        print("error fetching posts:", err)
                        ProgressHUD.showError("Network error try again later!", interaction: true)
                    }
                }) { (err) in
                    print("fetch name error:", err)
                    ProgressHUD.showError("Network error try again later!", interaction: true)
                }
            })
        }) { (err) in
            print("error fetching following users:", err)
            ProgressHUD.showError("Network error try again later!", interaction: true)
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
        self.posts.sort { (p1, p2) -> Bool in
            return p1.postData.compare(p2.postData) == .orderedDescending
        }
        cell.post = posts[indexPath.item]
        cell.delegate = self
        return cell
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = collectionView.frame.width + 100
        return CGSize(width: collectionView.frame.width - 18, height: height)
    }
}

extension HomeVC: HomeCellProtocol {
    
    func likeTapped(cell: HomeCell) {
        guard let indexPath = homeView.collectionView.indexPath(for: cell) else {return}
        var post = self.posts[indexPath.item]
        print(post.caption)
        
        guard let postId = post.id else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let dataRef = Database.database().reference().child("likes").child(postId)
        let values = [uid: post.isLiked == true ? 0 : 1]
        dataRef.updateChildValues(values) { (err, _) in
            if let err = err {
                print("like post error:", err)
                ProgressHUD.showError("Network error try again later!", interaction: true)
            }
            
            print("successfully like post...")
            
            post.isLiked = !post.isLiked
            self.posts[indexPath.item] = post
            self.homeView.collectionView.reloadItems(at: [indexPath])
        }
    }
    
    func commentTapped(post: Post) {
        print(post.caption)
        let vc = CommentVC()
        vc.post = post
        navigationController?.pushViewController(vc, animated: true)
    }
}
