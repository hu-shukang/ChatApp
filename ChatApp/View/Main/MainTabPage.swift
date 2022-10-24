//
//  MainTabPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import SwiftUI

struct MainTabPage: View {
    @StateObject var mainTabVM = MainTabViewModel()
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        // MARK: - Tab View
        TabView(selection: $mainTabVM.selectedTab) {
            ConversationsPage()
                .environmentObject(authVM)
                .tabItem {
                    Image(systemName: "bubble.left")
                }
                .tag("conversations")
            
            ChannelsPage()
                .environmentObject(authVM)
                .tabItem {
                    Image(systemName: "bubble.left.and.bubble.right")
                }
                .tag("channels")
            
            SettingsPage()
                .environmentObject(authVM)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
                .tag("settings")
        }
        .navigationTitle(mainTabVM.tabTitle)
    }
}

struct MainTabPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainTabPage()
                .environmentObject(AuthViewModel())
        }
    }
}
