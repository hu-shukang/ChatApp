//
//  SettingsHeaderView.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import SwiftUI
import Kingfisher

struct SettingsHeader: View {
    @EnvironmentObject var settingsVM: SettingsViewModel
    
    var body: some View {
        HStack {
            AvatorImage(url: AuthViewModel.shared.currentUser.profileImageUrl)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(AuthViewModel.shared.currentUser.username)
                    .font(.system(size: 18))
                    .foregroundColor(.black)
                
                Text(settingsVM.currentStatus)
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
            .environmentObject(settingsVM)
    }
}
