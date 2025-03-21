//
//  LocationSearchResultCell.swift
//  UberSwiftUI
//
//  Created by Nitin on 22/03/25.
//

import SwiftUI

struct LocationSearchResultCell: View {
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.blue)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading){
                Text("Location Name")
                    .font(.body)
                
                Text("Location Address")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                
                Divider()
            }
            
            Spacer()
            
        }
        .padding(.horizontal,20)
        .padding(.vertical,8)
    }
}

#Preview {
    LocationSearchResultCell()
}
