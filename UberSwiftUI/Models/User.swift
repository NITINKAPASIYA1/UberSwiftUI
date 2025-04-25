//
//  User.swift
//  UberSwiftUI
//
//  Created by Nitin on 22/04/25.
//

import Foundation
import Firebase

enum AccountType : Int, Codable {
    case passenger
    case driver
}

struct User : Codable{
    let userName : String
    let email : String
    let uid : String
    var coordinates : GeoPoint
    var accountType : AccountType
    var homeLocation : SavedLocation?
    var workLocation : SavedLocation?
}
