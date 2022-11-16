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
            
        query.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.recentMessages = documents.compactMap({ try? $0.data(as: Message.self) })
        }
    }
}
