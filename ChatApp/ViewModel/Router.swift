//
//  Router.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/11.
//

import SwiftUI

class Router: ObservableObject {
    var FORGOT_PASSWORD = "FORGOT_PASSWORD"
    var SIGN_UP = "SIGN_UP"
    var SIGN_IN = "SIGN_IN"
    
    @Published var path = NavigationPath()
    
    static let shared = Router()
}
