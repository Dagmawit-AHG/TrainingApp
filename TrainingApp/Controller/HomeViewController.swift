//
//  HomeController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 08/12/2022.
//

import FirebaseAuth
import iOSDropDown
import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private var fromTextField: UITextField!
//    @IBOutlet private var fromDropDown: DropDown!
    @IBOutlet private var roundTripView: UIView!
    @IBOutlet private var oneWayTripView: UIView!
    @IBOutlet private var fromPickerView: UIPickerView!
    @IBOutlet private var optionsSegment: UISegmentedControl!
    @IBOutlet private var settingsButton: UIImageView!
    
    private var selectedCity: String?
    private var listOfCities = ["Frankfurt","Addis Ababa","Heathrow","Wroclow","Hong Kong","New Delhi","Frankfurt","Addis Ababa","Heathrow","Wroclow","Hong Kong","New Delhi"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        configureUI()
        setupPickerView()
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
        performSegue(withIdentifier: "showSettingsPage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSettingsPage" {
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
    
    private func setupTapGestureForViews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapped(gesture:)))
        settingsButton.addGestureRecognizer(tapGesture)
        settingsButton.isUserInteractionEnabled = true
    }
    
    private func setupPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.layer.position = .init(x: 33, y: 102)
        self.fromTextField.inputView = pickerView
    }
    
    private func dismissPickerView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissAction))
        toolbar.setItems([button], animated: true)
        toolbar.isUserInteractionEnabled = true
        self.fromTextField.inputAccessoryView = toolbar
    }
    
    @objc
    private func dismissAction() {
        self.view.endEditing(true)
    }
    
    @objc
    private func imageTapped(gesture: UIGestureRecognizer) {
        if(gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            performSegue(withIdentifier: "showSettingsPage", sender: self)
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
        self.selectedCity = self.listOfCities[row]
        self.fromTextField.text = self.selectedCity
    }
}

extension HomeViewController: UITextFieldDelegate {
    //    func textFieldDidBeginEditing(_ textField: UITextField) {
    //
    //    }
}
