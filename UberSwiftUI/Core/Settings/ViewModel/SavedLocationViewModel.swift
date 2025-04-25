//
//  SavedLocationViewModel.swift
//  UberSwiftUI
//
//  Created by Nitin on 23/04/25.
//

import Foundation

enum SavedLocationViewModel : CaseIterable , Hashable{
    case home
    case work
    
    var title : String {
        switch self {
        case .home:
            return "Home"
        case .work:
            return "Work"
        }
            
    }
    
    var subTitle : String {
        switch self {
        case .home:
            return "Add Home"
        case .work:
            return "Add Work"
        }
            
    }
        
    var imageName : String {
        switch self {
        case .home:
            return "house.circle.fill"
        case .work:
            return "archivebox.circle.fill"
        }
    }
    
    var dataBaseKey : String {
        switch self {
        case .home:
            return "homeLocation"
        case .work:
            return "workLocation"
        } 
    }
    
    func subtitle(forUser user : User) -> String {
        switch self {
        case .home:
            if let homeLocation = user.homeLocation {
                return homeLocation.title
            } else {
                return "Add Home"
            }
        case .work:
            if let workLocation = user.workLocation {
                return workLocation.title
            } else {
                return "Add Work"
            }
        }
    }
}
