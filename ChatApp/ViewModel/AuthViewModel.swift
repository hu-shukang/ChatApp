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
    
    @Published var email = ""
    @Published var username = ""
    @Published var fullname = ""
    @Published var password = ""
    @Published var selectedImage: UIImage?
    @Published var didAuthUser = false
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User = .init()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            self.resetInput()
            self.userSession = result?.user
            self.fetchUser()
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            print("DEBUG: Successfully registered user with firebase.")
            guard let user = result?.user else { return }
            let data: [String: Any] = ["email": self.email, "username": self.username, "fullname": self.fullname, "uid": user.uid]
            Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                print("DEBUG: Successfully updated user info in firestore.")
                self.tempUser = user
                self.didAuthUser = true
                self.resetInput()
            }
        }
    }
    
    func uploadProfileImage() {
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
                Firestore.firestore().collection("users").document(uid).updateData(["profileImageUrl": imageUrl]) { _ in
                    print("DEBUG: successfully to upload file image")
                    self.userSession = self.tempUser
                    self.fetchUser()
                }
            }
        }
    }
    
    func logout() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            print("DEBUG: User object is \(user)")
            self.currentUser = user
        }
    }
    
    private func resetInput() {
        email = ""
        username = ""
        fullname = ""
        password = ""
    }
}
