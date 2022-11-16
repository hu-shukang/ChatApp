//
//  UserCell.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/21.
//

import SwiftUI
import Firebase

struct ConversationCell: View {
    @StateObject var router = Router.shared
    @ObservedObject var messageVM: MessageViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            
            HStack {
                if let user = messageVM.user {
                    AvatorImage(url: user.profileImageUrl, size: 48)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(messageVM.fullname)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.customBlack)
                    
                    HStack(spacing: 0) {
                        Text(messageVM.message.text)
                            .lineLimit(1)
                            .font(.system(size: 14))
                            .foregroundColor(.customDarkGray)
                        
                        Spacer()
                        
                        Text(messageVM.message.date)
                            .font(.system(size: 14))
                            .foregroundColor(.customDarkGray)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
            Divider()
        }
        .padding(.top, 8)
        .contentShape(Rectangle())
        .onTapGesture {
            if let user = messageVM.user {
                router.path.append(user)
            }
        }
    }
}

struct ConversationCell_Previews: PreviewProvider {
    static var message = Message(id: "123", fromId: "123", read: false, text: "message content message content message content message content", timestamp: Timestamp(date: Date()))
    
    static var previews: some View {
        ConversationCell(messageVM: MessageViewModel(message))
    }
}
