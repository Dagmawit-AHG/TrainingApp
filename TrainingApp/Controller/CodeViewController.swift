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
    @IBOutlet private var firstDigitTextField: UITextField!
    @IBOutlet private var secondDigitTextField: UITextField!
    @IBOutlet private var thirdDigitTextField: UITextField!
    @IBOutlet private var fourthDigitTextField: UITextField!
    @IBOutlet private var fifthDigitTextField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        textFieldSetup()
        
        firstDigitTextField.addTarget(self, action: #selector(self.textDidChange(textfield:)), for: UIControl.Event.editingChanged)
        secondDigitTextField.addTarget(self, action: #selector(self.textDidChange(textfield:)), for: UIControl.Event.editingChanged)
        thirdDigitTextField.addTarget(self, action: #selector(self.textDidChange(textfield:)), for: UIControl.Event.editingChanged)
        fourthDigitTextField.addTarget(self, action: #selector(self.textDidChange(textfield:)), for: UIControl.Event.editingChanged)
        fifthDigitTextField.addTarget(self, action: #selector(self.textDidChange(textfield:)), for: UIControl.Event.editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstDigitTextField.becomeFirstResponder()
    }
    
    // MARK: - Actions
    
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
    // MARK: - Helpers
    
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
}
