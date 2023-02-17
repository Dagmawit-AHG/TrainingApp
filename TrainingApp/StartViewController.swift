//
//  ViewController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 29/11/2022.
//

import UIKit

class StartViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet private var signInButton: UIButton!
    @IBOutlet private var signUpButton: UIButton!
    
    let userDefaults = UserDefaults.standard
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        configureUI()
        
        if let language = userDefaults.string(forKey: "Language") {
            Bundle.setLanguage(language)
            UserDefaults.standard.set(language, forKey: "Language")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let language = userDefaults.string(forKey: "Language") {
            Bundle.setLanguage(language)
            UserDefaults.standard.set(language, forKey: "Language")
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func signInButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowLoginPageSegue", sender: self)
    }

    @IBAction private func signUpButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowRegistrationPageSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowLoginPageSegue" {
            guard let destinationVC = segue.destination as? LoginViewController else { return }
            
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.isNavigationBarHidden = false
            destinationVC.navigationController?.navigationBar.backgroundColor = .clear
            present(destinationVC, animated: true, completion: nil)
        }
        
        else if segue.identifier == "ShowRegistrationPageSegue" {
            guard let destinationVC = segue.destination as? RegistrationViewController else { return }
            
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        signInButton.setTitle(R.string.localizable.signIn(), for: .normal)
        signInButton.layer.cornerRadius = 5
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = UIColor(red: 0.56, green: 0.8, blue: 1.0, alpha: 1.0).cgColor
        signUpButton.layer.cornerRadius = 5
    }
}
