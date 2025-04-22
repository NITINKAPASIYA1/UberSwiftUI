//
//  SettingRowView.swift
//  UberSwiftUI
//
//  Created by Nitin on 23/04/25.
//

import SwiftUI

struct SettingRowView: View {
    var image : String
    var text : String
    var color : Color
    
    var body: some View {
        HStack{
            Image(systemName: image)
                .imageScale(.medium)
                .font(.title)
                .foregroundStyle(color)
            
      
                Text(text)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.theme.primaryTextColor)
        }
        .padding(4)
    }
}

#Preview {
    SettingRowView(image: "bell.circle.fill", text: "Notification", color: .green)
}
