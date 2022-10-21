//
//  CategoryTitle.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/19.
//

import SwiftUI

struct CategoryTitle: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title.uppercased())
                .foregroundColor(.customLightGray)
            Spacer()
        }
        .padding()
    }
}

struct CategoryTitle_Previews: PreviewProvider {
    static var previews: some View {
        CategoryTitle(title: "CURRENTLY SET TO")
    }
}
