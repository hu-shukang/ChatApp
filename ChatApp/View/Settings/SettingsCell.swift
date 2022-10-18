//
//  SettingsCellView.swift
//  ChatApp
//
//  Created by 胡书康 on 2022/10/18.
//

import SwiftUI

struct SettingsCell: View {
    var model: SettingsCellModel
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: model.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 22, height: 22)
                .padding(6)
                .background(model.iconColor)
                .foregroundColor(Color.white)
                .cornerRadius(6)
            
            Text(model.text)
                .font(.system(size: 15))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.customDarkGray)
        }
        .padding(.vertical, 2)
    }
}

struct SettingsCell_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCell(model: SettingsViewModel().settingsCellList[0])
    }
}
