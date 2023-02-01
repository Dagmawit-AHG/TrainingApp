//
//  LanguageViewController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 06/01/2023.
//

import UIKit

final class LanguageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    var languages: [String: String] = [R.string.localizable.dansk(): R.string.localizable.danish(),
                                       R.string.localizable.netherlands(): R.string.localizable.dutch(),
                                       R.string.localizable.englishCanada(): R.string.localizable.englishCanada(),
                                       R.string.localizable.englishAustralia(): R.string.localizable.englishAustralia(),
                                       R.string.localizable.englishUnitedStates(): R.string.localizable.englishUnitedStates(),
                                       R.string.localizable.italy(): R.string.localizable.italian()]
    
    @IBOutlet private var backButton: UIImageView!
    @IBOutlet private var languageLabel: UILabel!
    @IBOutlet private var settingsButton: UIImageView!
    @IBOutlet private var suggestedLangLabel: UILabel!
    @IBOutlet private var englishUSLabel: UILabel!
    @IBOutlet private var polishLabel: UILabel!
    @IBOutlet private var englishUKLabel: UILabel!
    @IBOutlet private var englishUSCheck: UIImageView!
    @IBOutlet private var englishCheck: UIImageView!
    @IBOutlet private var englishUKCheck: UIImageView!
    @IBOutlet private var longTextLabel: UILabel!
    @IBOutlet private var otherLangLabel: UILabel!
    @IBOutlet private var languagesTableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languagesTableView.dataSource = self
        languagesTableView.delegate = self
        
        setupTapGestureForViews()
        configureUI()
    }
    
    // MARK: - Actions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.string.localizable.backToSettingsSegue() {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: R.string.localizable.languageCell(), for: indexPath)
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
        let currentCell = tableView.cellForRow(at: indexPath)
        let language = currentCell?.textLabel?.text
        switch language {
        case R.string.localizable.englishAustralia():
            Bundle.setLanguage("en")
            UserDefaults.standard.set("en", forKey: "Language")
            languageLabel.text = R.string.localizable.language().localizableString("en")
            suggestedLangLabel.text = R.string.localizable.suggestedLanguages().localizableString("en")
            englishUSLabel.text = R.string.localizable.englishUS().localizableString("en")
            polishLabel.text = R.string.localizable.polish().localizableString("en")
            englishUKLabel.text = R.string.localizable.englishUK().localizableString("en")
            longTextLabel.text = R.string.localizable.appWillUse().localizableString("en")
            otherLangLabel.text = R.string.localizable.otherLanguages().localizableString("en")
        case R.string.localizable.netherlands():
            Bundle.setLanguage("nl")
            UserDefaults.standard.set("nl", forKey: "Language")
            languageLabel.text = R.string.localizable.language().localizableString("nl")
            suggestedLangLabel.text = R.string.localizable.suggestedLanguages().localizableString("nl")
            englishUSLabel.text = R.string.localizable.englishUS().localizableString("nl")
            polishLabel.text = R.string.localizable.polish().localizableString("nl")
            englishUKLabel.text = R.string.localizable.englishUK().localizableString("nl")
            longTextLabel.text = R.string.localizable.appWillUse().localizableString("nl")
            otherLangLabel.text = R.string.localizable.otherLanguages().localizableString("nl")
        case R.string.localizable.englishCanada():
            Bundle.setLanguage("en")
            UserDefaults.standard.set("en", forKey: "Language")
            languageLabel.text = R.string.localizable.language().localizableString("en")
            suggestedLangLabel.text = R.string.localizable.suggestedLanguages().localizableString("en")
            englishUSLabel.text = R.string.localizable.englishUS().localizableString("en")
            polishLabel.text = R.string.localizable.polish().localizableString("en")
            englishUKLabel.text = R.string.localizable.englishUK().localizableString("en")
            longTextLabel.text = R.string.localizable.appWillUse().localizableString("en")
            otherLangLabel.text = R.string.localizable.otherLanguages().localizableString("en")
        case R.string.localizable.italy():
            Bundle.setLanguage("it")
            UserDefaults.standard.set("it",forKey: "Language")
            languageLabel.text = R.string.localizable.language().localizableString("it")
            suggestedLangLabel.text = R.string.localizable.suggestedLanguages().localizableString("it")
            englishUSLabel.text = R.string.localizable.englishUS().localizableString("it")
            polishLabel.text = R.string.localizable.polish().localizableString("it")
            englishUKLabel.text = R.string.localizable.englishUK().localizableString("it")
            longTextLabel.text = R.string.localizable.appWillUse().localizableString("it")
            otherLangLabel.text = R.string.localizable.otherLanguages().localizableString("it")
        case R.string.localizable.englishUnitedStates():
            Bundle.setLanguage("en")
            UserDefaults.standard.set("en", forKey: "Language")
            languageLabel.text = R.string.localizable.language().localizableString("en")
            suggestedLangLabel.text = R.string.localizable.suggestedLanguages().localizableString("en")
            englishUSLabel.text = R.string.localizable.englishUS().localizableString("en")
            polishLabel.text = R.string.localizable.polish().localizableString("en")
            englishUKLabel.text = R.string.localizable.englishUK().localizableString("en")
            longTextLabel.text = R.string.localizable.appWillUse().localizableString("en")
            otherLangLabel.text = R.string.localizable.otherLanguages().localizableString("en")
        case R.string.localizable.dansk():
            Bundle.setLanguage("da")
            UserDefaults.standard.set("da", forKey: "Language")
            languageLabel.text = R.string.localizable.language().localizableString("da")
            suggestedLangLabel.text = R.string.localizable.suggestedLanguages().localizableString("da")
            englishUSLabel.text = R.string.localizable.englishUS().localizableString("da")
            polishLabel.text = R.string.localizable.polish().localizableString("da")
            englishUKLabel.text = R.string.localizable.englishUK().localizableString("da")
            longTextLabel.text = R.string.localizable.appWillUse().localizableString("da")
            otherLangLabel.text = R.string.localizable.otherLanguages().localizableString("da")
        default:
            Bundle.setLanguage("en")
            UserDefaults.standard.set("en",forKey: "Language")
            languageLabel.text = R.string.localizable.language().localizableString("en")
            suggestedLangLabel.text = R.string.localizable.suggestedLanguages().localizableString("en")
            englishUSLabel.text = R.string.localizable.englishUS().localizableString("en")
            polishLabel.text = R.string.localizable.polish().localizableString("en")
            englishUKLabel.text = R.string.localizable.englishUK().localizableString("en")
            longTextLabel.text = R.string.localizable.appWillUse().localizableString("en")
            otherLangLabel.text = R.string.localizable.otherLanguages().localizableString("en")
        }
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
        
        let polishTapGesture = UITapGestureRecognizer(target: self, action: #selector(LanguageViewController.polishTapped(gesture:)))
        polishLabel.addGestureRecognizer(polishTapGesture)
        polishLabel.isUserInteractionEnabled = true
        
        let englishUKTapGesture = UITapGestureRecognizer(target: self, action: #selector(LanguageViewController.englishUKTapped(gesture:)))
        englishUKLabel.addGestureRecognizer(englishUKTapGesture)
        englishUKLabel.isUserInteractionEnabled = true
    }
    
    private func configureUI() {
        languagesTableView.backgroundColor = R.color.tableView_background()
    }
    
    @objc
    private func backImageTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UIImageView) != nil {
            performSegue(withIdentifier: R.string.localizable.backToSettingsSegue(), sender: self)
        }
    }
    
    @objc
    private func settingsImageTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UIImageView) != nil {
            performSegue(withIdentifier: R.string.localizable.backToSettingsSegue(), sender: self)
        }
    }
    
    @objc
    private func englishUSTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UILabel) != nil {
            englishUSCheck.isHidden = false
            englishCheck.isHidden = true
            englishUKCheck.isHidden = true
            Bundle.setLanguage("en")
            UserDefaults.standard.set("en",forKey: "Language")
            languageLabel.text = R.string.localizable.language().localizableString("en")
            suggestedLangLabel.text = R.string.localizable.suggestedLanguages().localizableString("en")
            englishUSLabel.text = R.string.localizable.englishUS().localizableString("en")
            polishLabel.text = R.string.localizable.polish().localizableString("en")
            englishUKLabel.text = R.string.localizable.englishUK().localizableString("en")
            longTextLabel.text = R.string.localizable.appWillUse().localizableString("en")
            otherLangLabel.text = R.string.localizable.otherLanguages().localizableString("en")
        }
    }
    
    @objc
    private func polishTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UILabel) != nil {
            englishUSCheck.isHidden = true
            englishCheck.isHidden = false
            englishUKCheck.isHidden = true
            Bundle.setLanguage("pl")
            UserDefaults.standard.set("pl",forKey: "Language")
            languageLabel.text = R.string.localizable.language().localizableString("pl")
            suggestedLangLabel.text = R.string.localizable.suggestedLanguages().localizableString("pl")
            englishUSLabel.text = R.string.localizable.englishUS().localizableString("pl")
            polishLabel.text = R.string.localizable.polish().localizableString("pl")
            englishUKLabel.text = R.string.localizable.englishUK().localizableString("pl")
            longTextLabel.text = R.string.localizable.appWillUse().localizableString("pl")
            otherLangLabel.text = R.string.localizable.otherLanguages().localizableString("pl")
        }
    }
    
    @objc
    private func englishUKTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UILabel) != nil {
            englishUSCheck.isHidden = true
            englishCheck.isHidden = true
            englishUKCheck.isHidden = false
            Bundle.setLanguage("en")
            UserDefaults.standard.set("en",forKey: "Language")
            languageLabel.text = R.string.localizable.language().localizableString("en")
            suggestedLangLabel.text = R.string.localizable.suggestedLanguages().localizableString("en")
            englishUSLabel.text = R.string.localizable.englishUS().localizableString("en")
            polishLabel.text = R.string.localizable.polish().localizableString("en")
            englishUKLabel.text = R.string.localizable.englishUK().localizableString("en")
            longTextLabel.text = R.string.localizable.appWillUse().localizableString("en")
            otherLangLabel.text = R.string.localizable.otherLanguages().localizableString("en")
        }
    }
}
