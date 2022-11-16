//
//  User.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/25.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Decodable, Hashable {
    @DocumentID var id: String?
    var uid: String
    var username: String
    var fullname: String
    var email: String
    var profileImageUrl: String
    var status: String
    var recentMesssage: Message?
    
    var recentMessageContent: String {
        return recentMesssage?.text ?? ""
    }
    
    var recentMessageDate: String {
        guard let date = recentMesssage?.timestamp.dateValue() else {
            return ""
        }
        let df = DateFormatter()
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            df.dateFormat = "今日 hh:mm"
        } else if calendar.isDateInYesterday(date) {
            df.dateFormat = "昨日 hh:mm"
        } else {
            df.dateFormat = "yyyy/MM/dd"
        }
        
        return df.string(from: date)
    }
    
    init() {
        self.uid = ""
        self.username = ""
        self.fullname = ""
        self.email = ""
        self.profileImageUrl = ""
        self.status = statusList[0]
    }
    
    init(uid: String, username: String, fullname: String, email: String, profileImageUrl: String, status: String, recentMesssage: Message?) {
        self.uid = uid
        self.username = username
        self.fullname = fullname
        self.email = email
        self.profileImageUrl = profileImageUrl
        self.status = status
        self.recentMesssage = recentMesssage
    }
}

let statusList: [String] = ["アクティブ", "忙しい", "学習中", "映画館", "仕事中", "ミーティング中", "休憩中"]
