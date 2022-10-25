//
//  EditProfilePage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/19.
//

import SwiftUI

struct EditProfilePage: View {
    @EnvironmentObject var settingsVM: SettingsViewModel
    @EnvironmentObject var authVM: AuthViewModel
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 32) {
                // MARK: - Header
                VStack(spacing: 0) {
                    HStack {
                        VStack{
                            if let selectedImage = selectedImage {
                                Avator(image: Image(uiImage: selectedImage))
                            } else {
                                Avator(image: Image("avator"))
                            }
                            
                            Button(action: {
                                showImagePicker.toggle()
                            }, label: {
                                Text("Edit")
                            })
                            .sheet(isPresented: $showImagePicker) {
                                ImagePicker(image: $selectedImage)
                            }
                        }
                        .padding(.top)
                        
                        Text("Enter your name or change your file photo")
                            .font(.system(size: 16))
                            .foregroundColor(.customDarkGray)
                            .padding([.bottom, .leading])
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                        .padding(.top)
                    
                    TextField("", text: $settingsVM.username)
                        .padding()
                }
                .background(Color.white)
                
                // MARK: - Status
                VStack(alignment: .leading) {
                    CategoryTitle(title: "Status")
                    
                    NavigationLink(destination: {
                        StatusSelectorPage()
                            .environmentObject(settingsVM)
                    }, label: {
                        HStack {
                            Text(settingsVM.currentStatus)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.customDarkGray)
                        }
                        .padding()
                        .background(.white)
                    })
                }
                
                Spacer()
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color(.systemGroupedBackground), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
}

struct EditProfilePage_Previews: PreviewProvider {
    @StateObject static var settingsVM = SettingsViewModel()
    @StateObject static var authVM = AuthViewModel()
    static var previews: some View {
        NavigationStack {
            EditProfilePage()
                .environmentObject(settingsVM)
                .environmentObject(authVM)
        }
    }
}
