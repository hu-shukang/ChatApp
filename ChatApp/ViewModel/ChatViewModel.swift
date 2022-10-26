//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/22.
//

import SwiftUI
import Firebase

class ChatViewModel: ObservableObject {
    @Published var sendMessageText: String = ""
    @Published var messages: [Message] = []
    @Published var users: [User] = []
    
    init() {
        self.fetchUsers()
    }
    
    func sendMessage() {
        let message = Message(isFromCurrentUser: true, messageText: sendMessageText)
        messages.append(message)
        sendMessageText = ""
    }
    
    func fetchUsers() {
        COLLECTION_USERS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.users = documents.compactMap({ try? $0.data(as: User.self) })
        }
    }
}
