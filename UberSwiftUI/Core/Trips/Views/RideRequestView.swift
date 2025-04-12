//
//  RideRequestView.swift
//  UberSwiftUI
//
//  Created by Nitin on 08/04/25.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedRideType: RideType = .uberX
    @EnvironmentObject var viewModel : LocationSearchViewModel
    
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
                        
                        Text(viewModel.pickupTime ?? "2:43 PM")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundStyle(.gray)
                    
                    }
                    .padding(.bottom,10)
                    
                    HStack{
                        if let location = viewModel.selectedUberLocation {
                            Text(location.title)
                                .font(.system(size: 16,weight: .semibold))
                        }
                        
                        Spacer()
                        
                        Text(viewModel.dropoffTime ?? "2:43 PM")
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
                    ForEach(RideType.allCases) { type in
                        VStack(alignment: .leading){
                            
                            Image(type.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 65)
                                
                              

                            
                            VStack(alignment: .leading,spacing: 4){
                                Text(type.description)
                                    .font(.system(size: 14,weight: .semibold))
                                
                                Text(viewModel.computeRidePrice(forType: type).toCurrency())
                                    .font(.system(size: 14,weight: .semibold))
                        
                            }
                            
                        }
//                        .padding(.vertical,15)
                        .frame(width: 112, height: 140)
                        .foregroundStyle(type == selectedRideType ? .white : Color.theme.primaryTextColor)
                        .background(type == selectedRideType ? Color.blue : Color.theme.secondaryBackgroundColor)
                        .scaleEffect(type == selectedRideType ? 1.2 : 1.0)
                        .cornerRadius(10)
                        .onTapGesture {
                            withAnimation(.spring()){
                                selectedRideType = type
                            }
                        }
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
            .background(Color.theme.secondaryBackgroundColor)
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
        .background(Color.theme.backgroundColor)
        .cornerRadius(12)
    }
}

#Preview {
    RideRequestView()
        .environmentObject(LocationSearchViewModel())
}
