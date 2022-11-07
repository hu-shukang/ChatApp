//
//  LoginPage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/11.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var authVM = AuthViewModel.shared
    @StateObject var router = Router.shared
    
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
                            router.path.append(ForgetPasswordRoute())
                        }, label: {
                            Text("パスワードお忘れ？")
                                .font(.system(size: 13))
                                .foregroundColor(Color.customBlue)
                                .fontWeight(.semibold)
                        })
                    }
                    
                    LargeButton(text: "ログイン", action: {
                        authVM.login(callback: {
                            router.path.append(MainTabRoute())
                        })
                    })
                }
                .padding([.horizontal, .top], 32)
                
                Spacer()
                
                HStack {
                    Button(action: {
                        router.path.append(SignUpRoute())
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
        .navigationBarBackButtonHidden(true)
        .navigationDestination(for: SignUpRoute.self) { _ in
            RegistrationPage()
        }
        .navigationDestination(for: ForgetPasswordRoute.self) { _ in
            Text("Forget Password")
        }
        .navigationDestination(for: MainTabRoute.self) { _ in
            MainTabPage()
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
