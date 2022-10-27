//
//  MessageInput.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/22.
//

import SwiftUI

struct MessageInput: View {
    @EnvironmentObject var chatVM: ChatViewModel
    var isEditing: FocusState<Bool>.Binding
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(height: 0.75)
            
            HStack {
                TextField("Message...", text: $chatVM.sendMessageText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .focused(isEditing)
                    .font(.body)
                    .frame(minHeight: 30)
                
                Button(action: {
                    chatVM.sendMessage()
                }, label: {
                    Text("Send")
                        .bold()
                        .foregroundColor(.customBlue)
                })
                .disabled(chatVM.sendMessageText.isEmpty)
                .opacity(chatVM.sendMessageText.isEmpty ? 0.5 : 1)
            }
            .padding(.bottom, 8)
            .padding(.horizontal)
        }
    }
}

struct MessageInput_Previews: PreviewProvider {
    @StateObject static var chatVM = ChatViewModel(to: .init())
    @FocusState static var isEditing: Bool
    
    static var previews: some View {
        MessageInput(isEditing: $isEditing)
            .environmentObject(chatVM)
    }
}
