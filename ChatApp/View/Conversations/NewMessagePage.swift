//
//  NewMessagePage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/21.
//

import SwiftUI

struct NewMessagePage: View {
    @StateObject var authVM = AuthViewModel.shared
    @StateObject var router = Router.shared
    @Binding var showChatsPage: Bool
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText)
                .padding()
            
            VStack(alignment: .leading) {
                ForEach(authVM.friends) { user in
                    Button(action: {
                        showChatsPage.toggle()
                        router.path.append(user)
                        dismiss()
                    }, label: {
                        UserCell(user: user)
                    })
                }
            }
        }
    }
}

struct NewMessagePage_Previews: PreviewProvider {
    static var previews: some View {
        NewMessagePage(showChatsPage: .constant(true))
    }
}
