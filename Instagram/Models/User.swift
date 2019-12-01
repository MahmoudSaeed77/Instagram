//
//  User.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 11/22/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import Foundation

struct User {
    let firstName: String
    let lastName: String
    let imageUrl: String
    let fullName: String
    let uid: String
    init(dictionary: [String:Any]) {
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.fullName = "\(firstName) \(lastName)"
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
