//
//  UberLocation.swift
//  UberSwiftUI
//
//  Created by Nitin on 13/04/25.
//

import Foundation
import CoreLocation

struct UberLocation : Identifiable {
    let id = NSUUID().uuidString
    let title : String
    let coordinate : CLLocationCoordinate2D
}
