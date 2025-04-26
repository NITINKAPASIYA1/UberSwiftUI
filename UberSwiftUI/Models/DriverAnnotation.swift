//
//  DriverAnnotation.swift
//  UberSwiftUI
//
//  Created by Nitin on 26/04/25.
//

import Foundation
import Firebase
import MapKit

class DriverAnnotation : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    let uid : String
    
    init(driver : User) {
        self.coordinate = CLLocationCoordinate2D(latitude: driver.coordinates.latitude, longitude: driver.coordinates.longitude)
        self.uid = driver.uid
    }

    
    
}
