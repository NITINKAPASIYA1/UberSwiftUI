//
//  AuthViewModel.swift
//  UberSwiftUI
//
//  Created by Nitin on 19/04/25.
//

import Foundation
import FirebaseAuth


class AuthViewModel : ObservableObject {
    @Published var userSession : FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
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
            self.userSession = result?.user
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
    
    
    
}
