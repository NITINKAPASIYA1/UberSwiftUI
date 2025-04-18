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
    
    func registerUser(withEmail email : String , password : String , fullName : String) {
        Auth.auth().createUser(withEmail: email, password: password) {result, error in
            if let error = error {
                print("DEBUG: Failed to register user with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else {return}
            
            print("DEBUG: Successfully registered user with Email \(email) and password \(password)")
            print("DEBUG: User ID is \(user.uid)")
        }
    }
    
    
    
}
