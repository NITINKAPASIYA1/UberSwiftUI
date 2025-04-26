//
//  UserService.swift
//  UberSwiftUI
//
//  Created by Nitin on 26/04/25.
//

import Foundation
import Firebase
import FirebaseAuth

class UserService : ObservableObject {
    
    static let shared = UserService()
    @Published var user : User?
    
    init() {
        print("DEBUG: UserService initialized")
        fetchUser()
    }
    
    func fetchUser() {

        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument() { snapshot , error in
            print("DEBUG: Did fetched User from firestore")
            guard let snapshot = snapshot else { return }
            guard let user = try? snapshot.data(as: User.self) else {return}
            self.user = user

        }

    }
    
//    func fetchUser(completion: @escaping (User) -> Void) {
//        
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        Firestore.firestore().collection("users").document(uid).getDocument() { snapshot , error in
//            
//            print("DEBUG: Did fetched User from firestore")
//            guard let snapshot = snapshot else { return }
//            guard let user = try? snapshot.data(as: User.self) else {return}
//            completion(user)
//            print("DEBUG: User data fetched successfully")
//
//        }
//
//    }
        
    
}
