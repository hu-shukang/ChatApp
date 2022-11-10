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
    @Published var messageDic: Dictionary<String, [Message]> = [:]
    
    static let shared = ChatViewModel()
    
    func fetchMessages(user: User) {
        guard let currentId = AuthViewModel.shared.userSession?.uid else { return }
        guard let chatPartnerId = user.id else { return }
        
        let query = COLLECTION_MESSAGES
            .document(currentId)
            .collection(chatPartnerId)
            .order(by: "timestamp", descending: false)
        
        print("DEBUG: currentId = \(currentId)")
        print("DEBUG: chatPartnerId = \(chatPartnerId)")
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            let newMessages = changes.compactMap { documentChanged in
                try? documentChanged.document.data(as: Message.self)
            }
            var messages = self.messageDic[chatPartnerId] ?? []
            messages.append(contentsOf: newMessages)
            self.messageDic.updateValue(messages, forKey: chatPartnerId)
        }
        
        query.getDocuments { snapshot, error in
            guard let document = snapshot?.documents else { return }
            let messages = document.compactMap({ documentSnapshot in
                try? documentSnapshot.data(as: Message.self)
            })
            self.messageDic.updateValue(messages, forKey: chatPartnerId)
        }
    }
    
    func sendMessage(user: User) {
        guard let currentId = AuthViewModel.shared.userSession?.uid else { return }
        guard let chatPartnerId = user.id else { return }
        
        let currentUserRef = COLLECTION_MESSAGES.document(currentId).collection(chatPartnerId).document()
        let chatPartnerRef = COLLECTION_MESSAGES.document(chatPartnerId).collection(currentId)
        
        let recentCurrentRef = COLLECTION_MESSAGES.document(currentId).collection("recent-messages").document(chatPartnerId)
        let recentPartnerRef = COLLECTION_MESSAGES.document(chatPartnerId).collection("recent-messages").document(currentId)
        
        let messageId = currentUserRef.documentID
        let data: [String: Any] = ["text": sendMessageText, "fromId": currentId, "toId": chatPartnerId, "read": false, "timestamp": Timestamp(date: Date())]
        currentUserRef.setData(data)
        chatPartnerRef.document(messageId).setData(data)
        
        recentCurrentRef.setData(data)
        recentPartnerRef.setData(data)
        
        sendMessageText = ""
    }
    
    
}
