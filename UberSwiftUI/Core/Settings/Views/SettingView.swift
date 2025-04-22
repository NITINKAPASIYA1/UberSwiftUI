//
//  SettingView.swift
//  UberSwiftUI
//
//  Created by Nitin on 23/04/25.
//

import SwiftUI

struct SettingView: View {
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
                            Text("Nitin Kumar")
                                .font(.system(size: 20, weight: .semibold))
                            
                            
                            Text("hello@gmail.com")
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
                    SavedLocationRowView(image: "house.circle.fill", text: "Home", subtext: "Add Home")
                    
                    SavedLocationRowView(image: "briefcase.circle.fill", text: "Work", subtext: "Add Work")
                }
                
                Section("Settings") {
                    SettingRowView(image: "bell.circle.fill",text: "Notifications",color: Color(.systemPurple))
                    
                    SettingRowView(image: "creditcard.circle.fill",text: "CreditCard",color: Color(.systemGreen))
                }

                Section("Account"){
                    SettingRowView(image: "dollarsign.square.fill", text: "Make Money driving", color: Color(.systemGreen))
                    
                    SettingRowView(image: "person.circle.fill", text: "Sign Out", color: Color(.systemRed))
                }
            }
        }
    }
}

#Preview {
    SettingView()
}
