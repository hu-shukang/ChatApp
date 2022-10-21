//
//  Avator.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/19.
//

import SwiftUI

struct Avator: View {
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: 64, height: 64)
            .clipShape(Circle())
    }
}

struct Avator_Previews: PreviewProvider {
    static var previews: some View {
        Avator(image: Image("avator"))
    }
}
