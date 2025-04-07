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
                            Image(systemName: "uber-x")
                        }
                    }
                }
            }
                
                
            
        }
    }
}

#Preview {
    RideRequestView()
}
