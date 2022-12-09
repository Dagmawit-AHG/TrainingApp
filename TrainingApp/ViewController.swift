//
//  ViewController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 29/11/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.view.backgroundColor = UIColor(patternImage: (UIImage(named: "Start") ?? UIImage(named: ""))!)
        
        signInButton.backgroundColor = UIColor.clear
        signInButton.layer.cornerRadius = 5
        signInButton.layer.borderWidth = 3
        signInButton.layer.borderColor = UIColor(red: 142, green: 202, blue: 255, alpha: 1).cgColor
        
        configureUI()
        
    }
    
    
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        let loginVC = LoginController()
        
        self.present(loginVC, animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        let registrationVC = RegistrationController()
        
        self.present(registrationVC, animated: true, completion: nil)
    }
    
    func configureUI(){
        print("in configure ui")
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        let gradient = CAGradientLayer()
        let color1 = UIColor(red: 139, green: 201, blue: 255, alpha: 1).cgColor
        let color2 = UIColor(red: 227, green: 224, blue: 254, alpha: 1).cgColor
        gradient.colors = [UIColor.systemCyan.cgColor, UIColor.systemPink.cgColor, UIColor.white.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
    }

}

