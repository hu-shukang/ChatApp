//
//  NewMessagePage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/21.
//

import SwiftUI

struct NewMessagePage: View {
    @EnvironmentObject var chatVM: ChatViewModel
    @EnvironmentObject var router: Router
    @Binding var showChatsPage: Bool
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText)
                .padding()
            
            VStack(alignment: .leading) {
                ForEach((chatVM.users)) { user in
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
            .environmentObject(ChatViewModel())
            .environmentObject(Router())
    }
}
