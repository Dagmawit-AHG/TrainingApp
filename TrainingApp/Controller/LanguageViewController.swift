//
//  LanguageViewController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 06/01/2023.
//

import UIKit

final class LanguageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    var languages: KeyValuePairs = [
        NSAttributedString(string: R.string.localizable.empty()): NSAttributedString(string: R.string.localizable.empty())
    ]
    
    var suggestedLanguages: [String: String] = [ R.string.localizable.englishUS(): R.string.localizable.default(),
        R.string.localizable.polish(): R.string.localizable.polish(),
        R.string.localizable.englishUK(): R.string.localizable.englishUK()
    ]
    
    @IBOutlet private var backButton: UIImageView!
    @IBOutlet private var languageLabel: UILabel!
    @IBOutlet private var settingsButton: UIImageView!
    @IBOutlet private var suggestedLangLabel: UILabel!
    @IBOutlet private var englishUSLabel: UILabel!
    @IBOutlet private var defaultLabel: UILabel!
    @IBOutlet private var polishLabel: UILabel!
    @IBOutlet private var polishSmallLabel: UILabel!
    @IBOutlet private var englishUKLabel: UILabel!
    @IBOutlet private var englishUKSmallLabel: UILabel!
    @IBOutlet private var englishUSCheck: UIImageView!
    @IBOutlet private var englishCheck: UIImageView!
    @IBOutlet private var englishUKCheck: UIImageView!
    @IBOutlet private var longTextLabel: UILabel!
    @IBOutlet private var otherLangLabel: UILabel!
    @IBOutlet private var suggestedLanguagesTableView: UITableView!
    @IBOutlet private var languagesTableView: UITableView!
    
    let userDefaults = UserDefaults.standard
    
    private let SUGGESTED_LANGUAGE_KEY = R.string.localizable.suggestedLanguageKey()
    private let SELECTED_TABLE_KEY = "selectedTableKey"
    private let LAST_SELECTION_KEY = R.string.localizable.lastSelection()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTapGestureForViews()
        configureUI()
        
        languagesTableView.dataSource = self
        languagesTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        languagesTableView.backgroundColor = R.color.tableView_background()
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        checkLanguage()
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: R.string.localizable.languageCell(), for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: R.string.localizable.languageCell())
        let checkmark = userDefaults.integer(forKey: LAST_SELECTION_KEY)
        let selectedTableKey = userDefaults.string(forKey: SELECTED_TABLE_KEY)
        
        if selectedTableKey == "OtherLanguages" {
            if checkmark == indexPath.row {
                cell?.accessoryType = .checkmark
            }
            else {
                cell?.accessoryType = .none
            }
            englishUSCheck.isHidden = true
            englishCheck.isHidden = true
            englishUKCheck.isHidden = true
        }
        else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        if indexPath.row > languages.count - 1 {
            return UITableViewCell()
        }
        
        let label = (languages[indexPath.row].key).string
        let detail = (languages[indexPath.row].value).string
        
        cell?.textLabel?.text = label
        cell?.detailTextLabel?.text = detail
        cell?.textLabel?.font.withSize(18.0)
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for row in 0..<tableView.numberOfRows(inSection: indexPath.section) {
            if let cell = tableView.cellForRow(at: IndexPath(row: row, section: indexPath.section)) {
                cell.accessoryType = row == indexPath.row ? .checkmark : .none
                userDefaults.set(indexPath.row, forKey: LAST_SELECTION_KEY)
                userDefaults.set(nil, forKey: SUGGESTED_LANGUAGE_KEY)
                userDefaults.set("OtherLanguages", forKey: SELECTED_TABLE_KEY)
            }
        }
        
        let currentCell = tableView.cellForRow(at: indexPath)
        let language = currentCell?.textLabel?.text
        
        checkLanguage(language: language!)
        initializeArray()
        
        tableView.deselectRow(at: indexPath, animated: true)
        englishUSCheck.isHidden = true
        englishCheck.isHidden = true
        englishUKCheck.isHidden = true
    }
    
    // MARK: - Helpers
    
    private func checkLanguage() {
        if let language = userDefaults.string(forKey: "Language") {
            UserDefaults.standard.set(language, forKey: "Language")
            Bundle.setLanguage(language)
        }
    }
    
    private func initializeArray() {
        checkLanguage()
        
        languages = [
            NSAttributedString(string: R.string.localizable.dansk()): NSAttributedString(string: R.string.localizable.danish()),
            NSAttributedString(string: R.string.localizable.netherlands()): NSAttributedString(string: R.string.localizable.dutch()),
            NSAttributedString(string: R.string.localizable.englishCanada()): NSAttributedString(string: R.string.localizable.englishCanada()),
            NSAttributedString(string: R.string.localizable.englishAustralia()): NSAttributedString(string: R.string.localizable.englishAustralia()),
            NSAttributedString(string: R.string.localizable.englishUnitedStates()): NSAttributedString(string: R.string.localizable.englishUnitedStates()),
            NSAttributedString(string: R.string.localizable.italy()): NSAttributedString(string: R.string.localizable.italian())]
    }
    
    private func setupTapGestureForViews() {
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
        checkLanguage()
        checkLabels()
        initializeArray()
        languagesTableView.backgroundColor = R.color.tableView_background()
        
        if let selectedTable = userDefaults.string(forKey: SELECTED_TABLE_KEY) {
            if selectedTable == "SuggestedLanguages" {
                let suggestedLanguage = userDefaults.integer(forKey: SUGGESTED_LANGUAGE_KEY)
                checkSuggestedLanguage(index: suggestedLanguage)
            }
            else {
                let selectedLanguage = userDefaults.integer(forKey: LAST_SELECTION_KEY)
                checkLanguage(language: (languages[selectedLanguage].key).string)
            }
        }
    }
    
    private func checkLabels() {
        languageLabel.labelSetupForLanguage()
        suggestedLangLabel.labelSetupForSuggested()
        englishUSLabel.labelSetupForEnglishUS()
        polishLabel.labelSetupForPolish()
        englishUKLabel.labelSetupForEnglishUK()
        longTextLabel.labelSetupForLongText()
        otherLangLabel.labelSetupForOtherLang()
        defaultLabel.labelSetupForDefault()
        polishSmallLabel.labelSetupForPolish()
        englishUKSmallLabel.labelSetupForEnglishUK()
    }
    
    private func checkSuggestedLanguage(index: Int) {
        switch index {
        case 0:
            Bundle.setLanguage("en")
            UserDefaults.standard.set("en", forKey: "Language")
            englishUSCheck.isHidden = false
            englishCheck.isHidden = true
            englishUKCheck.isHidden = true
            checkLabels()
        case 1:
            Bundle.setLanguage("pl")
            UserDefaults.standard.set("pl", forKey: "Language")
            englishUSCheck.isHidden = true
            englishCheck.isHidden = false
            englishUKCheck.isHidden = true
            checkLabels()
        case 2:
            Bundle.setLanguage("en")
            UserDefaults.standard.set("en", forKey: "Language")
            englishUSCheck.isHidden = true
            englishCheck.isHidden = true
            englishUKCheck.isHidden = false
            checkLabels()
        default:
            Bundle.setLanguage("en")
            UserDefaults.standard.set("en", forKey: "Language")
            englishUSCheck.isHidden = true
            englishCheck.isHidden = true
            englishUKCheck.isHidden = true
        }
    }
    
    private func checkLanguage(language: String) {
        switch language {
        case R.string.localizable.dansk():
            Bundle.setLanguage("da")
            UserDefaults.standard.set("da", forKey: "Language")
            checkLabels()
            initializeArray()
            languagesTableView.reloadData()
        case R.string.localizable.netherlands():
            Bundle.setLanguage("nl")
            UserDefaults.standard.set("nl", forKey: "Language")
            checkLabels()
            initializeArray()
            languagesTableView.reloadData()
        case R.string.localizable.englishCanada():
            Bundle.setLanguage("en")
            UserDefaults.standard.set("en", forKey: "Language")
            checkLabels()
            initializeArray()
            languagesTableView.reloadData()
        case R.string.localizable.englishAustralia():
            Bundle.setLanguage("en")
            UserDefaults.standard.set("en", forKey: "Language")
            checkLabels()
            initializeArray()
            languagesTableView.reloadData()
        case R.string.localizable.englishUnitedStates():
            Bundle.setLanguage("en")
            UserDefaults.standard.set("en", forKey: "Language")
            checkLabels()
            initializeArray()
            languagesTableView.reloadData()
        case R.string.localizable.italy():
            Bundle.setLanguage("it")
            UserDefaults.standard.set("it", forKey: "Language")
            checkLabels()
            initializeArray()
            languagesTableView.reloadData()
        default:
            Bundle.setLanguage("en")
            UserDefaults.standard.set("en", forKey: "Language")
            checkLabels()
            initializeArray()
            languagesTableView.reloadData()
        }
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
            UserDefaults.standard.set("en", forKey: "Language")
            userDefaults.set("SuggestedLanguages", forKey: SELECTED_TABLE_KEY)
            userDefaults.set(0, forKey: SUGGESTED_LANGUAGE_KEY)
            userDefaults.set(nil, forKey: LAST_SELECTION_KEY)
            checkLabels()
            initializeArray()
            languagesTableView.reloadData()
        }
    }
    
    @objc
    private func polishTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UILabel) != nil {
            englishUSCheck.isHidden = true
            englishCheck.isHidden = false
            englishUKCheck.isHidden = true
            Bundle.setLanguage("pl")
            UserDefaults.standard.set("pl", forKey: "Language")
            userDefaults.set("SuggestedLanguages", forKey: SELECTED_TABLE_KEY)
            userDefaults.set(1, forKey: SUGGESTED_LANGUAGE_KEY)
            userDefaults.set(nil, forKey: LAST_SELECTION_KEY)
            checkLabels()
            initializeArray()
            languagesTableView.reloadData()
        }
    }
    
    @objc
    private func englishUKTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UILabel) != nil {
            englishUSCheck.isHidden = true
            englishCheck.isHidden = true
            englishUKCheck.isHidden = false
            Bundle.setLanguage("en")
            UserDefaults.standard.set("en", forKey: "Language")
            userDefaults.set("SuggestedLanguages", forKey: SELECTED_TABLE_KEY)
            userDefaults.set(2, forKey: SUGGESTED_LANGUAGE_KEY)
            userDefaults.set(nil, forKey: LAST_SELECTION_KEY)
            checkLabels()
            initializeArray()
            languagesTableView.reloadData()
        }
    }
}
