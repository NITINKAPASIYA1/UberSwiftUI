//
//  HomeView.swift
//  UberSwiftUI
//
//  Created by Nitin on 21/03/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showLocationSearchView = false
    
    var body: some View {
        ZStack(alignment: .top){
            UberMapViewRepresentable()
                .ignoresSafeArea()
            
            LocationSearchActivationView()
                .padding(.top,72)
            
            MapViewActionButton()
                .padding(.leading)
                .padding(.top,4)
                
        }
    }
}

#Preview {
    HomeView()
}
