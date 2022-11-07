//
//  LoginPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/11.
//

import SwiftUI

struct LoginPage: View {
    @EnvironmentObject var router: Router;
    @EnvironmentObject var authVM: AuthViewModel;
    @State var gotoSignUp: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("こんにちは.")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.customBlack)
                
                Text("Welcome Back")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.customBlue)
                
                VStack(spacing: 32) {
                    CustomTextField(text: $authVM.email, icon: "envelope", placeholder: "メールアドレス")
                    CustomTextField(text: $authVM.password, icon: "lock", placeholder: "パスワード", isSecure: true)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            gotoSignUp.toggle()
                        }, label: {
                            Text("パスワードお忘れ？")
                                .font(.system(size: 13))
                                .foregroundColor(Color.customBlue)
                                .fontWeight(.semibold)
                        })
                    }
                    
                    LargeButton(text: "ログイン", action: {
                        authVM.login()
                    })
                }
                .padding([.horizontal, .top], 32)
                
                Spacer()
                
                HStack {
                    Button(action: {
                        gotoSignUp.toggle()
                    }, label: {
                        HStack(alignment: .center) {
                            Text("アカウントをお持ちではない?")
                            Text("新規登録")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(Color.customBlue)
                        .font(.system(size: 14))
                    })
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding()
            .padding(.top, 30)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if authVM.waiting {
                Loading(text: "ログイン中。。。")
            }
        }
        .navigationDestination(isPresented: $gotoSignUp) {
            RegistrationPage()
                .environmentObject(router)
                .environmentObject(authVM)
        }
        .navigationDestination(isPresented: $authVM.didAuthUser) {
            return MainTabPage()
                .environmentObject(router)
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
