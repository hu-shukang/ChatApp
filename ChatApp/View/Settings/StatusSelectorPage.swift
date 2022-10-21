//
//  StatusSelectorPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/19.
//

import SwiftUI

struct StatusSelectorPage: View {
    @EnvironmentObject var settingsVM: SettingsViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) {
                    CategoryTitle(title: "CURRENTLY SET TO")
                    Status(text: settingsVM.currentStatus)
                    
                    CategoryTitle(title: "SELECT YOUR STATUS")
                    VStack(spacing: 1) {
                        ForEach(settingsVM.status, id: \.self) { status in
                            Button(action: {
                                settingsVM.currentStatus = status
                                dismiss()
                            }, label: {
                                Status(text: status)
                            })
                        }
                    }
                    
                }
            }
        }
    }
    
    @ViewBuilder
    func Status(text: String) -> some View {
        HStack {
            Text(text)
                .foregroundColor(.customBlack)
            Spacer()
        }
        .padding(.horizontal)
        .frame(height: 56)
        .background(.white)
    }
}

struct StatusSelectorPage_Previews: PreviewProvider {
    @StateObject static var settingsVM = SettingsViewModel()
    
    static var previews: some View {
        NavigationStack {
            StatusSelectorPage()
                .environmentObject(settingsVM)
        }
    }
}
