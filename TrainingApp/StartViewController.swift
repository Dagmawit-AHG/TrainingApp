//
//  ViewController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 29/11/2022.
//

import UIKit

class StartViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet private var signInButton: UIButton!
    
    @IBOutlet private var signUpButton: UIButton!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Actions
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        let loginVC = LoginViewController()
        
        self.present(loginVC, animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        let registrationVC = RegistrationViewController()
        
        self.present(registrationVC, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowLoginPageSegue" {
            guard let destinationVC = segue.destination as? LoginViewController else { return }
            present(destinationVC, animated: true, completion: nil)
            
        }
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        signInButton.layer.cornerRadius = 5
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = UIColor(red: 0.56, green: 0.8, blue: 1.0, alpha: 1.0).cgColor
        signUpButton.layer.cornerRadius = 5
    }

}

