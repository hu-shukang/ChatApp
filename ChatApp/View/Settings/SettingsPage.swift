//
//  SettingsPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import SwiftUI

struct SettingsPage: View {
    @StateObject var settingsVM = SettingsViewModel()
    @StateObject var userVM = UserViewModel.shared
    @StateObject var authVM = AuthViewModel.shared
    @State var logout: Bool = false
    
    var body: some View {
        VStack(spacing: 32) {
            NavigationLink(destination: {
                EditProfilePage()
                    .onDisappear {
                        userVM.updateUsername(callback: {
                            print("DEBUG: Success to update username")
                        })
                    }
            }, label: {
                SettingsHeader()
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
        
            
            Button(action: {
                authVM.logout {
                    self.logout = true
                }
            }, label: {
                Text("Logout")
                    .foregroundColor(.red)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.red, style: StrokeStyle(lineWidth: 1))
                    }
            })
            .padding()
            
            Spacer()
        }
        .background {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
        }
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
