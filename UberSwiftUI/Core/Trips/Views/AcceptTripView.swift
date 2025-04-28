//
//  AcceptTripView.swift
//  UberSwiftUI
//
//  Created by Nitin on 28/04/25.
//

//
//  AcceptTripView.swift
//  UberSwiftUI
//
//  Created by Nitin on 28/04/25.
//

import SwiftUI
import MapKit

struct AcceptTripView: View {
    @State private var region : MKCoordinateRegion
    let trip : Trip
    let annotationItem : UberLocation
        
    init(trip : Trip) {
        let center = CLLocationCoordinate2D(latitude: trip.pickupLocation.latitude, longitude: trip.pickupLocation.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        self.region = MKCoordinateRegion(center: center, span: span)
        self.trip = trip
        self.annotationItem = UberLocation(title: trip.pickupLocationName, coordinate: trip.pickupLocation.toCoordinate())
    }
    
    var body: some View {
        VStack {
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            //would you like to pickup view
            VStack {
                HStack {
                    Text("Would you like to pickup the passenger?")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(height: 44)
                    
                    Spacer()
                    
                    VStack {
                        Text("10")
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
            
            //user info view
            VStack {
                HStack {
                    Image(.profile)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(trip.passengerName)
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
                        
                        Text(trip.tripCost.toCurrency())
                            .font(.system(size: 24, weight: .semibold))
                    }
                    .padding()
                }
                
                Divider()
            }
            .padding()
            
            VStack {
                VStack(spacing: 5) {
                    HStack {
                        Text(trip.pickupLocationName)
                            .font(.system(size: 18, weight: .semibold))
                        
                        Spacer()
                        
                        Text(trip.pickupLocationAddress)
                            .font(.system(size: 16, weight: .semibold))
                    }
                    
                    HStack {
                        Text("1 Infinite Loop, Cupertino, CA 95014")
                            .font(.system(size: 16))
                            .foregroundStyle(.gray)
                        
                        Spacer()
                        
                        Text("mi")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.horizontal)
                
                // Updated Map with new API
                Map(coordinateRegion: $region,annotationItems: [annotationItem]){
                    item in
                    
                    MapMarker(coordinate: item.coordinate)
                    
                }
                .frame(height: 220)
                .cornerRadius(10)
                .shadow(color: .black, radius: 4)
                .padding()
                
                Divider()
            }
            
            HStack{
                
                Button {
                    
                } label: {
                    Text("Reject")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: (UIScreen.main.bounds.width / 2) - 32, height: 55)
                        .background(Color(.systemRed))
                        .cornerRadius(10)
                        
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Accept")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: (UIScreen.main.bounds.width / 2) - 32, height: 55)
                        .background(Color(.black))
                        .cornerRadius(10)
                        
                }

            }
            .padding(.top)
            .padding(.horizontal)
            .padding(.bottom, 24)
        }
        .background(Color.theme.backgroundColor)
        .cornerRadius(16)
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 20)
        
    }
}

#Preview {
//    AcceptTripView(trip: <#Trip#>)
}
