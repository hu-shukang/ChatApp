//
//  Message.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/22.
//

import FirebaseFirestoreSwift
import Firebase

struct Message: Identifiable, Decodable, Hashable {
    @DocumentID var id: String?
    var fromId: String
    var read: Bool
    var text: String
    var timestamp: Timestamp
    
    var isFromCurrentUser: Bool {
        fromId == UserViewModel.shared.currentUser?.uid
    }
    
    init(id: String? = nil, fromId: String, read: Bool, text: String, timestamp: Timestamp) {
        self.id = id
        self.fromId = fromId
        self.read = read
        self.text = text
        self.timestamp = timestamp
    }
}
