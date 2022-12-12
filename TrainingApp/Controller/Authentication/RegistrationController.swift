//
//  RegistrationController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 29/11/2022.
//

import UIKit
import FirebaseAuth

class RegistrationController: UIViewController {
    //implementation
    
    
    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureUI()
    }
    
    func configureUI(){
        fullNameTextField.setBorder()
        emailTextField.setBorder()
        phoneNumberTextField.setBorder()
        passwordTextField.setBorder()
        createAccountButton.layer.cornerRadius = 5
    }
    
    
    
    @IBAction func createAccountPressed(_ sender: UIButton) {
        
        guard let fullName = fullNameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let phoneNumber = phoneNumberTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        let credentials = AuthCredentials(email: email, password: password, fullName: fullName, phoneNumber: phoneNumber)
        
        AuthService.registerUser(withCredential: credentials) { error in
            if let error = error {
                print("DEBUG: Failed to register user \(error.localizedDescription)")
                return
            }
            
            print("DEBUG: Successfully registered user with firestore...")
        }
                
            
        }
        
    
    
}
