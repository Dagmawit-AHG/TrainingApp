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
    
    let userDefaults = UserDefaults.standard
    
    let ON_OFF_KEY_THEME = R.string.localizable.onOffKeyTheme()
    let THEME_KEY = R.string.localizable.themeKey()
    let DARK_THEME = R.string.localizable.darkTheme()
    let LIGHT_THEME = R.string.localizable.lightTheme()
    
    let ON_OFF_KEY_NOTIFICATION = R.string.localizable.onOffKeyNotfn()
    let NOTIFICATION_KEY = R.string.localizable.notfnKey()
    let NOTIFICATION_ON = R.string.localizable.notfnOn()
    let NOTIFICATION_OFF = R.string.localizable.notfnOff()
    
    let ON_OFF_KEY_FLIGHT = R.string.localizable.onOffKeyFlight()
    let FLIGHT_KEY = R.string.localizable.flightKey()
    let FLIGHT_ON = R.string.localizable.flightOn()
    let FLIGHT_OFF = R.string.localizable.flightOff()
    
    let ON_OFF_KEY_EXECUTIVE = R.string.localizable.onOffKeyExecutive()
    let EXECUTIVE_KEY = R.string.localizable.executiveKey()
    let EXECUTIVE_ON = R.string.localizable.executiveOn()
    let EXECUTIVE_OFF = R.string.localizable.executiveOff()
    
    let ON_OFF_KEY_DISCOUNT = R.string.localizable.onOffKeyDiscount()
    let DISCOUNT_KEY = R.string.localizable.discountKey()
    let DISCOUNT_ON = R.string.localizable.discountOn()
    let DISCOUNT_OFF = R.string.localizable.discountOff()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTapGestureForViews()
        setupSwitchListeners()
        checkThemeSwitchState()
        checkNotificationSwitchState()
        updateTheme()
        updateNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.darkModeSwitch.isOn {
            self.darkModeIsOn()
        } else {
            self.darkModeIsOff()
        }
    }
    
    // MARK: - Actions
    
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
        } else if segue.identifier == R.string.localizable.backToHomepageSegue() {
            guard let destinationVC = segue.destination as? HomeViewController else { return }
            
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        } else if segue.identifier == R.string.localizable.showLanguagesPage() {
            guard let destinationVC = segue.destination as? LanguageViewController else { return }
            
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers
    
    private func setupSwitchListeners() {
        darkModeSwitch.setOnValueChangeListener {
            if self.darkModeSwitch.isOn {
                self.userDefaults.set(true, forKey: self.ON_OFF_KEY_THEME)
                self.userDefaults.set(self.DARK_THEME, forKey: self.THEME_KEY)
            }
            else {
                self.userDefaults.set(false, forKey: self.ON_OFF_KEY_THEME)
                self.userDefaults.set(self.LIGHT_THEME, forKey: self.THEME_KEY)
            }
            self.updateTheme()
        }
        
        notificationsSwitch.setOnValueChangeListener {
            if self.notificationsSwitch.isOn {
                self.userDefaults.set(true, forKey: self.ON_OFF_KEY_NOTIFICATION)
                self.userDefaults.set(self.NOTIFICATION_ON, forKey: self.NOTIFICATION_KEY)
            }
            else {
                self.userDefaults.set(false, forKey: self.ON_OFF_KEY_NOTIFICATION)
                self.userDefaults.set(self.NOTIFICATION_OFF, forKey: self.NOTIFICATION_KEY)
            }
            self.updateNotifications()
        }
        
        flightUpdatesSwitch.setOnValueChangeListener {
            if self.flightUpdatesSwitch.isOn {
                self.userDefaults.set(true, forKey: self.ON_OFF_KEY_FLIGHT)
                self.userDefaults.set(self.FLIGHT_ON, forKey: self.FLIGHT_KEY)
            }
            else {
                self.userDefaults.set(false, forKey: self.ON_OFF_KEY_FLIGHT)
                self.userDefaults.set(self.FLIGHT_OFF, forKey: self.FLIGHT_KEY)
            }
        }
        
        executiveProgramSwitch.setOnValueChangeListener {
            if self.executiveProgramSwitch.isOn {
                self.userDefaults.set(true, forKey: self.ON_OFF_KEY_EXECUTIVE)
                self.userDefaults.set(self.EXECUTIVE_ON, forKey: self.EXECUTIVE_KEY)
            }
            else {
                self.userDefaults.set(false, forKey: self.ON_OFF_KEY_EXECUTIVE)
                self.userDefaults.set(self.EXECUTIVE_OFF, forKey: self.EXECUTIVE_KEY)
            }
        }
        
        discountDealsSwitch.setOnValueChangeListener {
            if self.discountDealsSwitch.isOn {
                self.userDefaults.set(true, forKey: self.ON_OFF_KEY_DISCOUNT)
                self.userDefaults.set(self.DISCOUNT_ON, forKey: self.DISCOUNT_KEY)
            }
            else {
                self.userDefaults.set(false, forKey: self.ON_OFF_KEY_DISCOUNT)
                self.userDefaults.set(self.DISCOUNT_OFF, forKey: self.DISCOUNT_KEY)
            }
        }
    }
    
    private func checkThemeSwitchState() {
        if(userDefaults.bool(forKey: ON_OFF_KEY_THEME)) {
            darkModeSwitch.setOn(true, animated: false)
            self.userDefaults.set(self.DARK_THEME, forKey: self.THEME_KEY)
        } else {
            darkModeSwitch.setOn(false, animated: true)
            self.userDefaults.set(self.LIGHT_THEME, forKey: self.THEME_KEY)
        }
    }
    
    private func checkNotificationSwitchState() {
        if(userDefaults.bool(forKey: ON_OFF_KEY_NOTIFICATION)) {
            notificationsSwitch.setOn(true, animated: false)
            self.userDefaults.set(self.NOTIFICATION_ON, forKey: self.NOTIFICATION_KEY)
            checkFlightSwitchState()
            checkExecutiveSwitchState()
            checkDiscountSwitchState()
        } else {
            notificationsSwitch.setOn(false, animated: false)
            self.userDefaults.set(self.NOTIFICATION_OFF, forKey: self.NOTIFICATION_KEY)
            checkFlightSwitchState()
            checkExecutiveSwitchState()
            checkDiscountSwitchState()
        }
    }
    
    private func checkFlightSwitchState() {
        if(userDefaults.bool(forKey: ON_OFF_KEY_FLIGHT)) {
            flightUpdatesSwitch.setOn(true, animated: false)
            self.userDefaults.set(self.FLIGHT_ON, forKey: self.FLIGHT_KEY)
        } else {
            flightUpdatesSwitch.setOn(false, animated: false)
            self.userDefaults.set(self.FLIGHT_OFF, forKey: self.FLIGHT_KEY)
        }
    }
    
    private func checkExecutiveSwitchState() {
        if(userDefaults.bool(forKey: ON_OFF_KEY_EXECUTIVE)) {
            executiveProgramSwitch.setOn(true, animated: false)
            self.userDefaults.set(self.EXECUTIVE_ON, forKey: EXECUTIVE_KEY)
        } else {
            executiveProgramSwitch.setOn(false, animated: false)
            self.userDefaults.set(self.EXECUTIVE_OFF, forKey: EXECUTIVE_KEY)
        }
    }
    
    private func checkDiscountSwitchState() {
        if(userDefaults.bool(forKey: ON_OFF_KEY_DISCOUNT)) {
            discountDealsSwitch.setOn(true, animated: false)
            self.userDefaults.set(self.DISCOUNT_ON, forKey: DISCOUNT_KEY)
        } else {
            discountDealsSwitch.setOn(false, animated: false)
            self.userDefaults.set(self.DISCOUNT_OFF, forKey: DISCOUNT_KEY)
        }
    }
    
    private func updateTheme() {
        let theme = userDefaults.string(forKey: THEME_KEY)
        if (theme == LIGHT_THEME) {
            darkModeIsOff()
        } else if (theme == DARK_THEME) {
            darkModeIsOn()
        }
    }
    
    private func updateNotifications() {
        let notifications = userDefaults.string(forKey: NOTIFICATION_KEY)
        if (notifications == NOTIFICATION_ON) {
            notificationIsOn()
        } else if (notifications == NOTIFICATION_OFF) {
            notificationIsOff()
        }
    }
    
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
        bigRectangle.image = R.image.rectangle_big()
        setupShowingLabels(isHidden: false)
    }
    
    private func notificationIsOff() {
        notificationsRectangle.isHidden = false
        setupShowingLabels(isHidden: true)
    }
    
    private func setupShowingLabels(isHidden: Bool) {
        flightUpdatesLabel.isHidden = isHidden
        flightUpdatesSwitch.isHidden = isHidden
        executiveProgramLabel.isHidden = isHidden
        executiveProgramSwitch.isHidden = isHidden
        discountDealsLabel.isHidden = isHidden
        discountDealsSwitch.isHidden = isHidden
        bigRectangle.isHidden = isHidden
    }
    
}
