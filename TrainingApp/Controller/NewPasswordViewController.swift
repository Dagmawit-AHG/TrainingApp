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
        setupTapGestureForViews()
    }
    
    // MARK: - Actions
    
    @IBAction func setPasswordPressed(_ sender: UIButton) {
        performSegue(withIdentifier: R.string.localizable.goToLoginAfterNewPass(), sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.string.localizable.goToLoginAfterNewPass() {
            guard let destinationVC = segue.destination as? LoginViewController else { return }
            
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
        else if segue.identifier == R.string.localizable.backToVerficationSegue() {
            guard let destinationVC = segue.destination as? VerificationCodeViewController else { return }
            
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        newPasswordTextField.setBorder()
        confirmPasswordTextField.setBorder()
        setPasswordButton.buttonSetupForNewPassword()
    }
    
    private func setupTapGestureForViews() {
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(NewPasswordViewController.backImageTapped(gesture:)))
        backButton.addGestureRecognizer(backTapGesture)
        backButton.isUserInteractionEnabled = true
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
    
    @objc
    private func backImageTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UIImageView) != nil {
            performSegue(withIdentifier: R.string.localizable.backToVerficationSegue(), sender: self)
        }
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
