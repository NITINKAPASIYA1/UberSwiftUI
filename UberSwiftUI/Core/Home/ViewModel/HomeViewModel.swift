//
//  HomeViewModel.swift
//  UberSwiftUI
//
//  Created by Nitin on 26/04/25.
//

import Foundation
import SwiftUI
import Firebase

class HomeViewModel: ObservableObject {
    
    @Published var drivers = [User]()
    
    init() {
        fetchDrivers()
    }
    
    func fetchDrivers() {
        Firestore.firestore().collection("users").whereField("accountType", isEqualTo: AccountType.driver.rawValue)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Failed to fetch drivers with error \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                
                let driver = documents.compactMap { try? $0.data(as : User.self) }
                self.drivers = driver
                print("DEBUG: Driver - \(driver)")
                
            }
        
        
    }
}
