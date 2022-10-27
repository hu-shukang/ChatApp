//
//  UserCell.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/21.
//

import SwiftUI

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
                    
                    Text("Hello world!!")
                        .font(.system(size: 14))
                        .foregroundColor(.customDarkGray)
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
    static var previews: some View {
        ConversationCell(user: .init())
    }
}
