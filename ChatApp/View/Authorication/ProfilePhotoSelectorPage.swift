//
//  ProfilePhotoSelectorPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/22.
//

import SwiftUI

struct ProfilePhotoSelectorPage: View {
    @EnvironmentObject var router: Router;
    @EnvironmentObject var authVM: AuthViewModel;
    @State private var imagePickerPresented = false
    
    var body: some View {
        VStack {
            Button(action: {
                imagePickerPresented.toggle()
            }, label: {
                if let selectedImage = authVM.selectedImage {
                    Avator(image: Image(uiImage: selectedImage), size: 180)
                } else {
                    Avator(image: Image("upload"), size: 180)
                }
            })
            .sheet(isPresented: $imagePickerPresented) {
                ImagePicker(image: $authVM.selectedImage)
            }
            
            Text(authVM.selectedImage == nil ? "Select a profile photo" : "Great! Tap below to continue")
            
            if authVM.selectedImage != nil {
                Button(action: {
                    authVM.uploadProfileImage()
                }, label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color.customBlue)
                        .clipShape(Capsule())
                        .padding()
                })
                .shadow(color: .customDarkGray, radius: 10)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ProfilePhotoSelectorPage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorPage()
            .environmentObject(Router())
            .environmentObject(AuthViewModel())
    }
}
