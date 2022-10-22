//
//  ChatMessage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/22.
//

import SwiftUI

struct ChatMessage: View {
    @EnvironmentObject var chatVM: ChatViewModel
    let message: Message
    
    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer()
                
                HStack(alignment: .bottom) {
                    Text(message.messageText)
                        .padding(12)
                        .background(Color.customBlue)
                        .font(.system(size: 15))
                        .clipShape(ChatBubble(isFromCurrentUser: message.isFromCurrentUser))
                        .foregroundColor(.white)
                    
                    Avator(image: Image("avator"), size: 32)
                }
                .padding(.trailing)
                .padding(.leading, 80)
            } else {
                HStack(alignment: .bottom) {
                    Avator(image: Image("avator"), size: 32)
                    
                    Text(message.messageText)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .font(.system(size: 15))
                        .clipShape(ChatBubble(isFromCurrentUser: message.isFromCurrentUser))
                        .foregroundColor(.customBlack)
                }
                .padding(.leading)
                .padding(.trailing, 80)
                Spacer()
            }
        }
    }
}

struct ChatMessage_Previews: PreviewProvider {
    @StateObject static var chatVM = ChatViewModel()
    static var previews: some View {
        VStack {
            ChatMessage(message: .init(isFromCurrentUser: true, messageText: "Hello world"))
                .environmentObject(chatVM)
            ChatMessage(message: .init(isFromCurrentUser: false, messageText: "Hello"))
                .environmentObject(chatVM)
        }
    }
}