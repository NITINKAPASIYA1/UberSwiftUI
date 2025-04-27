//
//  GeoPoint.swift
//  UberSwiftUI
//
//  Created by Nitin on 28/04/25.
//

import CoreLocation
import Firebase

extension GeoPoint {
    func toCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
