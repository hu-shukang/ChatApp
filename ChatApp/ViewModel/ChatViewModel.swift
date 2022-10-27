//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/22.
//

import SwiftUI
import Firebase

class ChatViewModel: ObservableObject {
    private let user: User
    
    @Published var sendMessageText: String = ""
    @Published var messages: [Message] = []
    
    init(to user: User) {
        self.user = user
    }
    
    func sendMessage() {
        guard let currentId = AuthViewModel.shared.userSession?.uid else { return }
        guard let chatPartnerId = self.user.id else { return }
        
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
    
    
}
