//
//  PickupPassengerView.swift
//  UberSwiftUI
//
//  Created by Nitin on 01/05/25.
//

import SwiftUI

struct PickupPassengerView: View {
    let trip : Trip
    @EnvironmentObject var viewModel : HomeViewModel
    
    var body: some View {
        VStack{
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            VStack {
                HStack {
                    Text("Pickup \(trip.passengerName) at \(trip.dropoffLocationName)")
                        .font(.headline)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(height: 44)
                    
                    Spacer()
                    
                    VStack {
                        Text("\(trip.travelTimeToPassenger)")
                            .bold()
                        
                        Text("min")
                            .bold()
                    }
                    .frame(width: 56, height: 56)
                    .foregroundStyle(.white)
                    .background(Color(.black))
                    .cornerRadius(10)
                    
                }
                .padding()
                
                Divider()
            }
            
            VStack {
                HStack {
                    Image(.profile)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("\(trip.passengerName)")
                            .bold()
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                                .imageScale(.medium)
                            
                            Text("4.8")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text("Earnings")
                        
                        Text("\(trip.tripCost.toCurrency())")
                            .font(.system(size: 24, weight: .semibold))
                    }
                    .padding()
                }
                
                Divider()
            }
            .padding()
            
            Button {
                viewModel.cancelTripAsDriver()
            } label: {
                Text("CANCEL TRIP")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(.red)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                    
            }
            
        }
        .padding(.bottom,24)
        .background(Color.theme.backgroundColor)
        .cornerRadius(16)
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 20)
    }
}

#Preview {
//    PickupPassengerView()
}
