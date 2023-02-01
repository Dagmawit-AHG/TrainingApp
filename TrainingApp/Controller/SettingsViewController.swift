//
//  SettingsViewController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 03/01/2023.
//

import FirebaseAuth
import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private var backButton: UIImageView!
    @IBOutlet private var languagesButton: UIImageView!
    @IBOutlet private var darkModeSwitch: UISwitch!
    @IBOutlet private var notificationsSwitch: UISwitch!
    @IBOutlet private var languageRectangle: UIImageView!
    @IBOutlet private var darkModeRectangle: UIImageView!
    @IBOutlet private var notificationsRectangle: UIImageView!
    @IBOutlet private var bigRectangle: UIImageView!
    @IBOutlet private var flightUpdatesLabel: UILabel!
    @IBOutlet private var executiveProgramLabel: UILabel!
    @IBOutlet private var discountDealsLabel: UILabel!
    @IBOutlet private var flightUpdatesSwitch: UISwitch!
    @IBOutlet private var executiveProgramSwitch: UISwitch!
    @IBOutlet private var discountDealsSwitch: UISwitch!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTapGestureForViews()
        
        darkModeSwitch.setOnValueChangeListener {
            if self.darkModeSwitch.isOn {
                self.darkModeIsOn()
            }
            else {
                self.darkModeIsOff()
            }
        }
        notificationsSwitch.setOnValueChangeListener {
            if self.notificationsSwitch.isOn {
                self.notificationIsOn()
            }
            else {
                self.notificationIsOff()
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func signOutPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: R.string.localizable.signOutSegue(), sender: self)
        }
        catch let signOutError as NSError {
            print(signOutError.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.string.localizable.signOutSegue() {
            guard let destinationVC = segue.destination as? StartViewController else { return }
            
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
        else if segue.identifier == R.string.localizable.backToHomepageSegue() {
            guard let destinationVC = segue.destination as? HomeViewController else { return }
            
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
        else if segue.identifier == R.string.localizable.showLanguagesPage() {
            guard let destinationVC = segue.destination as? LanguageViewController else { return }
            
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers
    
    private func setupTapGestureForViews() {
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.backImageTapped(gesture:)))
        backButton.addGestureRecognizer(backTapGesture)
        backButton.isUserInteractionEnabled = true
        
        let languagesTapGesture = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.LanguagesImageTapped(gesture:)))
        languagesButton.addGestureRecognizer(languagesTapGesture)
        languagesButton.isUserInteractionEnabled = true
    }
    
    @objc
    private func backImageTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UIImageView) != nil {
            performSegue(withIdentifier: R.string.localizable.backToHomepageSegue(), sender: self)
        }
    }
    
    @objc
    private func LanguagesImageTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UIImageView) != nil {
            performSegue(withIdentifier: R.string.localizable.showLanguagesPage(), sender: self)
        }
    }
    
    private func darkModeIsOn() {
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
        languageRectangle.image = R.image.rectangle_white()
        darkModeRectangle.image = R.image.rectangle_white()
        notificationsRectangle.image = R.image.rectangle_white()
    }
    
    private func darkModeIsOff() {
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
        languageRectangle.image = R.image.rectangle()
        darkModeRectangle.image = R.image.rectangle()
        notificationsRectangle.image = R.image.rectangle()
    }
    
    private func notificationIsOn() {
        notificationsRectangle.isHidden = true
        bigRectangle.isHidden = false
        bigRectangle.image = R.image.rectangle_big()
        flightUpdatesLabel.isHidden = false
        flightUpdatesSwitch.isHidden = false
        executiveProgramLabel.isHidden = false
        executiveProgramSwitch.isHidden = false
        discountDealsLabel.isHidden = false
        discountDealsSwitch.isHidden = false
    }
    
    private func notificationIsOff() {
        notificationsRectangle.isHidden = false
        bigRectangle.isHidden = true
        flightUpdatesLabel.isHidden = true
        flightUpdatesSwitch.isHidden = true
        executiveProgramLabel.isHidden = true
        executiveProgramSwitch.isHidden = true
        discountDealsLabel.isHidden = true
        discountDealsSwitch.isHidden = true
    }
}
