//
//  TapBarVC.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 10/12/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class TapBarVC: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            let photosVC = PhotoSelectorController()
            let photosController = UINavigationController(rootViewController: photosVC)
            present(photosController, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupControllers()
        
    }
    func setupControllers() {
        let homeVC = HomeVC()
        let homeController = UINavigationController(rootViewController: homeVC)
        homeController.tabBarItem.image = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        homeController.tabBarItem.selectedImage = UIImage(named: "home-filled")?.withRenderingMode(.alwaysOriginal)
        
        
        let searchVC = SearchVC()
        let SearchController = UINavigationController(rootViewController: searchVC)
        SearchController.tabBarItem.image = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        SearchController.tabBarItem.selectedImage = UIImage(named: "search-filled")?.withRenderingMode(.alwaysOriginal)
        
        
        
        let photosVC = PhotoSelectorController()
        let photosController = UINavigationController(rootViewController: photosVC)
        photosController.tabBarItem.image = UIImage(named: "photo")?.withRenderingMode(.alwaysOriginal)
        photosController.tabBarItem.selectedImage = UIImage(named: "photo")?.withRenderingMode(.alwaysOriginal)
        
        
        
        let profileVC = ProfileVC()
        let profileController = UINavigationController(rootViewController: profileVC)
        profileController.tabBarItem.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        profileController.tabBarItem.selectedImage = UIImage(named: "profile-filled")?.withRenderingMode(.alwaysOriginal)
        
        
        viewControllers = [homeController, SearchController, photosController, profileController]
    }
}
