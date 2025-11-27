//
//  UserInfo.swift
//  NutriScan
//
//  Created by Elena Diniz on 11/24/25.
//

import Foundation
import FirebaseAuth

struct UserInfo {
    let uid: String
    let name: String?
    let email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.name = user.displayName
    }
}
