//
//  RideType.swift
//  UberSwiftUI
//
//  Created by Nitin on 11/04/25.
//

import Foundation

enum RideType: Int , CaseIterable , Identifiable {
    
    case uberX
    case black
    case uberTri
    
    var id : Int { return rawValue }
    
    var description :String {
        switch self {
            case .uberX:
                return "UberX"
            case .black:
                return "Black"
            case .uberTri:
                return "UberXL"
        }
    }
    
    var imageName : String {
        switch self {
            case .uberX:
                return "uber-x"
            case .black:
                return "uber-x"
            case .uberTri:
                return "uber-tri"
        }
    }
    
    var baseFare : Double {
        switch self {
        case .uberX:
            return 15.00
            
        case .black:
            return 20.00
            
        case .uberTri:
            return 10.00
        }
    }
    
    func computePrice(for distance: Double) -> Double {
        let distanceInMiles = distance / 1600
        
        switch self {
        case .black:
            return baseFare + (distanceInMiles * 2.50) + baseFare
        case .uberX:
            return baseFare + (distanceInMiles * 1.75) + baseFare
        case .uberTri:
            return baseFare + (distanceInMiles * 1.00) + baseFare
        }
    }
    
}
