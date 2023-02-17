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
    
    private let userDefaults = UserDefaults.standard
    
    @IBOutlet private var backButton: UIImageView!
    @IBOutlet private var languagesButton: UIImageView!
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
        setupTapGestureForViews()
    }
    
    // MARK: - Actions
    
    @IBAction private func darkModeTogglePressed(_ sender: UIButton) {
        if darkModeToggleButton.currentImage == R.image.button() {
            darkModeIsOn()
        }
        else {
            darkModeIsOff()
        }
    }
    
    @IBAction private func notificationsTogglePressed(_ sender: UIButton) {
        if notificationsToggleButton.currentImage == R.image.button() {
            notificationIsOn()
        }
        else {
            notificationIsOff()
        }
    }
    
    @IBAction private func flightUpdatesTogglePressed(_ sender: UIButton) {
        if flightUpdatesToggle.currentImage == R.image.button() {
            flightUpdatesIsOn()
        }
        else {
            flightUpdatesIsOff()
        }
    }
    
    @IBAction private func executiveProgramTogglePressed(_ sender: UIButton) {
        if executiveProgramToggle.currentImage == R.image.button() {
            executiveProgramIsOn()
        }
        else {
            executiveProgramIsOff()
        }
    }
    
    @IBAction private func discountDealsTogglePressed(_ sender: UIButton) {
        if discountDealsToggle.currentImage == R.image.button() {
            discountIsOn()
        }
        else {
            discountIsOff()
        }
    }
    
    @IBAction private func signOutPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            self.userDefaults.set(false, forKey: R.string.localizable.userStatus())
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
    
    private func initialButtonsSetup() {
        darkModeToggleButton.setTitle(R.string.localizable.empty(), for: .normal)
        notificationsToggleButton.setTitle(R.string.localizable.empty(), for: .normal)
        flightUpdatesToggle.setTitle(R.string.localizable.empty(), for: .normal)
        executiveProgramToggle.setTitle(R.string.localizable.empty(), for: .normal)
        discountDealsToggle.setTitle(R.string.localizable.empty(), for: .normal)
    }
    
    private func darkModeIsOn() {
        darkModeToggleButton.setImage(R.image.button_on(), for: .normal)
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
        languageRectangle.image = R.image.rectangle_white()
        darkModeRectangle.image = R.image.rectangle_white()
        notificationsRectangle.image = R.image.rectangle_white()
    }
    
    private func darkModeIsOff() {
        darkModeToggleButton.setImage(R.image.button(), for: .normal)
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
        languageRectangle.image = R.image.rectangle()
        darkModeRectangle.image = R.image.rectangle()
        notificationsRectangle.image = R.image.rectangle()
    }
    
    private func notificationIsOn() {
        notificationsToggleButton.setImage(R.image.button_on(), for: .normal)
        notificationsRectangle.isHidden = true
        bigRectangle.isHidden = false
        bigRectangle.image = R.image.rectangle_big()
        flightUpdatesLabel.isHidden = false
        flightUpdatesToggle.isHidden = false
        executiveProgramLabel.isHidden = false
        executiveProgramToggle.isHidden = false
        discountDealsLabel.isHidden = false
        discountDealsToggle.isHidden = false
    }
    
    private func notificationIsOff() {
        notificationsToggleButton.setImage(R.image.button(), for: .normal)
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
        flightUpdatesToggle.setImage(R.image.button_on(), for: .normal)
    }
    
    private func flightUpdatesIsOff() {
        flightUpdatesToggle.setImage(R.image.button(), for: .normal)
    }
    
    private func executiveProgramIsOn() {
        executiveProgramToggle.setImage(R.image.button_on(), for: .normal)
    }
    
    private func executiveProgramIsOff() {
        executiveProgramToggle.setImage(R.image.button(), for: .normal)
    }
    
    private func discountIsOn() {
        discountDealsToggle.setImage(R.image.button_on(), for: .normal)
    }
    
    private func discountIsOff() {
        discountDealsToggle.setImage(R.image.button(), for: .normal)
    }
}
