//
//  StatusSelectorPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/19.
//

import SwiftUI

struct StatusSelectorPage: View {
    @StateObject var userVM = UserViewModel.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) {
                    CategoryTitle(title: "CURRENTLY SET TO")
                    Status(text: userVM.status)
                    
                    CategoryTitle(title: "SELECT YOUR STATUS")
                    VStack(spacing: 1) {
                        ForEach(statusList, id: \.self) { status in
                            Button(action: {
                                userVM.updateStatus(status: status) {
                                    dismiss()
                                }
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
        }
    }
}
