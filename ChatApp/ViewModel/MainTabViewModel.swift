//
//  MainTabViewModel.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import Foundation

class MainTabViewModel: ObservableObject {
    @Published var selectedTab: String = "conversations"
    let tabTitles: Dictionary<String,String> = ["conversations": "Chats", "channels": "Channels", "settings": "Settings"]
    
    var tabTitle: String {
        return tabTitles[selectedTab] ?? "Chats"
    }
}
