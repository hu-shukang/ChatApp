//
//  RegistrationPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/11.
//

import SwiftUI

struct RegistrationPage: View {
//    @State private var email = ""
//    @State private var username = ""
//    @State private var fullname = ""
//    @State private var password = ""
    @EnvironmentObject var router: Router;
    @EnvironmentObject var authVM: AuthViewModel;
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Get started.")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.customBlack)
            
            Text("Create your account")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.customBlue)
            
            VStack(spacing: 32) {
                CustomTextField(text: $authVM.email, icon: "envelope", placeholder: "Email")
                CustomTextField(text: $authVM.username, icon: "person", placeholder: "User Name")
                CustomTextField(text: $authVM.fullname, icon: "person", placeholder: "Full Name")
                CustomTextField(text: $authVM.password, icon: "lock", placeholder: "Password", isSecure: true)
                
                LargeButton(text: "Sign Up", action: {
                    authVM.register()
                })
            }
            .padding([.horizontal, .top], 32)
            
            Spacer()
            
            HStack {
                Button(action: {
                    router.path.removeLast()
                }, label: {
                    HStack(alignment: .center) {
                        Text("Already have an account?")
                        Text("Sign In")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(Color.customBlue)
                    .font(.system(size: 14))
                })
            }
            .frame(maxWidth: .infinity)
            
        }
        .navigationBarBackButtonHidden()
        .padding()
        .padding(.top, 30)
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationDestination(isPresented: $authVM.didAuthUser) {
            ProfilePhotoSelectorPage()
                .environmentObject(router)
                .environmentObject(authVM)
        }
    }
}

struct RegistrationPage_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationPage()
            .environmentObject(Router())
            .environmentObject(AuthViewModel())
    }
}
