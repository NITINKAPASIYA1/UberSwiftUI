//
//  HomeView.swift
//  UberSwiftUI
//
//  Created by Nitin on 21/03/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        UberMapViewRepresentable()
            .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
