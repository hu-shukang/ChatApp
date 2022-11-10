//
//  ChatsPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import SwiftUI

struct ChatPage: View {
    var user: User
    @StateObject var chatVM = ChatViewModel.shared
    @FocusState var isEditing: Bool
    
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        VStack {
            // MARK: - messages
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(chatVM.messageDic[user.uid] ?? []) { message in
                        ChatMessage(message: message, user: user)
                    }
                }
            }
            .onTapGesture {
                isEditing = false
            }
            
            // MARK: - input
            MessageInput(isEditing: $isEditing, user: user)
                .environmentObject(chatVM)
            
        }
        .onAppear(perform: {
            if chatVM.messageDic[user.uid] == nil {
                chatVM.fetchMessages(user: user)
            }
        })
        .navigationTitle(user.username)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatPage_Previews: PreviewProvider {
    static var previews: some View {
        ChatPage(user: .init())
    }
}
