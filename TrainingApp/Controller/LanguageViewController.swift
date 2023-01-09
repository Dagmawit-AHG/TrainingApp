//
//  LanguageViewController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 06/01/2023.
//

import Foundation
import UIKit

class LanguageViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private var backButton: UIImageView!
    @IBOutlet private var settingsButton: UIImageView!
    @IBOutlet private var englishUSLabel: UILabel!
    @IBOutlet private var englishLabel: UILabel!
    @IBOutlet var englishUKLabel: UILabel!
    @IBOutlet var englishUSCheck: UIImageView!
    @IBOutlet var englishCheck: UIImageView!
    @IBOutlet var englishUKCheck: UIImageView!
    @IBOutlet private var languagesTableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languagesTableView.backgroundView = UIImageView(image: UIImage(named: "Rectangle_all"))
        
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(LanguageViewController.backImageTapped(gesture:)))
        backButton.addGestureRecognizer(backTapGesture)
        backButton.isUserInteractionEnabled = true
        
        let settingsTapGesture = UITapGestureRecognizer(target: self, action: #selector(LanguageViewController.settingsImageTapped(gesture:)))
        settingsButton.addGestureRecognizer(settingsTapGesture)
        settingsButton.isUserInteractionEnabled = true
        
        let englishUSTapGesture = UITapGestureRecognizer(target: self, action: #selector(LanguageViewController.englishUSTapped(gesture:)))
        englishUSLabel.addGestureRecognizer(englishUSTapGesture)
        englishUSLabel.isUserInteractionEnabled = true
        
        let englishTapGesture = UITapGestureRecognizer(target: self, action: #selector(LanguageViewController.englishTapped(gesture:)))
        englishLabel.addGestureRecognizer(englishTapGesture)
        englishLabel.isUserInteractionEnabled = true
        
        let englishUKTapGesture = UITapGestureRecognizer(target: self, action: #selector(LanguageViewController.englishUKTapped(gesture:)))
        englishUKLabel.addGestureRecognizer(englishUKTapGesture)
        englishUKLabel.isUserInteractionEnabled = true
    }
    
    // MARK: - Actions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToSettingsSegue" {
            guard let destinationVC = segue.destination as? SettingsViewController else { return }
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers
    
    @objc
    private func backImageTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UIImageView) != nil {
            performSegue(withIdentifier: "backToSettingsSegue", sender: self)
        }
    }
    
    @objc
    private func settingsImageTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UIImageView) != nil {
            performSegue(withIdentifier: "backToSettingsSegue", sender: self)
        }
    }
    
    @objc
    private func englishUSTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UILabel) != nil {
            englishUSCheck.isHidden = false
            englishCheck.isHidden = true
            englishUKCheck.isHidden = true
        }
    }
    
    @objc
    private func englishTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UILabel) != nil {
            englishUSCheck.isHidden = true
            englishCheck.isHidden = false
            englishUKCheck.isHidden = true
        }
    }
    
    @objc
    private func englishUKTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UILabel) != nil {
            englishUSCheck.isHidden = true
            englishCheck.isHidden = true
            englishUKCheck.isHidden = false
        }
    }
}
