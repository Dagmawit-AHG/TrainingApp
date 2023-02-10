//
//  HomeController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 08/12/2022.
//

import FirebaseAuth
import iOSDropDown
import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private var fromTextFieldRound: UITextField!
    @IBOutlet private var toTextFieldRound: UITextField!
    @IBOutlet private var fromTextFieldOne: UITextField!
    @IBOutlet private var toTextField: UITextField!
    @IBOutlet private var roundTripView: UIView!
    @IBOutlet private var oneWayTripView: UIView!
    @IBOutlet private var optionsSegment: UISegmentedControl!
    @IBOutlet private var settingsButton: UIImageView!
    @IBOutlet private var departureTextField: UITextField!
    @IBOutlet private var returnTextField: UITextField!
    @IBOutlet private var departureTextFieldOne: UITextField!
    
    private var citiesArray = [UITextField]()
    private let pickerView = ToolbarPickerView()
    
    private var selectedCity: String?
    private var listOfCities = [R.string.localizable.frankfurt(), R.string.localizable.addisAbaba(), R.string.localizable.heathrow(), R.string.localizable.wroclaw(), R.string.localizable.hongKong(), R.string.localizable.newDelhi(), R.string.localizable.frankfurt(), R.string.localizable.addisAbaba(), R.string.localizable.heathrow(), R.string.localizable.wroclaw(), R.string.localizable.hongKong(), R.string.localizable.newDelhi()]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        configureUI()
        textFieldSetup()
        setupDelegatesForTextFields()
        setupDelegateForPickerView()
        dismissPickerView()
        checkIfUserIsLoggedIn()
        setupTapGestureForViews()
    }
    
    // MARK: - API
    
    private func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginViewController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func segmentedControlDidChange(_ sender: UISegmentedControl) {
        optionsSegment.changeUnderlinePosition()
        
        switch optionsSegment.selectedSegmentIndex {
        case 0:
            oneWayTripView.isHidden = true
            roundTripView.isHidden = false
        case 1:
            roundTripView.isHidden = true
            oneWayTripView.isHidden = false
        default:
            break
        }
    }
    
    @IBAction private func settingsClicked(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: R.string.localizable.showSettingsPage(), sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.string.localizable.showSettingsPage() {
            guard let destinationVC = segue.destination as? SettingsViewController else { return }
            
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.navigationController?.setNavigationBarHidden(false, animated: true)
            present(destinationVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        optionsSegment.addUnderlineForSelectedSegment()
        optionsSegment.setFontSize()
    }
    
    private func textFieldSetup() {
        let borderColor = R.color.borderColorBlue()
        fromTextFieldRound.layer.borderColor = borderColor?.cgColor
        toTextFieldRound.layer.borderColor = borderColor?.cgColor
        fromTextFieldOne.layer.borderColor = borderColor?.cgColor
        toTextField.layer.borderColor = borderColor?.cgColor
        departureTextField.layer.borderColor = borderColor?.cgColor
        returnTextField.layer.borderColor = borderColor?.cgColor
        departureTextFieldOne.layer.borderColor = borderColor?.cgColor
        
        fromTextFieldRound.layer.borderWidth = 1
        toTextFieldRound.layer.borderWidth = 1
        fromTextFieldOne.layer.borderWidth = 1
        toTextField.layer.borderWidth = 1
        departureTextField.layer.borderWidth = 1
        returnTextField.layer.borderWidth = 1
        departureTextFieldOne.layer.borderWidth = 1
    }
    
    private func setupTapGestureForViews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapped(gesture:)))
        settingsButton.addGestureRecognizer(tapGesture)
        settingsButton.isUserInteractionEnabled = true
    }
    
    private func setupDelegatesForTextFields() {
        citiesArray += [fromTextFieldRound, toTextFieldRound, fromTextFieldOne, toTextField]
        
        for city in citiesArray {
            city.delegate = self
            city.inputView = pickerView
            city.inputAccessoryView = pickerView.toolbar
        }
    }
    
    private func setupDelegateForPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.toolbarDelegate = self
        pickerView.layer.position = .init(x: 33, y: 102)
    }
    
    private func dismissPickerView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let button = UIBarButtonItem(title: R.string.localizable.done(), style: .plain, target: self, action: #selector(self.dismissAction))
        toolbar.setItems([button], animated: true)
        toolbar.isUserInteractionEnabled = true
        self.fromTextFieldRound.inputAccessoryView = toolbar
        self.fromTextFieldOne.inputAccessoryView = toolbar
        self.toTextFieldRound.inputAccessoryView = toolbar
        self.toTextField.inputAccessoryView = toolbar
    }
    
    @objc
    private func dismissAction() {
        self.view.endEditing(true)
    }
    
    @objc
    private func imageTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UIImageView) != nil {
            performSegue(withIdentifier: R.string.localizable.showSettingsPage(), sender: self)
        }
    }
}

// MARK: - Extension

extension HomeViewController: UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension HomeViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.listOfCities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.listOfCities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        for city in citiesArray {
            if city.isFirstResponder {
                city.text = self.listOfCities[row]
            }
        }
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.reloadAllComponents()
    }
}

extension HomeViewController: ToolbarPickerViewDelegate {
    func didTapDone() {
        self.view.endEditing(true)
    }
    
    func didTapCancel() {
        self.view.endEditing(true)
    }
    
    
}
