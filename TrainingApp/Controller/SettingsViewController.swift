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

    @IBOutlet private var darkModeToggleButton: UIButton!
    @IBOutlet private var notificationsToggleButton: UIButton!
    @IBOutlet private var languageRectangle: UIImageView!
    @IBOutlet private var darkModeRectangle: UIImageView!
    @IBOutlet private var notificationsRectangle: UIImageView!
    @IBOutlet private var bigRectangle: UIImageView!
    @IBOutlet private var flightUpdatesLabel: UILabel!
    @IBOutlet private var executiveProgramLabel: UILabel!
    @IBOutlet private var discountDealsLabel: UILabel!
    @IBOutlet private var flightUpdatesToggle: UIButton!
    @IBOutlet private var executiveProgramToggle: UIButton!
    @IBOutlet private var discountDealsToggle: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialButtonsSetup()
    }
    
    // MARK: - Actions
    
    
    
    
    @IBAction private func darkModeTogglePressed(_ sender: UIButton) {
        if darkModeToggleButton.currentImage == UIImage(named: "button"){
            darkModeIsOn()
        }
        else {
            darkModeIsOff()
        }
    }
    
    @IBAction private func notificationsTogglePressed(_ sender: UIButton) {
        if notificationsToggleButton.currentImage == UIImage(named: "button") {
            notificationIsOn()
        }
        else {
            notificationIsOff()
        }
    }
    
    @IBAction private func flightUpdatesTogglePressed(_ sender: UIButton) {
        if flightUpdatesToggle.currentImage == UIImage(named: "button") {
            flightUpdatesIsOn()
        }
        else {
            flightUpdatesIsOff()
        }
    }
    
    @IBAction private func executiveProgramTogglePressed(_ sender: UIButton) {
        if executiveProgramToggle.currentImage == UIImage(named: "button") {
            executiveProgramIsOn()
        }
        else {
            executiveProgramIsOff()
        }
    }
    
    @IBAction private func discountDealsTogglePressed(_ sender: UIButton) {
        if discountDealsToggle.currentImage == UIImage(named: "button") {
            discountIsOn()
        }
        else {
            discountIsOff()
        }
    }
    
    @IBAction private func signOutPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            print("DEBUG: Successfully signed out user.")
            performSegue(withIdentifier: "signOutSegue", sender: self)
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signOutSegue" {
            guard let destinationVC = segue.destination as? StartViewController else { return }
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers
    
    private func initialButtonsSetup() {
        darkModeToggleButton.setTitle("", for: .normal)
        notificationsToggleButton.setTitle("", for: .normal)
        flightUpdatesToggle.setTitle("", for: .normal)
        executiveProgramToggle.setTitle("", for: .normal)
        discountDealsToggle.setTitle("", for: .normal)
    }
    
    private func darkModeIsOn() {
        darkModeToggleButton.setImage(UIImage(named: "button_on"), for: .normal)
        self.overrideUserInterfaceStyle = .dark
        languageRectangle.image = UIImage(named: "Rectangle_white")
        darkModeRectangle.image = UIImage(named: "Rectangle_white")
        notificationsRectangle.image = UIImage(named: "Rectangle_white")
    }
    
    private func darkModeIsOff() {
        darkModeToggleButton.setImage(UIImage(named: "button"), for: .normal)
        self.overrideUserInterfaceStyle = .light
        languageRectangle.image = UIImage(named: "Rectangle")
        darkModeRectangle.image = UIImage(named: "Rectangle")
        notificationsRectangle.image = UIImage(named: "Rectangle")
    }
    
    private func notificationIsOn() {
        notificationsToggleButton.setImage(UIImage(named: "button_on"), for: .normal)
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
    
    private func notificationIsOff() {
        notificationsToggleButton.setImage(UIImage(named: "button"), for: .normal)
        notificationsRectangle.isHidden = false
        bigRectangle.isHidden = true
        flightUpdatesLabel.isHidden = true
        flightUpdatesToggle.isHidden = true
        executiveProgramLabel.isHidden = true
        executiveProgramToggle.isHidden = true
        discountDealsLabel.isHidden = true
        discountDealsToggle.isHidden = true
    }
    
    private func flightUpdatesIsOn() {
        flightUpdatesToggle.setImage(UIImage(named: "button_on"), for: .normal)
    }
    
    private func flightUpdatesIsOff() {
        flightUpdatesToggle.setImage(UIImage(named: "button"), for: .normal)
    }
    
    private func executiveProgramIsOn() {
        executiveProgramToggle.setImage(UIImage(named: "button_on"), for: .normal)
    }
    
    private func executiveProgramIsOff() {
        executiveProgramToggle.setImage(UIImage(named: "button"), for: .normal)
    }
    
    private func discountIsOn() {
        discountDealsToggle.setImage(UIImage(named: "button_on"), for: .normal)
    }
    
    private func discountIsOff() {
        discountDealsToggle.setImage(UIImage(named: "button"), for: .normal)
    }
}
