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
    @State private var position: MapCameraPosition
    @State private var mapLocation: CLLocationCoordinate2D
    
    init(region: MKCoordinateRegion) {
        let center = CLLocationCoordinate2D(latitude: 37.3318, longitude: -122.0312)
        self._mapLocation = State(initialValue: center)
        self._position = State(initialValue: .region(MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))))
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
                    .background(Color(.systemBlue))
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
                        Text("NITIN")
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
                        
                        Text("$22.04")
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
                        Text("Apple Campus")
                            .font(.system(size: 18, weight: .semibold))
                        
                        Spacer()
                        
                        Text("5.2")
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
                Map(position: $position) {
                    Marker("Pickup Location", coordinate: mapLocation)
                }
                .frame(height: 220)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.6), radius: 10)
                .padding()
                
                Divider()
            }
        }
    }
}

#Preview {
    AcceptTripView(region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3318, longitude: -122.0312), span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)))
}
