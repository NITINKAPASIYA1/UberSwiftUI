//
//  RideRequestView.swift
//  UberSwiftUI
//
//  Created by Nitin on 08/04/25.
//

import SwiftUI

struct RideRequestView: View {
    var body: some View {
        VStack{
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            //trip info view
            HStack{
                
                VStack{
                    VStack {
                        Circle()
                            .fill(Color(.systemGray3))
                            .frame(width: 6, height: 6)
                        
                        Rectangle()
                            .fill(Color(.systemGray3))
                            .frame(width: 1, height: 30)
                        
                        Rectangle()
                            .fill(.black)
                            .frame(width: 6, height: 6)
                    }
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    HStack{
                        Text("Current location")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundStyle(.gray)
                        
                        Spacer()
                        
                        Text("1:23 PM")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundStyle(.gray)
                    
                    }
                    .padding(.bottom,10)
                    
                    HStack{
                        Text("Starbucks Coffee")
                            .font(.system(size: 16,weight: .semibold))
                        
                        Spacer()
                        
                        Text("2:43 PM")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundStyle(.gray)
                        
                    }
                   
                }
                .padding(.leading,8)
            }.padding()
            
            Divider()
            
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.gray)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12){
                    ForEach(0..<3,id:\.self) { _ in
                        VStack(alignment: .leading){
                            Image(.uberX)
                                .resizable()
                                .scaledToFit()
                            
                            VStack(alignment: .leading,spacing: 4){
                                Text("UberX")
                                    .font(.system(size: 16,weight: .semibold))
                                
                                Text("$10")
                                    .font(.system(size: 16,weight: .semibold))
                                
                            }.padding(8)
                        }
                        .frame(width: 112, height: 140)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
                    }
                }
            }.padding(.horizontal)
            
            Divider().padding(.vertical,8)
                
            
            //payment view
            HStack(spacing: 12){
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundStyle(.white)
                    .padding(.leading)
                
                
                Text("**** 1234")
                    .fontWeight(.bold)
                    
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 20))
                    .foregroundStyle(.gray)
                    .padding(.trailing)
                    
            }
            .frame(height: 50)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(10)
            .padding(.horizontal)
            
            
            Button {
                
            } label: {
                Text("Confirm Ride")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                    
            }
        }
        .padding(.bottom, 24)
        .background(.white)
        .cornerRadius(12)
    }
}

#Preview {
    RideRequestView()
}
