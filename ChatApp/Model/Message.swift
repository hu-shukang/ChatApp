//
//  Message.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/22.
//

import Foundation

struct Message: Identifiable {
    let id = UUID().uuidString
    let isFromCurrentUser: Bool
    let messageText: String
}
