//
//  ViewController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 29/11/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.view.backgroundColor = UIColor(patternImage: (UIImage(named: "Start") ?? UIImage(named: ""))!)
//        navigationController?.navigationBar.isHidden = false
//        signInButton.backgroundColor = UIColor.clear
        signInButton.layer.cornerRadius = 5
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = UIColor(red: 0.56, green: 0.8, blue: 1.0, alpha: 1.0).cgColor
        signUpButton.layer.cornerRadius = 5
//        signInButton.layer.borderColor = UIColor(red: 142, green: 202, blue: 255, alpha: 1).cgColor
        
//        configureUI()
        
    }
    
    
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        let loginVC = LoginController()
        
        self.present(loginVC, animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        let registrationVC = RegistrationController()
        
        self.present(registrationVC, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowLoginPageSegue" {
            guard let destinationVC = segue.destination as? LoginController else { return }
            present(destinationVC, animated: true, completion: nil)
            
        }
    }
    
    func configureUI(){
        print("in configure ui")
//        view.backgroundColor = .white
//        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        let gradient = CAGradientLayer()
        let color1 = UIColor(red: 1.83, green: 1.26, blue: 1.0, alpha: 1).cgColor
        let color2 = UIColor(red: 1.12, green: 1.14, blue: 1.003, alpha: 1).cgColor
        gradient.colors = [color1, color2]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
    }

}

