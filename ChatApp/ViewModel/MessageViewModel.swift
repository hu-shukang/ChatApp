//
//  MessageViewModel.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/11/16.
//

import Firebase
import SwiftUI

class MessageViewModel: ObservableObject {
    @Published var user: User?
    let message: Message
    
    init(_ message: Message) {
        self.message = message
        fetchUser()
    }
    
    var currentUid: String {
        return AuthViewModel.shared.userSession?.uid ?? ""
    }
    
    var chatPartnerId: String {
        if message.fromId == currentUid {
            return message.id!
        }
        return  message.fromId
    }
    
    var fullname: String {
        return user?.fullname ?? ""
    }
    
    func fetchUser() {
        COLLECTION_USERS.document(chatPartnerId).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else {
                return
            }
            self.user = user;
        }
    }
}
