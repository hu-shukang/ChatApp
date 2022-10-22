//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/22.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var sendMessageText: String = ""
    @Published var messages: [Message] = []
    
    func sendMessage() {
        let message = Message(isFromCurrentUser: true, messageText: sendMessageText)
        messages.append(message)
        sendMessageText = ""
    }
}
