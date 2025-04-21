//
//  SideMenuOptionView.swift
//  UberSwiftUI
//
//  Created by Nitin on 22/04/25.
//

import SwiftUI

struct SideMenuOptionView: View {
    let option : SideMenuOptionViewModel
    
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: option.icon)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(.theme.primaryTextColor)
            
            Text(option.title)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundColor(.theme.primaryTextColor)
            Spacer()
        }
    }
}

#Preview {
    SideMenuOptionView(option: .trips)
}
