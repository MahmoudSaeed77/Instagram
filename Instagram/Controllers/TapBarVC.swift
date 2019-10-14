//
//  TapBarVC.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 10/12/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class TapBarVC: UITabBarController {
    
//    let kBarHeight: CGFloat = 75.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeVC()
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "home")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "home2")?.withRenderingMode(.alwaysOriginal))
        
        let profileVC = ProfileVC()
        profileVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "profileNone")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "Profile")?.withRenderingMode(.alwaysOriginal))
        
        
        
        let tapList = [homeVC, profileVC]
        
        viewControllers = tapList
        
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        tabBar.frame.size.height = kBarHeight
//        tabBar.frame.origin.y = view.frame.height - kBarHeight
//    }
    
}
