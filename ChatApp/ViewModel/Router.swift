//
//  Router.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/11.
//

import SwiftUI

class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    static let shared = Router()
    
    static func append(to routeInfo: RouteInfo) {
        shared.path.append(routeInfo)
    }
    
    static func back() {
        shared.path.removeLast()
    }
    
    static func backToBegin() {
        shared.path.removeLast(shared.path.count)
    }
}

class RouteInfo: Hashable {
    var name: String
    var identifier: String
    
    init(name: String) {
        self.name = name
        self.identifier = UUID().uuidString
    }
    
    static func == (lhs: RouteInfo, rhs: RouteInfo) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(self.identifier)
    }
}

class SignInRoute: RouteInfo {
    init() {
        super.init(name: "SIGN_IN")
    }
}

class SignUpRoute: RouteInfo {
    init() {
        super.init(name: "SIGN_UP")
    }
}

class UploadProfileImageRoute: RouteInfo {
    init() {
        super.init(name: "UPLOAD_PROFILE_IMAGE")
    }
}

class ForgetPasswordRoute: RouteInfo {
    init() {
        super.init(name: "FORGET_PASSWORD")
    }
}

class MainTabRoute: RouteInfo {
    init() {
        super.init(name: "MAIN_TAB")
    }
}
