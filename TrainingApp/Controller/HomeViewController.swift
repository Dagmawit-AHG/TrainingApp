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
    
    private var viewModel = HomeViewModel()
    private let userDefaults = UserDefaults.standard
    
    @IBOutlet private var helloLabel: UILabel!
    @IBOutlet private var planLabel: UILabel!
    @IBOutlet private var fromLabelRound: UILabel!
    @IBOutlet private var toLabelRound: UILabel!
    @IBOutlet private var departureLabel: UILabel!
    @IBOutlet private var returnLabelRound: UILabel!
    @IBOutlet private var fromLabelOne: UILabel!
    @IBOutlet private var toLabelOne: UILabel!
    @IBOutlet private var departureLabelOne: UILabel!
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
    @IBOutlet private var searchFlightButton: UIButton!
    @IBOutlet private var spinner: UIActivityIndicatorView!
    
    private var citiesArray = [UITextField]()
    private let pickerView = ToolbarPickerView()
    
    private var selectedCity: String?
    
    private var cities: [String] = []
    
    private let url = "https://autocomplete.travelpayouts.com/places2?locale=en&term=a#"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        checkLanguage()
        configureUI()
        textFieldSetup()
        configureNotificationObservers()
        setupDelegatesForTextFields()
        setupDelegateForPickerView()
        dismissPickerView()
        checkIfUserIsLoggedIn()
        setupTapGestureForViews()
        
        getData(from: url)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkLanguage()
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
    
    private func getData(from url: String) {
            let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
                
                guard let data = data, error == nil else {
                    print("Something went wrong")
                    return
                }
                
                var result: [Field]?
                do {
                    result = try JSONDecoder().decode([Field].self, from: data)
                    print(result!)
                }
                catch {
                    print(String(describing: error))
                }
                
                guard let json = result else {
                    return
                }
                
                for i in json {
                    self.cities.append(i.name)
                }
                print(self.cities)
            })
            task.resume()
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
    
    @IBAction func searchFlightClicked(_ sender: UIButton) {
        activateSpinner()
        RunLoop.current.run(until: NSDate(timeIntervalSinceNow: 5) as Date)
        spinner.stopAnimating()
        spinner.isHidden = true
        
        let alert = UIAlertController(title: R.string.localizable.success(), message: "Flight Info", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.oK(), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
    
    private func checkLanguage() {
        if let language = userDefaults.string(forKey: "Language") {
            UserDefaults.standard.set(language, forKey: "Language")
            Bundle.setLanguage(language)
        }
    }
    
    private func configureUI() {
        helloLabel.labelSetupForHello()
        planLabel.labelSetupForPlan()
        fromLabelRound.labelSetupForFrom()
        fromLabelOne.labelSetupForFrom()
        toLabelRound.labelSetupForTo()
        toLabelOne.labelSetupForTo()
        departureLabel.labelSetupForDeparture()
        returnLabelRound.labelSetupForReturn()
        departureLabelOne.labelSetupForDeparture()
        optionsSegment?.addUnderlineForSelectedSegment()
        optionsSegment?.setFontSize()
        
        let roundTitle = NSAttributedString(string: R.string.localizable.roundTrip(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        let onewayTitle = NSAttributedString(string: R.string.localizable.oneWay(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        
        optionsSegment.setTitle(roundTitle.string, forSegmentAt: 0)
        optionsSegment.setTitle(onewayTitle.string, forSegmentAt: 1)
        
        searchFlightButton.buttonSetupForSearchFlight()
        spinner.isHidden = true
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
    
    private func configureNotificationObservers() {
        fromTextFieldRound.addTarget(self, action: #selector(textDidChange), for: .allEvents)
        toTextFieldRound.addTarget(self, action: #selector(textDidChange), for: .allEvents)
        fromTextFieldOne.addTarget(self, action: #selector(textDidChange), for: .allEvents)
        toTextField.addTarget(self, action: #selector(textDidChange), for: .allEvents)
    }
    
    @objc
    private func textDidChange(sender: UITextField) {
        if sender == fromTextFieldRound {
            viewModel.fromTextField = sender.text
        } else if sender == toTextFieldRound {
            viewModel.toTextField = sender.text
        } else if sender == fromTextFieldOne {
            viewModel.fromTextField = sender.text
        } else {
            viewModel.toTextField = sender.text
        }
        updateForm()
    }
    
    private func setupTapGestureForViews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapped(gesture:)))
        settingsButton?.addGestureRecognizer(tapGesture)
        settingsButton?.isUserInteractionEnabled = true
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
    
    private func activateSpinner() {
        spinner.isHidden = false
        spinner.startAnimating()
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

extension HomeViewController: FormViewModel {
    func updateForm() {
        searchFlightButton.backgroundColor = viewModel.buttonBackgroundColor
        searchFlightButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        searchFlightButton.isEnabled = viewModel.formIsValid
    }
}

extension HomeViewController: UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension HomeViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        for city in citiesArray {
            if city.isFirstResponder {
                city.text = self.cities[row]
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
