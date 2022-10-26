//
//  User.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/25.
//

import SwiftUI
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable, Hashable {
    @DocumentID var id: String?
    var uid: String
    var username: String
    var fullname: String
    var email: String
    var profileImageUrl: String
    
    init() {
        self.uid = ""
        self.username = ""
        self.fullname = ""
        self.email = ""
        self.profileImageUrl = ""
    }
    
    init(uid: String, username: String, fullname: String, email: String, profileImageUrl: String) {
        self.uid = uid
        self.username = username
        self.fullname = fullname
        self.email = email
        self.profileImageUrl = profileImageUrl
    }
}
