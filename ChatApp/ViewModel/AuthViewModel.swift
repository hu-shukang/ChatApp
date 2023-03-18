//
//  AutoViewModel.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/22.
//

import Firebase
import FirebaseStorage
import SwiftUI


class AuthViewModel: ObservableObject {
    private var tempUser: FirebaseAuth.User?
    
    @Published var email = "abc@gmail.com"
    @Published var username = ""
    @Published var fullname = ""
    @Published var password = "123456"
    
    @Published var selectedImage: UIImage?
    @Published var didAuthUser = false
    @Published var didRegister = false
    @Published var waiting = false
    @Published var userSession: FirebaseAuth.User?
    
    
    @Published var currentUser: User = .init()
    @Published var friends: [User] = []
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
    }
    
    func login(callback: @escaping () -> Void) {
        waiting = true
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            self.waiting = false
            self.resetInput()
            self.userSession = result?.user
            self.didAuthUser = true
            callback()
        }
    }
    
    func register(callback: @escaping () -> Void) {
        waiting = true
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            print("DEBUG: Successfully registered user with firebase.")
            guard let user = result?.user else { return }
            let data: [String: Any] = ["email": self.email, "username": self.username, "fullname": self.fullname, "uid": user.uid]
            COLLECTION_USERS.document(user.uid).setData(data) { _ in
                print("DEBUG: Successfully updated user info in firestore.")
                self.waiting = false
                self.tempUser = user
                self.didRegister = true
                self.resetInput()
                callback()
            }
        }
    }
    
    func uploadProfileImage(callback: @escaping () -> Void) {
        waiting = true
        guard let image = self.selectedImage else { return }
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "profile_images/\(filename)")
        ref.putData(imageData) { _, error in
            if let error = error {
                print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
                return
            }
            ref.downloadURL { url, _ in
                guard let imageUrl = url?.absoluteString else { return }
                guard let uid = self.tempUser?.uid else { return }
                let data = ["profileImageUrl": imageUrl, "status": statusList[0]]
                COLLECTION_USERS.document(uid).updateData(data) { _ in
                    print("DEBUG: successfully to upload file image")
                    self.userSession = self.tempUser
                    self.waiting = false
                    self.didAuthUser = true
                    print("didAuthUser: \(self.didAuthUser)")
                    callback()
                }
            }
        }
    }
    
    func logout(callback: @escaping () -> Void) {
        self.userSession = nil
        try? Auth.auth().signOut()
        Router.backToBegin()
        MainTabViewModel.shared.selectedTab = MainTabViewModel.defaultTab
        UserViewModel.clear()
        callback()
    }
    
    private func resetInput() {
        email = ""
        username = ""
        fullname = ""
        password = ""
    }
}
