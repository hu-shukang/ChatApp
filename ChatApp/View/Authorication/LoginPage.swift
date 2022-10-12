//
//  LoginPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/11.
//

import SwiftUI

struct LoginPage: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var router: Router;
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Hello.")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.customBlack)
            
            Text("Welcome Back")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.customBlue)
            
            VStack(spacing: 32) {
                CustomTextField(text: $email, icon: "envelope", placeholder: "Email")
                CustomTextField(text: $password, icon: "lock", placeholder: "Password", isSecure: true)
                
                HStack {
                    Spacer()
                    NavigationLink(value: router.FORGOT_PASSWORD) {
                        Text("Forgot Password?")
                            .font(.system(size: 13))
                            .foregroundColor(Color.customBlue)
                            .fontWeight(.semibold)
                    }
                }
                
                LargeButton(text: "Sign In", action: {
                    
                })
            }
            .padding([.horizontal, .top], 32)
            
            Spacer()
            
            HStack {
                NavigationLink(value: router.SIGN_UP) {
                    HStack(alignment: .center) {
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(Color.customBlue)
                    .font(.system(size: 14))
                }
            }
            .frame(maxWidth: .infinity)
            
        }
        .padding()
        .padding(.top, 30)
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationDestination(for: String.self) { destination in
            if destination == router.SIGN_UP {
                RegistrationPage()
                    .environmentObject(router)
            }
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
