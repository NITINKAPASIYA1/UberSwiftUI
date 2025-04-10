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
    
}
