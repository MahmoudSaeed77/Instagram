//
//  SearchVC.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 11/27/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class SearchVC: UIViewController {
    let cellId = "cellId"
    let searchView = SearchView()
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.placeholder = "Search here..."
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.init(red: 240, green: 240, blue: 240, alpha: 0.5)
        search.delegate = self
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.show()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        searchView.collectionView.refreshControl = refreshControl
        
        
        
        view = searchView
        self.navigationController?.navigationBar.addSubview(searchBar)
        let nav = navigationController?.navigationBar
        NSLayoutConstraint.activate([
            searchBar.widthAnchor.constraint(equalTo: (nav?.widthAnchor)!),
            searchBar.heightAnchor.constraint(equalTo: (nav?.heightAnchor)!)
            ])
        self.searchView.collectionView.delegate = self
        self.searchView.collectionView.dataSource = self
        self.searchView.collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
        self.searchView.collectionView.keyboardDismissMode = .onDrag
        
        fetchUsers()
    }
    
    @objc fileprivate func refreshAction() {
        self.user.removeAll()
        self.searchView.collectionView.reloadData()
        fetchUsers()
        if user.count == 0 {
            self.searchView.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    @objc fileprivate func loadPosts() {
        refreshAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.isHidden = false
    }
    
    var user = [User]()
    var filteredUsers = [User]()
    fileprivate func fetchUsers() {
        let usersRef = Database.database().reference().child("users")
        usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictValues = snapshot.value as? [String: Any] else {return}
            dictValues.forEach({ (key, value) in
                
                if key == Auth.auth().currentUser?.uid {
                    return
                }
                
                guard let values = value as? [String: Any] else {return}
                let user = User(dictionary: values)
                self.user.append(user)
                print(key, user.fullName)
            })
            self.user.sort(by: { (u1, u2) -> Bool in
                return u1.fullName.compare(u2.fullName) == .orderedAscending
            })
            self.searchView.collectionView.reloadData()
            self.filteredUsers = self.user
            ProgressHUD.dismiss()
            self.searchView.collectionView.refreshControl?.endRefreshing()
        }) { (err) in
            print("error fetching users:", err)
        }
    }
    
}


extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        cell.user = filteredUsers[indexPath.item]
        return cell
    }
}
extension SearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.searchView.collectionView.frame.width, height: 100)
    }
}
extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            filteredUsers = user
        } else {
            filteredUsers = self.user.filter { (user) -> Bool in
                return user.fullName.lowercased().contains(searchText.lowercased())
            }
        }
        self.searchView.collectionView.reloadData()
    }
}
extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchBar.isHidden = true
        searchBar.resignFirstResponder()
        let user = filteredUsers[indexPath.item]
        print(user.fullName)
        let vc = ProfileVC()
        vc.userId = user.uid
        navigationController?.pushViewController(vc, animated: true)
    }
}
