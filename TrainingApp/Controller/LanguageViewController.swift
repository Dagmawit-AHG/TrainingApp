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
    
    @IBOutlet var backButton: UIImageView!
    @IBOutlet var settingsButton: UIImageView!
    @IBOutlet var languagesTableView: UITableView!
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
}
