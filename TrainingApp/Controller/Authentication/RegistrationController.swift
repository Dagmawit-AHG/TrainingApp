//
//  RegistrationController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 29/11/2022.
//

import UIKit

class RegistrationController: UIViewController {
    //implementation
    
    @IBOutlet var registrationView: UIView!
    
//    @IBOutlet weak var fullNameTextField: UITextField!
//
//    @IBOutlet weak var emailTextField: UITextField!
//
//    @IBOutlet weak var phoneNumberTextField: UITextField!
//
//
//    @IBOutlet weak var passwordTextField: UITextField!
    
    private let fullNameTextField = CustomTextField(placeholder: "Fullname")
    
    private let emailTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let phoneNumberTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Phone Number")
        tf.keyboardType = .phonePad
        return tf
    }()
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0, green: 150, blue: 255, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        registrationView.backgroundColor = UIColor(red: 139, green: 201, blue: 255, alpha: 1)
        
        configureUI()
    }
    
    func configureUI(){
        print("in configure ui")
        let stack = UIStackView(arrangedSubviews: [fullNameTextField, emailTextField, phoneNumberTextField, passwordTextField, signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
    }
    
    @IBAction func createAccountPressed(_ sender: UIButton) {
        
        let fullName = fullNameTextField.text
        let email = emailTextField.text
        let phoneNumber = phoneNumberTextField.text
        let password = passwordTextField.text
        
//        fullname.text
    }
    

}
