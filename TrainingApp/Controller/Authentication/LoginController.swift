//
//  LoginController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 29/11/2022.
//

import UIKit

class LoginController: UIViewController {
    //implementation
    
//    private let backgroundImage: UIImageView = {
//        let bg = UIImageView()
//        bg.image = UIImage(imageLiteralResourceName: "Start")
//
//        return bg
//    }()
//
//    private let welcomeLabel: UILabel = {
//        let lb = UILabel()
//        lb.text = "Welcome back!"
//        lb.font = lb.font.withSize(20)
//        lb.setDimensions(height: 24, width: 289)
//        lb.textAlignment = .center
//        return lb
//    }()
//
//    private let emailTextField: CustomTextField = {
//        let tf = CustomTextField(placeholder: "Email")
//        tf.keyboardType = .emailAddress
//        return tf
//    }()
//
//    private let passwordTextField: CustomTextField = {
//        let tf = CustomTextField(placeholder: "Password")
//        tf.isSecureTextEntry = true
//        return tf
//    }()
//
//    private let rememberMeCheckbox: Checkbox = {
//        let rc = Checkbox()
//        rc.layer.cornerRadius = 3
//        return rc
//    }()
//
//    private let signInButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Sign In", for: .normal)
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.backgroundColor = UIColor(red: 0, green: 0, blue: 10, alpha: 1)
////        button.titleColor(for: UIControl.State)
//        button.layer.cornerRadius = 7
//        button.setHeight(50)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//        return button
//    }()
//
//    private let dontHaveAnAccountLabel: UILabel = {
//        let lb = UILabel()
//        lb.text = "Don't have an account?"
//        lb.font = lb.font.withSize(18)
//        lb.setDimensions(height: 22, width: 289)
//        lb.textAlignment = .center
//        return lb
//    }()
//
//    private let createAccountButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Create Account", for: .normal)
//        button.setTitleColor(UIColor(red: 0, green: 0, blue: 10, alpha: 1), for: .normal)
//        button.backgroundColor = UIColor.clear
////        button.titleColor(for: UIControl.State)
//        button.layer.cornerRadius = 7
//        button.setHeight(50)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
//        return button
//    }()
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.setBorder()
        passwordTextField.setBorder()
        
        signInButton.layer.cornerRadius = 5
        
//        let bottomLine = CALayer()
//
//        bottomLine.frame = CGRect(x: 0, y: emailTextField.frame.height-2, width: emailTextField.frame.width, height: 2)
        
//        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
//        bottomLine.backgroundColor = UIColor.systemGray4.cgColor
//        
//        emailTextField.borderStyle = .none
//
//        emailTextField.layer.addSublayer(bottomLine)
//
//        passwordTextField.borderStyle = .none
        
//        passwordTextField.layer.addSublayer(bottomLine)
//        view.addSubview(backgroundImage)
//        configureUI()
        
    }
    
    func configureUI(){
//        print("in configureUI")
        
//        definesPresentationContext = true
        
//        view.backgroundColor = .white
//        navigationController?.navigationBar.isHidden = true
//        navigationController?.navigationBar.barStyle = .black
//
//        let gradient = CAGradientLayer()
//
//        let colorOne = UIColor(red: 139, green: 201, blue: 255, alpha: 1).cgColor
//        let colorTwo = UIColor(red: 277, green: 224, blue: 254, alpha: 1).cgColor
//
//        print(colorOne)
        
//        gradient.colors = [UIColor.systemCyan.cgColor, UIColor.systemPink.cgColor, UIColor.white.cgColor]
//        gradient.locations = [0,1]
//        view.layer.addSublayer(gradient)
//        gradient.frame = view.frame
//
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        
        
////        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.spacing = 20
////
//
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 80, paddingLeft: 32, paddingRight: 32)
//        view.addSubview(backgroundImage)
        
    }
//    @IBAction
    
//    if self.createAccountButton.isTouchInside == true {
//        createAccountButtonPressed()
//    }
    
//    func createAccountButtonPressed() {
//        let registrationVC = RegistrationController()
//        self.present(registrationVC, animated: true, completion: nil)
    }
//}
