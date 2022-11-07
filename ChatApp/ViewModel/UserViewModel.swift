//
//  UserViewModel.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/29.
//

import Firebase
import FirebaseStorage
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var friends: [User] = []
    @Published var username: String = ""
    @Published var status: String = statusList[0]
    @Published var profileImageUrl: String?
    
    static let shared = UserViewModel()
    
    init() {
        fetchUser()
        fetchFriends()
    }
    
    func fetchUser() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            print("DEBUG: User object is \(user)")
            self.currentUser = user
            self.username = user.username
            self.status = user.status
            self.profileImageUrl = user.profileImageUrl
        }
    }

    func fetchFriends() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        COLLECTION_USERS.whereField("uid", isNotEqualTo: uid).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.friends = documents.compactMap({ try? $0.data(as: User.self) })
        }
    }
    
    func updateStatus(status: String, callback: @escaping () -> Void) {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let data = ["status": status]
        COLLECTION_USERS.document(uid).updateData(data) { _ in
            print("DEBUG: successfully to update status")
            self.status = status
            callback()
        }
    }
    
    func updateUsername(callback: @escaping () -> Void) {
        if username == currentUser?.username {
            callback()
            return
        }
        guard let uid = currentUser?.uid else { return }
        let data = ["username": self.username]
        COLLECTION_USERS.document(uid).updateData(data) { _ in
            print("DEBUG: successfully to update username")
            self.currentUser?.username = self.username
            callback()
        }
    }
    
    func uploadProfileImage(image: UIImage) {
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
                guard let uid = self.currentUser?.uid else { return }
                let data = ["profileImageUrl": imageUrl]
                COLLECTION_USERS.document(uid).updateData(data) { _ in
                    print("DEBUG: successfully to upload file image")
                    self.profileImageUrl = imageUrl
                }
            }
        }
    }
}
