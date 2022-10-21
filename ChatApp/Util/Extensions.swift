//
//  Extensions.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/12.
//

import SwiftUI

extension Color {
    static var customBlue: Color = Color("Blue")
    static var customBlack: Color = Color("Black")
    static var customDarkGray: Color = Color("DarkGray")
    static var customLightGray: Color = Color("LightGray")
    static var customExtraLightGray: Color = Color("ExtraLightGray")
}

extension View {
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
