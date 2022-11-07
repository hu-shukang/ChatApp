//
//  ChatsPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import SwiftUI

struct ChatPage: View {
    var user: User
    @ObservedObject var chatVM: ChatViewModel
    @FocusState var isEditing: Bool
    
    init(user: User) {
        self.user = user
        chatVM = ChatViewModel(to: user)
    }
    
    var body: some View {
        VStack {
            // MARK: - messages
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(chatVM.messages) { message in
                        ChatMessage(message: message, user: user)
                    }
                }
            }
            .onTapGesture {
                isEditing = false
            }
            
            // MARK: - input
            MessageInput(isEditing: $isEditing)
            
        }
        .navigationTitle(user.username)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatPage_Previews: PreviewProvider {
    static var previews: some View {
        ChatPage(user: .init())
    }
}
