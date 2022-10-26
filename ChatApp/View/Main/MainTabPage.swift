//
//  MainTabPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import SwiftUI

struct MainTabPage: View {
    @StateObject var mainTabVM = MainTabViewModel()
    @StateObject var chatVM = ChatViewModel()
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        // MARK: - Tab View
        if let _ = authVM.currentUser.id {
            TabView(selection: $mainTabVM.selectedTab) {
                ConversationsPage()
                    .environmentObject(authVM)
                    .environmentObject(chatVM)
                    .environmentObject(router)
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
        } else {
            Text("Loading...")
        }
    }
}

struct MainTabPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainTabPage()
                .environmentObject(AuthViewModel())
                .environmentObject(ChatViewModel())
                .environmentObject(Router())
        }
    }
}
