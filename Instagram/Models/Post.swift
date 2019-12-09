//
//  Post.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 11/24/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import Foundation
struct Post {
    var id: String?
    var isLiked = false
    let imageUrl: String
    let caption: String
    let user: User
    let postData: Date
    init(user: User, dictionary: [String:Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.user = user
        let secondsData = dictionary["postDate"] as? Double ?? 0
        self.postData = Date(timeIntervalSince1970: secondsData)
        
    }
}
