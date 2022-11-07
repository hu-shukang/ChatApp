//
//  RegistrationPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/11.
//

import SwiftUI

struct RegistrationPage: View {
    @EnvironmentObject var router: Router;
    @EnvironmentObject var authVM: AuthViewModel;
    @Environment(\.dismiss) var dismiss;
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Get started.")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.customBlack)
                
                Text("アカウント新規登録")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.customBlue)
                
                VStack(spacing: 32) {
                    CustomTextField(text: $authVM.email, icon: "envelope", placeholder: "メールアドレス")
                    CustomTextField(text: $authVM.username, icon: "person", placeholder: "ユーザ名")
                    CustomTextField(text: $authVM.fullname, icon: "person", placeholder: "フルネーム")
                    CustomTextField(text: $authVM.password, icon: "lock", placeholder: "パスワード", isSecure: true)
                    
                    LargeButton(text: "新規登録", action: {
                        authVM.register()
                    })
                }
                .padding([.horizontal, .top], 32)
                
                Spacer()
                
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        HStack(alignment: .center) {
                            Text("アカウントを持っています?")
                            Text("ログイン")
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
            
            if authVM.waiting {
                Loading(text: "新規登録中。。。")
            }
        }
        .navigationDestination(isPresented: $authVM.didRegister) {
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
