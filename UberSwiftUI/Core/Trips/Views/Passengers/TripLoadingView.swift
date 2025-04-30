//
//  TripLoadingView.swift
//  UberSwiftUI
//
//  Created by Nitin on 30/04/25.
//

import SwiftUI

struct TripLoadingView: View {
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color.theme.primaryTextColor)
                .frame(width: 50, height: 5)
                .padding(.top, 10)
                
            HStack{
                Text("Connecting you to a Driver...")
                    .font(.headline)
                    .padding()
                
                Spacer()
                
                Spinner(lineWidth: 6, height: 64, width: 64)
                    .padding()
            }
            .padding(.bottom,24)

        }
        .background(Color.theme.backgroundColor)
        .cornerRadius(16)
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 20)
    }
}

#Preview {
    TripLoadingView()
}
