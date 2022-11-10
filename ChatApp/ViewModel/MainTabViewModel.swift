//
//  MainTabViewModel.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import Foundation

class MainTabViewModel: ObservableObject {
    static let defaultTab: String = "conversations"
    @Published var selectedTab: String = "conversations"
    let tabTitles: Dictionary<String,String> = ["conversations": "Chats", "channels": "Channels", "settings": "Settings"]
    
    var tabTitle: String {
        return tabTitles[selectedTab] ?? "Chats"
    }
    
    static let shared = MainTabViewModel()
}
