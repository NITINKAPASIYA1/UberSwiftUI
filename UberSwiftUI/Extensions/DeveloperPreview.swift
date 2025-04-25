//
//  DeveloperPreview.swift
//  UberSwiftUI
//
//  Created by Nitin on 26/04/25.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    
    static var dev : DeveloperPreview {
        return DeveloperPreview.shared
    }
    
}

class DeveloperPreview {
    
    static let shared = DeveloperPreview()
    
    let mockUser = User(userName: "Nitin Kumar", email: "nitin@gmail.com", uid: NSUUID().uuidString, coordinates: GeoPoint(latitude: 37.38, longitude: -122.05), accountType: .passenger, homeLocation: nil, workLocation: nil)
}
