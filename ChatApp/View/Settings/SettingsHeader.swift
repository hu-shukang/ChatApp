//
//  SettingsHeaderView.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import SwiftUI
import Kingfisher

struct SettingsHeader: View {
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        HStack {
            if let imageUrl = userVM.profileImageUrl {
                AvatorImage(url: imageUrl)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(userVM.username)
                    .font(.system(size: 18))
                    .foregroundColor(.black)
                
                Text(userVM.status)
                    .foregroundColor(.customDarkGray)
                    .font(.system(size: 14))
            }
            
            Spacer()
        }
        .padding(.leading)
        .frame(height: 80)
        .background(Color.white)
    }
}

struct SettingsHeader_Previews: PreviewProvider {
    @StateObject static var settingsVM = SettingsViewModel()
    
    static var previews: some View {
        SettingsHeader()
            .environmentObject(UserViewModel.shared)
    }
}
