//
//  SideMenuView.swift
//  UberSwiftUI
//
//  Created by Nitin on 22/04/25.
//

import SwiftUI

struct SideMenuView: View {
    
    private let user : User
    
    init(user : User) {
        self.user = user
    }
    
    var body: some View {
        VStack(spacing: 40){
            //header view
            VStack(alignment: .leading,spacing: 32){
                //user Info
                HStack{
                    Image(.profile)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 64,height: 64)
                    
                    VStack(alignment: .leading, spacing: 8  ){
                        Text(user.userName)
                            .font(.system(size: 20, weight: .semibold))
                        
                        
                        Text(user.email)
                            .font(.system(size: 16, weight: .semibold))
                            .tint(Color.theme.primaryTextColor).opacity(0.7)
                        
                    }
                }
                
                //Become a Driver
                VStack(alignment: .leading,spacing:16){
                    Text("Do more with your account")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    HStack{
                        Image(systemName: "dollarsign.square")
                            .font(.title2)
                            .imageScale(.medium)
                        
                        Text("Make Money Driving")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(6)
                        
                    }
                }
                
                Rectangle()
                    .frame(width: 296, height: 0.75)
                    .opacity(0.7)
                    .foregroundStyle(Color(.separator))
                    .shadow(color: .black.opacity(0.7), radius: 4)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading,16)
            
            VStack{
                ForEach(SideMenuOptionViewModel.allCases , id : \.self) { item in
                    NavigationLink(value: item){
                        SideMenuOptionView(option: item)
                            .padding()
                    }
                }
            }.navigationDestination(for: SideMenuOptionViewModel.self) { viewModel in
                switch viewModel {
                case .trips:
                    Text("Trips")
                case .settings:
                    SettingView(user: user)
                case .messages:
                    Text("Messages")
                case .wallet:
                    Text("Wallet")
                }
                    
            }
            
            Spacer()
        }
        .padding(.top,32)
    }
}

#Preview {
    NavigationStack{
        SideMenuView(user: DeveloperPreview.shared.mockUser)
    }
}
