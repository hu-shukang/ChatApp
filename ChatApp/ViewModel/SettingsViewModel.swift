//
//  SettingsViewModel.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import SwiftUI

struct SettingsCellModel: Identifiable, Hashable {
    var id: UUID = UUID()
    var icon: String
    var iconColor: Color
    var text: String
}

class SettingsViewModel: ObservableObject {
    let settingsCellList: [SettingsCellModel] = [
        SettingsCellModel(icon: "key.fill", iconColor: Color.customBlue, text: "Account"),
        SettingsCellModel(icon: "bell.badge.fill", iconColor: Color.red, text: "Notifications"),
        SettingsCellModel(icon: "star.fill", iconColor: Color.yellow, text: "Starred Messages")
    ]
    
    let status: [String] = ["Avaliable", "Busy", "At school", "At the movies", "At work", "Battery about to die", "In a meeting", "At the gym", "Sleeping", "Argent calls only"]
    
    @Published var username: String = "HU SHUKANG"
    @Published var currentStatus: String = "Avaliable"
    
    static let shared = SettingsViewModel()
}
