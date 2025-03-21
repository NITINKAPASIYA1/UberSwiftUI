//
//  LocationSearchActivationView.swift
//  UberSwiftUI
//
//  Created by Nitin on 22/03/25.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack{
            
            Rectangle()
                .fill(Color.black)
                .frame(width: 8, height: 9)
                .padding(.horizontal)
            
            Text("Where to?")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(Color(.darkGray))
            
            Spacer()
            
                
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(
            Rectangle()
                .fill(Color(.systemGray6))
                .cornerRadius(10)
                .shadow(color: .black, radius: 6)
        )
    }
}

#Preview {
    LocationSearchActivationView()
}
