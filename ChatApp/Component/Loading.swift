//
//  Loading.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/29.
//

import SwiftUI

struct Loading: View {
    var text: String
    
    var body: some View {
        ZStack {
            ProgressView(label: {
                Text(text)
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading(text: "Loading")
    }
}
