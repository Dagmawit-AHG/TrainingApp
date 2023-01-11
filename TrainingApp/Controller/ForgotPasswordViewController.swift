//
//  ForgotPasswordViewController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 11/01/2023.
//

import Foundation
import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet var confirmButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        configureUI()
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
    private func configureUI() {
        emailTextField.setBorder()
        confirmButton.layer.cornerRadius = 5
    }
}
