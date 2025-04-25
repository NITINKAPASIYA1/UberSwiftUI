//
//  SavedLocation.swift
//  UberSwiftUI
//
//  Created by Nitin on 25/04/25.
//

import Firebase

struct SavedLocation : Codable, Hashable {
    let title : String
    let address : String
    let coordinates : GeoPoint
}
