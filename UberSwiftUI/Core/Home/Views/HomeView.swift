//
//  HomeView.swift
//  UberSwiftUI
//
//  Created by Nitin on 21/03/25.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @State private var mapState = MapViewState.noInput
    @State private var showSideMenu = false
//    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    @EnvironmentObject var authViewModel : AuthViewModel
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil{
                LoginView()
            }
            else if let user = authViewModel.currentUser {
                NavigationStack{
                    ZStack{
                        if showSideMenu {
                            SideMenuView(user: user)
                        }
                        mapView
                            .offset(x: showSideMenu ? 316 : 0)
                            .shadow(color: showSideMenu ? Color.black : Color.clear, radius: 10)
                    }
                    .onAppear {
                        showSideMenu = false
                    }
                }
            }
        }
    }
}

extension HomeView {
    var mapView: some View {
        ZStack (alignment: .bottom){
            
            ZStack(alignment: .top){
                UberMapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                
                if mapState == .searchingForLocation {
                    LocationSearchView()
                }
                else if mapState == .noInput {
                    LocationSearchActivationView()
                        .padding(.top,72)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                mapState = .searchingForLocation
                            }
                        }
                }
                
                MapViewActionButton(mapState: $mapState, showSideMenu: $showSideMenu)
                    .padding(.leading)
                    .padding(.top,4)
                
            }
            
            if let user = authViewModel.currentUser {
                if user.accountType == .passenger {
                    if mapState == .locationSelected || mapState == .polylineAdded {
                        RideRequestView()
                            .transition(.move(edge: .bottom))
                    }
                    else if mapState == .tripRequested {
                        //show trip loading view
                      
                        TripLoadingView()
                            .transition(.move(edge: .bottom))
                    }
                    else if mapState == .tripAccepted {
                        //show trip accepted view
                        TripAcceptedView()
                            .transition(.move(edge: .bottom))
                    }
                    else if mapState == .tripRejected {
                        //show trip rejected view
                    }

                }
                else {
                    if let trip = homeViewModel.trip {
                        if mapState == .tripRequested {
                            AcceptTripView(trip: trip)
                                .transition(.move(edge: .bottom))
                        }
                        else if mapState == .tripAccepted {
                            PickupPassengerView(trip: trip)
                                .transition(.move(edge: .bottom))
                        }
                        
                    }
                }
                
            }
                
            
           
            
           
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location = location {
                homeViewModel.userLocation = location
            }
        }
        .onReceive(homeViewModel.$selectedUberLocation) { location in
            if location != nil {
                self.mapState = .locationSelected
            }
        }
        .onReceive(homeViewModel.$trip) { trip in
            guard let trip = trip else {return}
            
            withAnimation(.spring()) {
                switch trip.state {
                case .requested:
                    self.mapState = .tripRequested
                case .accepted:
                    self.mapState = .tripAccepted
                case .rejected:
                    self.mapState = .tripRejected
                case .passengerCancelled:
                    print("DEBUG: Passenger cancelled the trip")
                case .driverCancelled:
                    print("DEBUG: Driver cancelled the trip")
                }
            }
        }
    }
}

#Preview {
    HomeView()
//        .environmentObject(LocationSearchViewModel())
        .environmentObject(AuthViewModel())
        .environmentObject(HomeViewModel())
        
}
