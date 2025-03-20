//
//  LocationManager.swift
//  UberSwiftUI
//
//  Created by Nitin on 21/03/25.
//

import Foundation
import CoreLocation

class LocationManager : NSObject, ObservableObject{
    private let locationManager  = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}
    
extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        locationManager.stopUpdatingLocation()
    }
}
