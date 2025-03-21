//
//  MapViewActionButton.swift
//  UberSwiftUI
//
//  Created by Nitin on 22/03/25.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var showLocationSearchView : Bool
    
    var body: some View {
        Button {
            withAnimation(.spring()) {
                showLocationSearchView.toggle()
            }
        } label: {
            Image(systemName: showLocationSearchView ? "arrow.left" : "line.3.horizontal" )
                .font(.system(size: 24))
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)

    }
}

#Preview {
    MapViewActionButton(showLocationSearchView: .constant(false))
}
