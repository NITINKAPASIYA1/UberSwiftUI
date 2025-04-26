//
//  HomeViewModel.swift
//  UberSwiftUI
//
//  Created by Nitin on 26/04/25.
//

import SwiftUI
import Firebase
import FirebaseAuth
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var drivers = [User]()
    var currentUser : User?
    private let service = UserService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchUser()
    }
    
    func fetchDrivers() {
        Firestore.firestore().collection("users")
            .whereField("accountType", isEqualTo: AccountType.driver.rawValue)
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
    
    func fetchUser() {
        service.$user
            .sink { user in
                guard let user = user else {return }
                self.currentUser = user
                guard user.accountType == .passenger else { return }
                self.fetchDrivers()
            }
            .store(in: &cancellables)
    }
}
