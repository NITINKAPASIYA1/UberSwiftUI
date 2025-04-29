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
            Text("Finding your trip...")
                .padding()
        }
        .background(Color.theme.backgroundColor)
        .cornerRadius(16)
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 20)
    }
}

#Preview {
    TripLoadingView()
}
