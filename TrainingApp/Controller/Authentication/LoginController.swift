//
//  LoginController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 29/11/2022.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {
    //implementation
    
    //MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.hideKeyboard()
        configureNotificationObservers()
        
        let gradient = CAGradientLayer()
        gradient.locations = [0,1]
        self.view.layer.addSublayer(gradient)
        
        emailTextField.setBorder()
        passwordTextField.setBorder()
        
        signInButton.layer.cornerRadius = 5
        signInButton.buttonSetup()
    }
    
    //MARK: - Actions
    
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    @IBAction func createAccountPressed(_ sender: UIButton) {
        let registrationVC = RegistrationController()
        
        self.present(registrationVC, animated: true, completion: nil)
    }
    
    
    @IBAction private func signInButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            if let error = error {
                print("DEBUG: Failed to login user \(error.localizedDescription)")
                return
            }
            else if authResult != nil {
                print("DEBUG: Successfully logged in user")
                self?.performSegue(withIdentifier: "HomeController", sender: self)
            }
        })
        }
    
    //MARK: - Helpers
    
    func configureUI(){

        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 80, paddingLeft: 32, paddingRight: 32)
//        view.addSubview(backgroundImage)
        
    }
    
    func configureNotificationObservers(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

//MARK: FormViewModel

extension LoginController: FormViewModel {
    func updateForm() {
        signInButton.backgroundColor = viewModel.buttonBackgroundColor
        signInButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signInButton.isEnabled = viewModel.formIsValid
    }
}
