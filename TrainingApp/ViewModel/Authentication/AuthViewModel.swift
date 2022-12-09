//
//  AuthViewModel.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 29/11/2022.
//

import Foundation
import FirebaseAuth

struct LoginViewModel {
    var email: String
    var password: String
    
    var formIsValid: Bool {
        return email.isEmpty == false && password.isEmpty == false
    }
}

struct RegistrationViewModel {
    var email: String
    var password: String
    var fullname: String
    var phoneNumber: String
}
