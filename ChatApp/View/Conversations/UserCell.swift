//
//  UserCell.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/21.
//

import SwiftUI

struct UserCell: View {
    let user: User
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                AvatorImage(url: user.profileImageUrl, size: 48)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.username)
                        .foregroundColor(.customBlack)
                        .font(.system(size: 16, weight: .semibold))
                    
                    Text(user.fullname)
                        .foregroundColor(.customDarkGray)
                        .font(.system(size: 14))
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            Divider()
        }
        .padding(.top, 8)
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(user: User())
    }
}
