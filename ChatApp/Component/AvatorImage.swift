//
//  AvactorImage.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/25.
//

import SwiftUI
import Kingfisher

struct AvatorImage: View {
    var url: String
    var size: CGFloat = 64
    
    var body: some View {
        KFImage(URL(string: url))
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}

struct AvatorImage_Previews: PreviewProvider {
    static var previews: some View {
        AvatorImage(url: "https://cdn-icons-png.flaticon.com/512/2991/2991148.png")
    }
}
