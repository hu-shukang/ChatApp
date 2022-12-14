//
//  ChatMessage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/22.
//

import SwiftUI

struct ChatMessage: View {
    let message: Message
    let user: User
    
    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer()
                
                HStack(alignment: .bottom) {
                    Text(message.text)
                        .padding(12)
                        .background(Color.customBlue)
                        .font(.system(size: 15))
                        .clipShape(ChatBubble(isFromCurrentUser: message.isFromCurrentUser))
                        .foregroundColor(.white)
                    
                    AvatorImage(url: UserViewModel.shared.profileImageUrl!, size: 32)
                }
                .padding(.trailing)
                .padding(.leading, 80)
            } else {
                HStack(alignment: .bottom) {
                    AvatorImage(url: user.profileImageUrl, size: 32)
                    
                    Text(message.text)
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
