//
//  ConversationsPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import SwiftUI

struct ConversationsPage: View {
    @StateObject var conversationVM = ConversationsViewModel.shared
    @StateObject var userVM = UserViewModel.shared
    @State private var showNewMessageSheet = false
    @State private var showChatPage = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // MARK: - chats
            ScrollView {
                VStack {
                    ForEach(conversationVM.recentMessages) { msg in
                        ConversationCell(messageVM: MessageViewModel(msg))
                    }
                }
            }
            
            // MARK: - floating button
            Button(action: {
                showNewMessageSheet.toggle()
            }, label: {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding()
            })
            .foregroundColor(.white)
            .background(Color.customBlue)
            .clipShape(Circle())
            .padding()
            .sheet(isPresented: $showNewMessageSheet) {
                NewMessagePage(showChatsPage: $showChatPage)
            }
        }
        .onAppear {
            conversationVM.fetchRecentMessages()
        }
        .frame(maxWidth: .infinity)
        .navigationDestination(for: User.self) { user in
            ChatPage(user: user)
        }
        
    }
}

struct ConversationsPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ConversationsPage()
        }
    }
}
