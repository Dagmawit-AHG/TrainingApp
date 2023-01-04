//
//  SettingsViewController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 03/01/2023.
//

import Foundation
import FirebaseAuth
import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet var darkModeToggleButton: UIButton!
    @IBOutlet var notificationsToggleButton: UIButton!
    @IBOutlet var languageRectangle: UIImageView!
    @IBOutlet var darkModeRectangle: UIImageView!
    @IBOutlet var notificationsRectangle: UIImageView!
    @IBOutlet var bigRectangle: UIImageView!
    @IBOutlet var flightUpdatesLabel: UILabel!
    @IBOutlet var executiveProgramLabel: UILabel!
    @IBOutlet var discountDealsLabel: UILabel!
    @IBOutlet var flightUpdatesToggle: UIButton!
    @IBOutlet var executiveProgramToggle: UIButton!
    @IBOutlet var discountDealsToggle: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func darkModeTogglePressed(_ sender: UIButton) {
        if darkModeToggleButton.currentBackgroundImage == UIImage(named: "button"){
            darkModeToggleButton.setBackgroundImage(UIImage(named: "button_on"), for: .normal)
            self.overrideUserInterfaceStyle = .dark
            languageRectangle.image = UIImage(named: "Rectangle_white")
            darkModeRectangle.image = UIImage(named: "Rectangle_white")
            notificationsRectangle.image = UIImage(named: "Rectangle_white")
        }
        else {
            darkModeToggleButton.setBackgroundImage(UIImage(named: "button"), for: .normal)
            self.overrideUserInterfaceStyle = .light
            languageRectangle.image = UIImage(named: "Rectangle")
            darkModeRectangle.image = UIImage(named: "Rectangle")
            notificationsRectangle.image = UIImage(named: "Rectangle")
        }
    }
    
    @IBAction func notificationsTogglePressed(_ sender: UIButton) {
        if notificationsToggleButton.currentBackgroundImage == UIImage(named: "button"){
            notificationsToggleButton.setBackgroundImage(UIImage(named: "button_on"), for: .normal)
            notificationsRectangle.isHidden = true
            bigRectangle.isHidden = false
            bigRectangle.image = UIImage(named: "Rectangle_big")
            flightUpdatesLabel.isHidden = false
            flightUpdatesToggle.isHidden = false
            executiveProgramLabel.isHidden = false
            executiveProgramToggle.isHidden = false
            discountDealsLabel.isHidden = false
            discountDealsToggle.isHidden = false
        }
        else {
            notificationsToggleButton.setBackgroundImage(UIImage(named: "button"), for: .normal)
            notificationsRectangle.isHidden = false
            bigRectangle.isHidden = true
            flightUpdatesLabel.isHidden = true
            flightUpdatesToggle.isHidden = true
            executiveProgramLabel.isHidden = true
            executiveProgramToggle.isHidden = true
            discountDealsLabel.isHidden = true
            discountDealsToggle.isHidden = true
        }
    }
    
    
    @IBAction private func signOutPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            print("DEBUG: Successfully signed out user.")
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    
    // MARK: - Helpers
    
}
