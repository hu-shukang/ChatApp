//
//  ConversationsPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import SwiftUI

struct ConversationsPage: View {
    @EnvironmentObject var chatVM: ChatViewModel
    @EnvironmentObject var router: Router
    @State private var showNewMessageSheet = false
    @State private var showChatPage = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // MARK: - chats
            ScrollView {
                VStack {
                    ForEach(chatVM.users) { user in
                        ConversationCell(user: user)
                            .onTapGesture {
                                router.path.append(user)
                            }
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
                    .environmentObject(chatVM)
                    .environmentObject(router)
            }
        }
        .frame(maxWidth: .infinity)
        .navigationDestination(for: User.self) { user in
            ChatPage(user: user)
                .environmentObject(chatVM)
        }
    }
}

struct ConversationsPage_Previews: PreviewProvider {
    @StateObject static var router = Router()
    static var previews: some View {
        NavigationStack(path: $router.path) {
            ConversationsPage()
                .environmentObject(ChatViewModel())
                .environmentObject(router)
        }
    }
}
