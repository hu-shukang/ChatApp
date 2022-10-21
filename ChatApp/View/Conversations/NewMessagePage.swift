//
//  NewMessagePage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/21.
//

import SwiftUI

struct NewMessagePage: View {
    @Binding var showChatsPage: Bool
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText)
                .padding()
            
            VStack(alignment: .leading) {
                ForEach((0 ... 10), id: \.self) { _ in
                    Button(action: {
                        showChatsPage.toggle()
                        dismiss()
                    }, label: {
                        UserCell()
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
