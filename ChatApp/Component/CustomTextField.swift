//
//  CustomTextField.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/12.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var icon: String
    var placeholder: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.customDarkGray)
                
                Group {
                    if isSecure {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                    }
                }
                .textInputAutocapitalization(.never)
                
            }
            Divider()
                .background(Color.customDarkGray)
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""), icon: "mail", placeholder: "Email")
            .padding()
    }
}
