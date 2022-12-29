//
//  LoginController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 29/11/2022.
//

import FirebaseAuth
import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
    @IBOutlet private var emailTextField: UITextField!
    
    @IBOutlet private var passwordTextField: UITextField!
    
    @IBOutlet private var signInButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
//        self.navigationController?.isNavigationBarHidden = false
        self.hideKeyboard()
        configureNotificationObservers()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Actions
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    @IBAction private func createAccountPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showCreateAccountPage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCreateAccountPage" {
            guard let destinationVC = segue.destination as? RegistrationViewController else { return }
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
        else if segue.identifier == "HomeViewController" {
            guard let destinationVC = segue.destination as? HomeViewController else { return }
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
    }
    
    @IBAction private func signInButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }

        AuthService.signInUser(withEmail: email, password: password, completion: {error in
            self.performSegue(withIdentifier: "HomeViewController", sender: self)
        })
        }
//        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
//            if let error = error {
//                print("DEBUG: Failed to login user \(error.localizedDescription)")
//                return
//            }
//            else if authResult != nil {
//                print("DEBUG: Successfully logged in user")
//                self?.performSegue(withIdentifier: "HomeViewController", sender: self)
//            }
//        })
//        }
    
    // MARK: - Helpers
    
    func configureUI() {
            emailTextField.setBorder()
            passwordTextField.setBorder()
            
            signInButton.layer.cornerRadius = 5
            signInButton.buttonSetupForLogin()
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

// MARK: FormViewModel

extension LoginViewController: FormViewModel {
    func updateForm() {
        signInButton.backgroundColor = viewModel.buttonBackgroundColor
        signInButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signInButton.isEnabled = viewModel.formIsValid
    }
}
