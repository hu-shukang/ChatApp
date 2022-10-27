//
//  ChatsPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import SwiftUI

struct ChatPage: View {
    @EnvironmentObject var chatVM: ChatViewModel
    var user: User
    @FocusState var isEditing: Bool
    
    var body: some View {
        VStack {
            // MARK: - messages
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(chatVM.messages) { message in
                        ChatMessage(message: message)
                            .environmentObject(chatVM)
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
        .navigationTitle(user.username)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatPage_Previews: PreviewProvider {
    static var previews: some View {
        ChatPage(user: .init())
            .environmentObject(ChatViewModel())
    }
}
