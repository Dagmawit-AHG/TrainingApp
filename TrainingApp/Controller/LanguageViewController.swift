//
//  LanguageViewController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 06/01/2023.
//

import UIKit

final class LanguageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    var languages: [String: String] = ["Dansk": "Danish",
                                       "Netherlands": "Dutch",
                                       "English(Canada)": "English(Canada)",
                                       "English(Australia)": "English(Australia)",
                                       "English(United States)": "English(United States)",
                                       "Italy": "Italian"]
    
    var lang: [String] = ["Dansk", "Netherlands", "English(Canada)", "English(Australia)", "English(United States)", "Italy"]
    
    @IBOutlet private var backButton: UIImageView!
    @IBOutlet private var settingsButton: UIImageView!
    @IBOutlet private var englishUSLabel: UILabel!
    @IBOutlet private var englishLabel: UILabel!
    @IBOutlet private var englishUKLabel: UILabel!
    @IBOutlet private var englishUSCheck: UIImageView!
    @IBOutlet private var englishCheck: UIImageView!
    @IBOutlet private var englishUKCheck: UIImageView!
    @IBOutlet private var languagesTableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languagesTableView.dataSource = self
        languagesTableView.delegate = self
        
        setupTapGestureForViews()
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languagesTableView.backgroundView = UIImageView(image: R.image.rectangle_all())
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row > languages.count - 1 {
            return UITableViewCell()
        }
        else {
            languagesTableView.backgroundView = UIImageView(image: R.image.rectangle_all())
            let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath)
            cell.textLabel?.text = Array(languages.keys)[indexPath.row]
            cell.textLabel?.font.withSize(18.0)
            print(Array(languages.keys)[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for row in 0..<tableView.numberOfRows(inSection: indexPath.section) {
            if let cell = tableView.cellForRow(at: IndexPath(row: row, section: indexPath.section)) {
                cell.accessoryType = row == indexPath.row ? .checkmark : .none
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Helpers
    
    private func setupTapGestureForViews() {
        languagesTableView.backgroundColor = UIColor(red: 139, green: 201, blue: 255, alpha: 0.2)
        languagesTableView.backgroundView = UIImageView(image: R.image.rectangle_all())
        
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
