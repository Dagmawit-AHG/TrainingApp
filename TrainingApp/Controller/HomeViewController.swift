//
//  HomeController.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 08/12/2022.
//

import Foundation
import iOSDropDown
import UIKit

// #import "iOSDropDown/iOSDropDown.swift>";

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private var fromTextField: UITextField!
    @IBOutlet private var fromDropDown: DropDown!
    
    @IBOutlet private var roundTripView: UIView!
    @IBOutlet private var oneWayTripView: UIView!
    
    @IBOutlet private var fromPickerView: UIPickerView!
    @IBOutlet private var optionsSegment: UISegmentedControl!
    
    var selectedCity: String?
    var listOfCities = ["Frankfurt","Addis Ababa","Heathrow","Wroclow","Hong Kong","New Delhi","Frankfurt","Addis Ababa","Heathrow","Wroclow","Hong Kong","New Delhi"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPickerView()
        self.dismissPickerView()
        configureUI()
    }
    
    // MARK: - Actions
    
    @IBAction func segmentedControlDidChange(_ sender: UISegmentedControl) {
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
    
    // MARK: - Helpers
    
    func configureUI() {
        optionsSegment.addUnderlineForSelectedSegment()
        optionsSegment.setFontSize()
    }
    
    func setupPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.layer.position = .init(x: 33, y: 102)
        self.fromTextField.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissAction))
        toolbar.setItems([button], animated: true)
        toolbar.isUserInteractionEnabled = true
        self.fromTextField.inputAccessoryView = toolbar
    }
    
    @objc func dismissAction() {
        self.view.endEditing(true)
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
    //        <#code#>
    //    }
}
