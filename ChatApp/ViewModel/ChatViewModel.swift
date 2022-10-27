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
        fetchUsers()
    }
    
    func sendMessage(to: User) {
        guard let currentId = AuthViewModel.shared.userSession?.uid else { return }
        guard let chatPartnerId = to.id else { return }
        
        let currentUserRef = COLLECTION_MESSAGES.document(currentId).collection(chatPartnerId).document()
        let chatPartnerRef = COLLECTION_MESSAGES.document(chatPartnerId).collection(currentId)
        
        let messageId = currentUserRef.documentID
        let data: [String: Any] = ["text": sendMessageText, "fromId": currentId, "toId": chatPartnerId, "read": false, "timestamp": Timestamp(date: Date())]
        currentUserRef.setData(data)
        chatPartnerRef.document(messageId).setData(data)
        
//        let message = Message(isFromCurrentUser: true, messageText: sendMessageText)
//        messages.append(message)
        
        sendMessageText = ""
    }
    
    func fetchUsers() {
        COLLECTION_USERS.whereField("uid", isNotEqualTo: Auth.auth().currentUser?.uid ?? "").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.users = documents.compactMap({ try? $0.data(as: User.self) })
        }
    }
}
