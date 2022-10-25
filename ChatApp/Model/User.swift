//
//  User.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/25.
//

import SwiftUI
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
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
}
