//
//  AuthViewModel.swift
//  UberSwiftUI
//
//  Created by Nitin on 19/04/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel : ObservableObject {
    @Published var userSession : FirebaseAuth.User?
    @Published var currentUser : User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func signIn(withEmail email : String , password : String) {
        
        Auth.auth().signIn(withEmail: email, password: password) {result, error in
            if let error = error {
                print("DEBUG: Failed to sign in user with error \(error.localizedDescription)")
                return
            }
            
            self.userSession = result?.user
        }
            
    }
    
    func registerUser(withEmail email : String , password : String , fullName : String) {
        
        Auth.auth().createUser(withEmail: email, password: password) {result, error in
            if let error = error {
                print("DEBUG: Failed to register user with error \(error.localizedDescription)")
                return
            }
            
            print("DEBUG: Successfully registered user with Email \(email) and password \(password)")
            
            guard let firebaseUser = result?.user else { return }
            self.userSession = firebaseUser
            
            let user = User(
                userName:fullName,
                email: email,
                uid: firebaseUser.uid,
                coordinates: GeoPoint(latitude: 37.28, longitude: -122.05),
                accountType: .driver,
            )
            
            guard let encodedUser = try? Firestore.Encoder().encode(user) else {return}
            
            Firestore.firestore().collection("users").document(firebaseUser.uid).setData(encodedUser){ error in
                if let error = error {
                    print("DEBUG: Failed to upload user data with error \(error.localizedDescription)")
                    return
                }
            }
        }
        
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            print("DEBUG: Successfully signed out user from firebase")
        } catch let error {
            print("DEBUG: Failed to sign out user with error \(error.localizedDescription)")
        }
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return}
        
        Firestore.firestore().collection("users").document(uid).getDocument() { snapshot , error in
            
            guard let snapshot = snapshot else { return }
            
            guard let user = try? snapshot.data(as: User.self) else {return}
            
            self.currentUser = user
            
            print("DEBUG: Current user \(user)")
            
        }
        
    }
    
    
    
}
