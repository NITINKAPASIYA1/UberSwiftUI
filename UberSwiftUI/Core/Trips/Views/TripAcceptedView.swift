//
//  TripAcceptedView.swift
//  UberSwiftUI
//
//  Created by Nitin on 30/04/25.
//

import SwiftUI

struct TripAcceptedView: View {
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color.theme.primaryTextColor)
                .frame(width: 50, height: 5)
                .padding(.top, 10)
            
            VStack{
                HStack{
                    Text("Meet your driver at starbucks for your trip to apple campus")
                        .font(.body)
                        .frame(height: 44)
                        .lineLimit(2)
                        .padding(.trailing)
                    
                    Spacer()
                    
                    VStack{
                        Text("10")
                            .bold()
                        
                        Text("min")
                            .bold()
                    }
                    .frame(width: 56, height: 56)
                    .foregroundStyle(.white)
                    .background(Color(.systemBlue))
                    .cornerRadius(20)
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
                        Text("Nitin Kumar")
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
                    
                    VStack{
                        //Driver Vehicle info
                        VStack(alignment: .center){
                            Image("uber-x")
                                .resizable()
                                .frame(width: 100, height: 100)
                                
                            
                            HStack{
                                Text("Toyota")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(.gray)
                                
                                Text("UP12AE6102")
                                    .font(.system(size: 16, weight: .semibold))

                            }
                            .frame(width: 180)
                            .padding()
                        }
                    }
                    
                }
                
                Divider()
            }
            .padding()
            
            
            
            Button {
                print("DEBUG: Cancel trip")
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
    TripAcceptedView()
}
