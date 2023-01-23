//
//  VerificationCodeViewController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 12/01/2023.
//

import UIKit

final class VerificationCodeViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    private var viewModel = CodeViewModel()
    
    @IBOutlet private var backButton: UIImageView!
    @IBOutlet private var firstDigitTextField: UITextField!
    @IBOutlet private var secondDigitTextField: UITextField!
    @IBOutlet private var thirdDigitTextField: UITextField!
    @IBOutlet private var fourthDigitTextField: UITextField!
    @IBOutlet private var fifthDigitTextField: UITextField!
    @IBOutlet private var confirmButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        textFieldSetup()
        configureUI()
        configureNotificationObservers()
        setupTapGestureForViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstDigitTextField.becomeFirstResponder()
    }
    
    // MARK: - Actions
    
    @IBAction private func confirmPressed(_ sender: UIButton) {
//        let verificationCode = firstDigitTextField.text + secondDigitTextField.text
        performSegue(withIdentifier: R.string.localizable.goToNewPassword(), sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.string.localizable.goBackToForgotPass() {
            guard let destinationVC = segue.destination as? ForgotPasswordViewController else { return }
            
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
        else if segue.identifier == R.string.localizable.goToNewPassword() {
            guard let destinationVC = segue.destination as? NewPasswordViewController else { return }
            
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers
    
    private func setupTapGestureForViews() {
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(VerificationCodeViewController.backImageTapped(gesture:)))
        backButton.addGestureRecognizer(backTapGesture)
        backButton.isUserInteractionEnabled = true
    }
    
    @objc
    private func textDidChange(textfield: UITextField) {
        let text = textfield.text
        
        if text?.utf16.count == 1 {
            switch textfield {
            case firstDigitTextField:
                secondDigitTextField.becomeFirstResponder()
                break
            case secondDigitTextField:
                thirdDigitTextField.becomeFirstResponder()
                break
            case thirdDigitTextField:
                fourthDigitTextField.becomeFirstResponder()
                break
            case fourthDigitTextField:
                fifthDigitTextField.becomeFirstResponder()
                break
            case fifthDigitTextField:
                fifthDigitTextField.resignFirstResponder()
                break
            default:
                break
            }
        }
        else {
        }
    }
    
    private func configureUI() {
        firstDigitTextField.addTarget(self, action: #selector(self.textDidChange(textfield:)), for: UIControl.Event.editingChanged)
        secondDigitTextField.addTarget(self, action: #selector(self.textDidChange(textfield:)), for: UIControl.Event.editingChanged)
        thirdDigitTextField.addTarget(self, action: #selector(self.textDidChange(textfield:)), for: UIControl.Event.editingChanged)
        fourthDigitTextField.addTarget(self, action: #selector(self.textDidChange(textfield:)), for: UIControl.Event.editingChanged)
        fifthDigitTextField.addTarget(self, action: #selector(self.textDidChange(textfield:)), for: UIControl.Event.editingChanged)
        
        confirmButton.buttonSetupForConfirm()
    }
    
    private func textFieldSetup() {
        let borderColor = R.color.borderColorBlue()
        firstDigitTextField.layer.borderColor = borderColor?.cgColor
        secondDigitTextField.layer.borderColor = borderColor?.cgColor
        thirdDigitTextField.layer.borderColor = borderColor?.cgColor
        fourthDigitTextField.layer.borderColor = borderColor?.cgColor
        fifthDigitTextField.layer.borderColor = borderColor?.cgColor
        
        firstDigitTextField.layer.borderWidth = 1
        secondDigitTextField.layer.borderWidth = 1
        thirdDigitTextField.layer.borderWidth = 1
        fourthDigitTextField.layer.borderWidth = 1
        fifthDigitTextField.layer.borderWidth = 1
    }
    
    private func configureNotificationObservers() {
        firstDigitTextField.addTarget(self, action: #selector(textAdded), for: .editingChanged)
        secondDigitTextField.addTarget(self, action: #selector(textAdded), for: .editingChanged)
        thirdDigitTextField.addTarget(self, action: #selector(textAdded), for: .editingChanged)
        fourthDigitTextField.addTarget(self, action: #selector(textAdded), for: .editingChanged)
        fifthDigitTextField.addTarget(self, action: #selector(textAdded), for: .editingChanged)
    }
    
    @objc
    private func textAdded(sender: UITextField) {
        if sender == firstDigitTextField {
            viewModel.firstDigit = sender.text
        }
        else if sender == secondDigitTextField {
            viewModel.secondDigit = sender.text
        }
        else if sender == thirdDigitTextField {
            viewModel.thirdDigit = sender.text
        }
        else if sender == fourthDigitTextField {
            viewModel.fourthDigit = sender.text
        }
        else {
            viewModel.fifthDigit = sender.text
        }
        updateForm()
    }
    
    @objc
    private func backImageTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UIImageView) != nil {
            performSegue(withIdentifier: R.string.localizable.goBackToForgotPass(), sender: self)
        }
    }
}

// MARK: FormViewModel

extension VerificationCodeViewController: FormViewModel {
    func updateForm() {
        confirmButton.backgroundColor = viewModel.buttonBackgroundColor
        confirmButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        confirmButton.isEnabled = viewModel.formIsValid
    }
}
