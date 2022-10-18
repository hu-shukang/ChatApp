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
        SettingsCellModel(icon: "lock", iconColor: Color.customBlue, text: "Account"),
        SettingsCellModel(icon: "lock", iconColor: Color.customBlue, text: "Account"),
        SettingsCellModel(icon: "star.fill", iconColor: Color.yellow, text: "Starred Messages")
    ]
}
