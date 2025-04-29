//
//  TripAcceptedView.swift
//  UberSwiftUI
//
//  Created by Nitin on 30/04/25.
//

import SwiftUI

struct TripAcceptedView: View {
    var body: some View {
        VStack{
            Text("Your Driver on the way")
                .padding()
                
        }
        .background(Color.theme.backgroundColor)
        .cornerRadius(16)
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 20)
    }
}

#Preview {
    TripAcceptedView()
}
