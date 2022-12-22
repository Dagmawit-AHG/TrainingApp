//
//  LoginController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 29/11/2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
    @IBOutlet private var emailTextField: UITextField!
    
    @IBOutlet private var passwordTextField: UITextField!
    
    @IBOutlet private var signInButton: UIButton!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.hideKeyboard()
        configureNotificationObservers()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
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
        let registrationVC = RegistrationViewController()
        
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
                self?.performSegue(withIdentifier: "HomeViewController", sender: self)
            }
        })
        }
    
    //MARK: - Helpers
    
    func configureUI(){
            emailTextField.setBorder()
            passwordTextField.setBorder()
            
            signInButton.layer.cornerRadius = 5
            signInButton.buttonSetup()
    }
    
    func configureNotificationObservers(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

//MARK: FormViewModel

extension LoginViewController: FormViewModel {
    func updateForm() {
        signInButton.backgroundColor = viewModel.buttonBackgroundColor
        signInButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signInButton.isEnabled = viewModel.formIsValid
    }
}
