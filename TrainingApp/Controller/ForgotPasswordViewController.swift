//
//  ForgotPasswordViewController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 11/01/2023.
//

import Foundation
import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    
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
    }
    
    // MARK: - Actions
    
    @IBAction private func confirmButtonPressed(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text ?? "") { (error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            let alert = UIAlertController(title: "Success", message: "A reset email has been sent to \(self.emailTextField.text ?? "email")", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.performSegue(withIdentifier: "goToCodeSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCodeSegue" {
            guard let destinationVC = segue.destination as? CodeViewController else { return }
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
    
    private func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc
    private func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        }
        updateForm()
    }
}

extension ForgotPasswordViewController: FormViewModel {
    func updateForm() {
        confirmButton.backgroundColor = viewModel.buttonBackgroundColor
        confirmButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        confirmButton.isEnabled = viewModel.formIsValid
    }
}
