//
//  SavedLocationRowView.swift
//  UberSwiftUI
//
//  Created by Nitin on 23/04/25.
//

import SwiftUI

struct SavedLocationRowView: View {
    var image : String
    var text : String
    var subtext : String
    
    var body: some View {
        HStack{
            Image(systemName: image)
                .imageScale(.medium)
                .font(.title)
                .foregroundStyle(Color(.systemBlue))
            
            VStack(alignment: .leading,spacing: 4){
                Text(text)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.theme.primaryTextColor)
                
                Text(subtext)
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 20))
                .foregroundStyle(.gray)
        }

    }
}

#Preview {
    SavedLocationRowView(image: "house.circle.fill", text: "Home", subtext: "Add Home")
}
