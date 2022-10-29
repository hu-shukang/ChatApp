//
//  ContentView.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/11.
//

import SwiftUI

struct ContentView: View {
    @StateObject var router = Router()
    @StateObject var mainTabVM = MainTabViewModel()
    @StateObject var authVM = AuthViewModel.shared
    
    var body: some View {
        NavigationStack(path: $router.path) {
            Group {
//                if authVM.userSession == nil {
//                    LoginPage()
//                } else if authVM.currentUser.id == nil {
//                    Text("Loading")
//                } else {
//                    MainTabPage()
//                }
                LoginPage()
            }
            .environmentObject(router)
            .environmentObject(authVM)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
