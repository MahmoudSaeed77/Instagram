//
//  Post.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 11/24/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import Foundation
struct Post {
    let imageUrl: String
    let caption: String
    let user: User
    init(user: User, dictionary: [String:Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.user = user
    }
}
