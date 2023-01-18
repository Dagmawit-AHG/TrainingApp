//
//  NewPasswordViewController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 16/01/2023.
//

import UIKit

final class NewPasswordViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = NewPasswordViewModel()
    
    @IBOutlet private var backButton: UIImageView!
    @IBOutlet private var newPasswordTextField: UITextField!
    @IBOutlet private var confirmPasswordTextField: UITextField!
    @IBOutlet private var setPasswordButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: - Actions
    
    @IBAction func setPasswordPressed(_ sender: UIButton) {
        
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        newPasswordTextField.setBorder()
        confirmPasswordTextField.setBorder()
        setPasswordButton.buttonSetupForNewPassword()
    }
    
    private func configureNotificationObservers() {
        newPasswordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc
    private func textDidChange(sender: UITextField) {
        checkPasswords()
        if sender == newPasswordTextField {
            viewModel.newPassword = sender.text
        }
        else {
            viewModel.confirmPassword = sender.text
        }
        updateForm()
    }
    
    private func checkPasswords() {
        if newPasswordTextField.text == confirmPasswordTextField.text {
            newPasswordTextField.setGreenBorder()
            confirmPasswordTextField.setGreenBorder()
        }
        else {
            newPasswordTextField.setRedBorder()
            confirmPasswordTextField.setRedBorder()
        }
    }
}

// MARK: FormViewModel

extension NewPasswordViewController: FormViewModel {
    func updateForm() {
        setPasswordButton.backgroundColor = viewModel.buttonBackgroundColor
        setPasswordButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        setPasswordButton.isEnabled = viewModel.formIsValid
    }
}
