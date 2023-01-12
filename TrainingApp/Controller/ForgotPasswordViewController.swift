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
    
    @IBOutlet private var backButton: UIImageView!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var confirmButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        configureUI()
    }
    
    // MARK: - Actions
    
    @IBAction private func confirmButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToCodeSegue", sender: self)
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
    }
}
