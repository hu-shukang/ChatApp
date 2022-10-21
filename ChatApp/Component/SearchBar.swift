//
//  SearchBar.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/21.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State var isEditing: Bool = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .textInputAutocapitalization(.never)
                .focused($isFocused)
                .padding(8)
                .padding(.leading, 30)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(alignment: .leading) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.customDarkGray)
                        .frame(width: 24, height: 24)
                        .padding(.leading, 8)
                }
                .onTapGesture {
                    withAnimation {
                        isEditing = true
                    }
                    isFocused = true
                }
            if isEditing {
                Button(action: {
                    withAnimation {
                        isEditing = false
                    }
                    isFocused = false
                    text = ""
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.customDarkGray)
                })
                .transition(.move(edge: .trailing))
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
            .padding()
    }
}
