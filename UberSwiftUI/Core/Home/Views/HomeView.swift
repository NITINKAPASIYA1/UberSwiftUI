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
            
            if showLocationSearchView {
                LocationSearchView()
            }
            else {
                LocationSearchActivationView()
                    .padding(.top,72)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showLocationSearchView.toggle()
                        }
                    }
            }
            
            MapViewActionButton(showLocationSearchView: $showLocationSearchView)
                .padding(.leading)
                .padding(.top,4)
                
        }
    }
}

#Preview {
    HomeView()
}
