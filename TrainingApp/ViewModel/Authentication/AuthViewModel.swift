//
//  AuthViewModel.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 29/11/2022.
//

import Foundation
import FirebaseAuth
import UIKit

protocol FormViewModel {
    func updateForm()
}

protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}

struct LoginViewModel: AuthenticationViewModel {

    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? UIColor(red: 0.0, green: 0.6, blue: 1.0, alpha: 1.0) : UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}

struct RegistrationViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    var fullname: String?
    var phoneNumber: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && phoneNumber?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? UIColor(red: 0.0, green: 0.6, blue: 1.0, alpha: 1.0) : UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}

struct ForgotPasswordViewModel: AuthenticationViewModel {
    var email: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? UIColor(red: 0.0, green: 0.6, blue: 1.0, alpha: 1.0) : UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
}
