//
//  ProfilePhotoSelectorPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/22.
//

import SwiftUI

struct ProfilePhotoSelectorPage: View {
    @StateObject var authVM = AuthViewModel.shared
    @StateObject var router = Router.shared
    @State private var imagePickerPresented = false
    
    var body: some View {
        ZStack {
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
                
                Text(authVM.selectedImage == nil ? "プロフィール写真をご選択ください" : "選択できました!")
                
                if authVM.selectedImage != nil {
                    Button(action: {
                        authVM.uploadProfileImage(callback: {
                            router.path.append(MainTabRoute())
                        })
                    }, label: {
                        Text("アップロード")
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
            if authVM.waiting {
                Loading(text: "プロフィール写真をアップロード中。。。")
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(for: MainTabRoute.self) { _ in
            MainTabPage()
        }
    }
}

struct ProfilePhotoSelectorPage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorPage()
    }
}
