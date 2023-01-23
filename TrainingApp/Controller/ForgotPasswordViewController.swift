//
//  ForgotPasswordViewController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 11/01/2023.
//

import FirebaseAuth
import UIKit

final class ForgotPasswordViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = ForgotPasswordViewModel()
    
    @IBOutlet private var backButton: UIImageView!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var confirmButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        configureUI()
        configureNotificationObservers()
        setupTapGestureForViews()
    }
    
    // MARK: - Actions
    
    @IBAction private func confirmButtonPressed(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text ?? R.string.localizable.empty()) { [weak self] error in
            if let error = error {
                let alert = UIAlertController(title: R.string.localizable.error(), message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: R.string.localizable.oK(), style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
                return
            }
            let alert = UIAlertController(title: R.string.localizable.success(), message: R.string.localizable.aResetEmailHasBeenSentTo() + (self?.emailTextField.text ?? R.string.localizable.email()), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: R.string.localizable.oK(), style: UIAlertAction.Style.default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
            self?.performSegue(withIdentifier: R.string.localizable.goToCodeSegue(), sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.string.localizable.goToCodeSegue() {
            guard let destinationVC = segue.destination as? VerificationCodeViewController else { return }
            
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
        else if segue.identifier == R.string.localizable.backToLoginSegue() {
            guard let destinationVC = segue.destination as? LoginViewController else { return }
            
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
    }
    // MARK: - Helpers
    
    private func configureUI() {
        emailTextField.setBorder()
        confirmButton.buttonSetupForConfirm()
    }
    
    private func setupTapGestureForViews() {
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(ForgotPasswordViewController.backImageTapped(gesture:)))
        backButton.addGestureRecognizer(backTapGesture)
        backButton.isUserInteractionEnabled = true
    }
    
    private func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc
    private func backImageTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UIImageView) != nil {
            performSegue(withIdentifier: R.string.localizable.backToLoginSegue(), sender: self)
        }
    }
    
    @objc
    private func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        }
        updateForm()
    }
}

// MARK: FormViewModel

extension ForgotPasswordViewController: FormViewModel {
    func updateForm() {
        confirmButton.backgroundColor = viewModel.buttonBackgroundColor
        confirmButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        confirmButton.isEnabled = viewModel.formIsValid
    }
}
