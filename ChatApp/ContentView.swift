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
    
    var body: some View {
//        NavigationStack(path: $router.path) {
//            LoginPage()
//                .environmentObject(router)
//        }
        NavigationStack {
            MainTabPage()
                .environmentObject(mainTabVM)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
