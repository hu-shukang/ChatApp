//
//  SettingsPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import SwiftUI

struct SettingsPage: View {
    @StateObject var settingsVM = SettingsViewModel()
    
    var body: some View {
        VStack(spacing: 32) {
            SettingsHeader()
            
            VStack(spacing: 0) {
                ForEach(Array(settingsVM.settingsCellList.enumerated()), id: \.element) { index, cell in
                    SettingsCell(model: cell)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                    if index != settingsVM.settingsCellList.count - 1 {
                        Divider()
                            .padding(.leading)
                            .padding(.leading, 44)
                    }
                }
            }
            .background(.white)
        
            
            Text("Logout")
            
            Spacer()
        }
        .background {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
        }
        .toolbarBackground(Color(.systemGroupedBackground), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsPage()
                .navigationTitle("Settings")
        }
    }
}
