//
//  SavedLocationRowView.swift
//  UberSwiftUI
//
//  Created by Nitin on 23/04/25.
//

import SwiftUI

struct SavedLocationRowView: View {
    let viewModel : SavedLocationViewModel
    
    var body: some View {
        HStack{
            Image(systemName: viewModel.imageName)
                .imageScale(.medium)
                .font(.title)
                .foregroundStyle(Color(.systemBlue))
            
            VStack(alignment: .leading,spacing: 4){
                Text(viewModel.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.theme.primaryTextColor)
                
                Text(viewModel.subTitle)
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
            }
            
        }

    }
}

#Preview {
//    SavedLocationRowView(image: "house.circle.fill", text: "Home", subtext: "Add Home")
}
