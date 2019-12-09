//
//  Comment.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 12/3/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import Foundation


struct Comment {
    let text: String
    let uid: String
    let commentDate: Date
    let user: User
    init(user: User, dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        let date = dictionary["commentDate"] as? Double ?? 0
        self.commentDate = Date(timeIntervalSince1970: date)
        self.uid = dictionary["uid"] as? String ?? ""
        self.user = user
    }
}
