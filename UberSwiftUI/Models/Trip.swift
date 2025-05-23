//
//  Trip.swift
//  UberSwiftUI
//
//  Created by Nitin on 28/04/25.
//

import Foundation
import Firebase
import FirebaseFirestore


enum TripState : Int, Codable {
    case requested
    case rejected
    case accepted
    case passengerCancelled
    case driverCancelled
}

struct Trip: Identifiable , Codable{
    
    @DocumentID var tripId : String?
    let passengerUid : String
    let driverUid : String
    let passengerName : String
    let driverName : String
    let driverLocation : GeoPoint
    let passengerLocation : GeoPoint
    let pickupLocationName : String
    let dropoffLocationName : String
    let pickupLocationAddress : String
    let pickupLocation : GeoPoint
    let dropoffLocation : GeoPoint
    let tripCost : Double
    var distanceToPassenger : Double
    var travelTimeToPassenger : Int
    var state : TripState
    
    var id : String {
        return tripId ?? ""
    }
    
}
