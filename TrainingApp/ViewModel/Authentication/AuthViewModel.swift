//
//  AuthViewModel.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 29/11/2022.
//

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
        return formIsValid ? R.color.enabledButton()! : R.color.disabledButton()!
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : R.color.disabledTitleColor()!
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
        return formIsValid ? R.color.enabledButton()! : R.color.disabledButton()!
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : R.color.disabledTitleColor()!
    }
}

struct ForgotPasswordViewModel: AuthenticationViewModel {
    var email: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? R.color.enabledButton()! : R.color.disabledButton()!
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : R.color.disabledTitleColor()!
    }
}

struct VerificationCodeViewModel: AuthenticationViewModel {
    var firstDigit: String?
    var secondDigit: String?
    var thirdDigit: String?
    var fourthDigit: String?
    var fifthDigit: String?
    
    var formIsValid: Bool {
        return firstDigit?.isEmpty == false && secondDigit?.isEmpty == false && thirdDigit?.isEmpty == false && fourthDigit?.isEmpty == false && fifthDigit?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? R.color.enabledButton()! : R.color.disabledButton()!
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : R.color.disabledTitleColor()!
    }
}

struct NewPasswordViewModel: AuthenticationViewModel {
    var newPassword: String?
    var confirmPassword: String?
    
    var formIsValid: Bool {
        return newPassword?.isEmpty == false && confirmPassword?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? R.color.enabledButton()! : R.color.disabledButton()!
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : R.color.disabledTitleColor()!
    }
}

struct HomeViewModel: AuthenticationViewModel {
    var fromTextField: String?
    var toTextField: String?
    
    var formIsValid: Bool {
        return fromTextField?.isEmpty == false && toTextField?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? R.color.enabledButton()! : R.color.disabledButton()!
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : R.color.disabledTitleColor()!
    }
}
