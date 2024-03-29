//
//  LoginController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 29/11/2022.
//

import FirebaseAuth
import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = LoginViewModel()
    private let userDefaults = UserDefaults.standard
    
    var isSeguePending = false
    
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var forgotPasswordButton: UIButton!
    @IBOutlet private var signInButton: UIButton!
    @IBOutlet private var createAccountButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.hideKeyboard()
        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: - Actions
    
    @IBAction private func createAccountPressed(_ sender: UIButton) {
        performSegue(withIdentifier: R.string.localizable.showCreateAccountPage(), sender: self)
    }
    
    @IBAction private func signInButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }

        AuthService.signInUser(withEmail: email, password: password, completion: { [ weak self ] error in
            if error != nil {
                let alert = UIAlertController(title: R.string.localizable.couldnTSignin(), message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: R.string.localizable.oK(), style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
            self?.userDefaults.set(true, forKey: R.string.localizable.userStatus())
            self?.performSegue(withIdentifier: R.string.localizable.homeViewController(), sender: self)
        })
    }
    
    @IBAction func forgotPasswordPressed(_ sender: UIButton) {
        performSegue(withIdentifier: R.string.localizable.showForgotPasswordPage(), sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.string.localizable.showCreateAccountPage() {
            guard let destinationVC = segue.destination as? RegistrationViewController else { return }
            
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
        else if segue.identifier == R.string.localizable.homeViewController() {
            guard let destinationVC = segue.destination as? HomeViewController else { return }
            
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            destinationVC.navigationController?.navigationBar.backgroundColor = .clear
            present(destinationVC, animated: true, completion: nil)
        }
        else if segue.identifier == R.string.localizable.showForgotPasswordPage() {
            guard let destinationVC = segue.destination as? ForgotPasswordViewController else { return }
            
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            destinationVC.navigationController?.navigationBar.backgroundColor = .clear
            present(destinationVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        emailTextField?.setBorder()
        passwordTextField?.setBorder()
        signInButton?.layer.cornerRadius = 5
        signInButton?.buttonSetupForLogin()
        let createTitle = NSAttributedString(string: R.string.localizable.createAccount(), attributes: [NSAttributedString.Key.foregroundColor: R.color.borderColorBlue()!])
        createAccountButton.setAttributedTitle(createTitle, for: .normal)
        let forgotTitle = NSAttributedString(string: R.string.localizable.forgotPassword(), attributes: [NSAttributedString.Key.foregroundColor: R.color.borderColorBlue()!])
        forgotPasswordButton.setAttributedTitle(forgotTitle, for: .normal)
    }
    
    private func configureNotificationObservers() {
        emailTextField?.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField?.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc
    private func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        updateForm()
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

// MARK: ForgotPasswordViewControllerDelegate

extension LoginViewController: ForgotPasswordViewControllerDelegate {
    
    func viewControllerDidSendResetPasswordLink(_ viewController: ForgotPasswordViewController?) {
        showMessage(withTitle: "Success", message: "We sent a link to your email to reset your password.")
    }
}
