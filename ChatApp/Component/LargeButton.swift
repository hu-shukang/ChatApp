//
//  LargeButton.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/12.
//

import SwiftUI

struct LargeButton: View {
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(text)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.customBlue)
                .clipShape(Capsule())
        })
        .shadow(color: .customLightGray, radius: 6, x: 0, y: 0)
    }
}

struct LargeButton_Previews: PreviewProvider {
    static var previews: some View {
        LargeButton(text: "Sign In", action: {
            print("hello")
        })
            .padding()
    }
}
