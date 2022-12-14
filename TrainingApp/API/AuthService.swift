//
//  AuthService.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 12/12/2022.
//

import FirebaseFirestore
import FirebaseAuth
import UIKit

struct AuthCredentials {
    let email: String
    let password: String
    let fullName: String
    let phoneNumber: String
}

struct AuthService {
    static func registerUser(withCredential credentials: AuthCredentials, completion: @escaping (Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
            if let error = error {
                print("DEBUG: Failed to register user \(error.localizedDescription)")
                return
            }
            guard let uid = result?.user.uid else { return }
            
            let data: [String: Any] = ["email": credentials.email,
                                       "fullname": credentials.fullName,
                                       "phoneNumber": credentials.phoneNumber,
                                       "password": credentials.password,
                                       "uid": uid]
            
            Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
        }
    }
    
    static func signInUser(withEmail email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Failed to login user \(error.localizedDescription)")
                return
            }
        
            completion(error)
                
            print("DEBUG: Successfully logged in user: \(String(describing: result?.user.email))")
        }
    }
}
