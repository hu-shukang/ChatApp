//
//  ConversationsViewModel.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/29.
//

import SwiftUI

class ConversationsViewModel: ObservableObject {
    @Published var recentMessages = [Message]()
    
    static let shared = ConversationsViewModel()
    
    func fetchRecentMessages() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let query = COLLECTION_MESSAGES.document(uid)
            .collection("recent-messages")
            .order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, _ in
            if let modified = snapshot?.documentChanges.filter({ $0.type == .modified }) {
                let modifiedMessages = modified.compactMap { msg in
                    try? msg.document.data(as: Message.self)
                }
                for ms in modifiedMessages {
                    if let index = self.recentMessages.firstIndex(where: { $0.id == ms.id }) {
                        self.recentMessages[index] = ms
                    }
                }
            }
            if let added = snapshot?.documentChanges.filter({ $0.type == .added }) {
                let newMessages = added.compactMap { msg in
                    try? msg.document.data(as: Message.self)
                }
                self.recentMessages.append(contentsOf: newMessages)
            }
            
            self.recentMessages = self.recentMessages.sorted { m1, m2 in
                return m1.timestamp.dateValue() > m2.timestamp.dateValue()
            }
        }
            
        query.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.recentMessages = documents.compactMap({ try? $0.data(as: Message.self) })
        }
    }
}
