//
//  UserCell.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/21.
//

import SwiftUI
import Firebase

struct ConversationCell: View {
    var user: User
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
//                Avator(image: Image("avator"), size: 48)
                AvatorImage(url: user.profileImageUrl, size: 48)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.fullname)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.customBlack)
                    
                    HStack(spacing: 0) {
                        Text(user.recentMessageContent)
                            .lineLimit(1)
                            .font(.system(size: 14))
                            .foregroundColor(.customDarkGray)
                        
                        Spacer()
                        
                        Text(user.recentMessageDate)
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
    }
}

struct ConversationCell_Previews: PreviewProvider {
    static var message = Message(id: "123", fromId: "123", read: false, text: "message content message content message content message content", timestamp: Timestamp(date: Date()))
    static var user = User.init(uid: "123", username: "hushukang", fullname: "HU SHUKANG", email: "abc@gmail.com", profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/chatapp-4f76b.appspot.com/o/profile_images%2F56BE0109-8E0A-478E-B5CB-24A20FD7F537?alt=media&token=bb2d2cc6-c496-45ee-98e3-6d900d7fd64f", status: "Active", recentMesssage: message)
    
    static var previews: some View {
        ConversationCell(user: user)
    }
}
