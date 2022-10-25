//
//  SettingsPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import SwiftUI

struct SettingsPage: View {
    @StateObject var settingsVM = SettingsViewModel()
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            NavigationLink(destination: {
                EditProfilePage()
                    .environmentObject(settingsVM)
                    .environmentObject(authVM)
            }, label: {
                SettingsHeader()
                    .environmentObject(settingsVM)
                    .environmentObject(authVM)
            })
            
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
        
            
            Button(action: authVM.logout, label: {
                Text("Logout")
                    .foregroundColor(.red)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
            })
            
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
                .environmentObject(AuthViewModel())
                .navigationTitle("Settings")
        }
    }
}
