//
//  CodeViewController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 12/01/2023.
//

import Foundation
import UIKit

class CodeViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    private var viewModel = CodeViewModel()
    
    @IBOutlet var backButton: UIImageView!
    @IBOutlet private var firstDigitTextField: UITextField!
    @IBOutlet private var secondDigitTextField: UITextField!
    @IBOutlet private var thirdDigitTextField: UITextField!
    @IBOutlet private var fourthDigitTextField: UITextField!
    @IBOutlet private var fifthDigitTextField: UITextField!
    @IBOutlet var confirmButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        textFieldSetup()
        configureUI()
        configureNotificationObservers()
        
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(CodeViewController.backImageTapped(gesture:)))
        backButton.addGestureRecognizer(backTapGesture)
        backButton.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstDigitTextField.becomeFirstResponder()
    }
    
    // MARK: - Actions
    
    @IBAction private func confirmPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToNewPassword", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goBackToForgotPass" {
            guard let destinationVC = segue.destination as? ForgotPasswordViewController else { return }
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
        else if segue.identifier == "goToNewPassword" {
            guard let destinationVC = segue.destination as? NewPasswordViewController else { return }
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers
    
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
    
    private func configureUI(){
        firstDigitTextField.addTarget(self, action: #selector(self.textDidChange(textfield:)), for: UIControl.Event.editingChanged)
        secondDigitTextField.addTarget(self, action: #selector(self.textDidChange(textfield:)), for: UIControl.Event.editingChanged)
        thirdDigitTextField.addTarget(self, action: #selector(self.textDidChange(textfield:)), for: UIControl.Event.editingChanged)
        fourthDigitTextField.addTarget(self, action: #selector(self.textDidChange(textfield:)), for: UIControl.Event.editingChanged)
        fifthDigitTextField.addTarget(self, action: #selector(self.textDidChange(textfield:)), for: UIControl.Event.editingChanged)
        
        confirmButton.buttonSetupForConfirm()
    }
    
    private func textFieldSetup() {
        let borderColor : UIColor = UIColor( red: 0.0, green: 0.6, blue: 1.0, alpha: 1.0 )
        firstDigitTextField.layer.borderColor = borderColor.cgColor
        secondDigitTextField.layer.borderColor = borderColor.cgColor
        thirdDigitTextField.layer.borderColor = borderColor.cgColor
        fourthDigitTextField.layer.borderColor = borderColor.cgColor
        fifthDigitTextField.layer.borderColor = borderColor.cgColor
        
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
            performSegue(withIdentifier: "goBackToForgotPass", sender: self)
        }
    }
}

// MARK: FormViewModel

extension CodeViewController: FormViewModel {
    func updateForm() {
        confirmButton.backgroundColor = viewModel.buttonBackgroundColor
        confirmButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        confirmButton.isEnabled = viewModel.formIsValid
    }
}
