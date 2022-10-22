//
//  ConversationsPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import SwiftUI

struct ConversationsPage: View {
    @State private var showNewMessageSheet = false
    @State private var showChatPage = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            NavigationLink(destination: ChatPage(), isActive: $showChatPage, label: {})
            
            // MARK: - chats
            ScrollView {
                VStack {
                    ForEach((0 ... 10), id: \.self) { _ in
                        NavigationLink(destination: {
                            ChatPage()
                        }, label: {
                            ConversationCell()
                        })
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
    }
}

struct ConversationsPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ConversationsPage()
        }
    }
}
