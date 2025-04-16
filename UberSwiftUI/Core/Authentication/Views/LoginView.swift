//
//  LoginView.swift
//  UberSwiftUI
//
//  Created by Nitin on 17/04/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack{
            Color(.black)
                .ignoresSafeArea()
            
            VStack{
                //image entitled Uber
                Image("uber-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
    }
}

#Preview {
    LoginView()
}
