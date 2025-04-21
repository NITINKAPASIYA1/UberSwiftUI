//
//  SideMenuOptionViewModel.swift
//  UberSwiftUI
//
//  Created by Nitin on 22/04/25.
//

import Foundation

enum SideMenuOptionViewModel : Int, CaseIterable {
    case trips
    case wallet
    case settings
    case messages
    
    var title : String {
        switch self {
        case .trips : return "Your Trips"
        case .wallet : return "Your Wallet"
        case .settings : return "Settings"
        case .messages : return "Messages"
        }
    }
    
    var icon : String {
        switch self {
        case .trips : return "list.bullet.rectangle"
        case .wallet : return "creditcard"
        case .settings : return "gear"
        case .messages : return "bubble.left"
        }
    }
}
