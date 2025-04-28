//
//  Trip.swift
//  UberSwiftUI
//
//  Created by Nitin on 28/04/25.
//

import Foundation
import Firebase

struct Trip: Identifiable , Codable{
    
    let id : String
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
    
}
