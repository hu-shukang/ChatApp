//
//  ChatsPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import SwiftUI

struct ChatPage: View {
    @StateObject var chatVM = ChatViewModel()
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
            MessageInput(isEditing: $isEditing)
                .environmentObject(chatVM)
            
        }
        .navigationTitle("UserName")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatPage_Previews: PreviewProvider {
    static var previews: some View {
        ChatPage()
    }
}
