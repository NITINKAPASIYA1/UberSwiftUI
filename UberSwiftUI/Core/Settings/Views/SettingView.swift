//
//  SettingView.swift
//  UberSwiftUI
//
//  Created by Nitin on 23/04/25.
//

import SwiftUI

struct SettingView: View {
    private var user : User
    @EnvironmentObject private var viewModel : AuthViewModel
    
    init(user : User){
        self.user = user
    }
    
    var body: some View {
        VStack{
            List{
                Section{
                    //info header
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
                                .opacity(0.77)
                        }
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .imageScale(.small)
                            .font(.title2)
                            .foregroundStyle(.gray)
                    }
                }
                
                Section("Favourites") {
                    ForEach(SavedLocationViewModel.allCases , id: \.self) { item in
                        
                        NavigationLink {
                            SavedLocationSearchView()
                        } label: {
                            SavedLocationRowView(viewModel: item)
                        }

                        
                    }
                }
                
                Section("Settings") {
                    SettingRowView(image: "bell.circle.fill",text: "Notifications",color: Color(.systemPurple))
                    
                    SettingRowView(image: "creditcard.circle.fill",text: "CreditCard",color: Color(.systemGreen))
                }

                Section("Account"){
                    SettingRowView(image: "dollarsign.square.fill", text: "Make Money driving", color: Color(.systemGreen))
                    
                    SettingRowView(image: "person.circle.fill", text: "Sign Out", color: Color(.systemRed)).onTapGesture {
                        viewModel.signOut()
                    }
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack{
        SettingView(user: User(userName: "nitin", email: "nitin@gmail.com", uid: "123"))
    }
}
