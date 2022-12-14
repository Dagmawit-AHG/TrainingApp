//
//  RegistrationController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 29/11/2022.
//

import FirebaseAuth
import UIKit

class RegistrationViewController: UIViewController {

    // MARK: - Properties
    
    private var viewModel = RegistrationViewModel()
    
    @IBOutlet private var fullNameTextField: UITextField!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var phoneNumberTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var createAccountButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: - Actions
    
    @IBAction private func createAccountPressed(_ sender: UIButton) {
        
        guard let fullName = fullNameTextField.text,
              let email = emailTextField.text,
              let phoneNumber = phoneNumberTextField.text,
              let password = passwordTextField.text else { return }
        
        let credentials = AuthCredentials(email: email, password: password, fullName: fullName, phoneNumber: phoneNumber)
        
        AuthService.registerUser(withCredential: credentials) { [weak self] error in
            if let error = error {
                print("DEBUG: Failed to register user \(error.localizedDescription)")
                return
            }
            
            print("DEBUG: Successfully registered user with firestore...")
            self?.performSegue(withIdentifier: "HomeViewController", sender: self)
        }
        }
    
    @IBAction private func signInButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showLoginPage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLoginPage" {
            guard let destinationVC = segue.destination as? LoginViewController else { return }
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.isNavigationBarHidden = false
            present(destinationVC, animated: true, completion: nil)
        }
        else if segue.identifier == "HomeViewController" {
            guard let destinationVC = segue.destination as? HomeViewController else { return }
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.isNavigationBarHidden = false
            present(destinationVC, animated: true, completion: nil)
        }
    }
    // MARK: - Helpers
    
    private func configureUI() {
        fullNameTextField.setBorder()
        emailTextField.setBorder()
        phoneNumberTextField.setBorder()
        passwordTextField.setBorder()
        createAccountButton.layer.cornerRadius = 5
        createAccountButton.buttonSetupForRegistration()
    }
        
    private func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        phoneNumberTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc
    private func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        }
        else if sender == passwordTextField {
            viewModel.password = sender.text
        }
        else if sender == fullNameTextField {
            viewModel.fullname = sender.text
        }
        else {
            viewModel.phoneNumber = sender.text
        }
        updateForm()
    }
}

// MARK: FormViewModel

extension RegistrationViewController: FormViewModel {
    func updateForm() {
        createAccountButton.backgroundColor = viewModel.buttonBackgroundColor
        createAccountButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        createAccountButton.isEnabled = viewModel.formIsValid
    }
}
