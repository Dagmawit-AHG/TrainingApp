//
//  Extensions.swift
//  InstagramFirestoreTutorial
//
//  Created by Stephen Dowless on 6/19/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import JGProgressHUD
import UIKit

extension UIViewController {
    static let hud = JGProgressHUD(style: .dark)
    
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
    func showLoader(_ show: Bool) {
        view.endEditing(true)
        
        if show {
            UIViewController.hud.show(in: view)
        }
        else {
            UIViewController.hud.dismiss()
        }
    }
    
    func showMessage(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIButton {
    func attributedTitle(firstPart: String, secondPart: String) {
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "\(firstPart) ", attributes: atts)
        
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.boldSystemFont(ofSize: 16)]
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: boldAtts))
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
    
    func buttonSetupForSignIn() {
        let title = NSAttributedString(string: R.string.localizable.signIn(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.setAttributedTitle(title, for: .normal)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.56, green: 0.8, blue: 1.0, alpha: 1.0).cgColor
    }
    
    func buttonSetupForSignUp() {
        let title = NSAttributedString(string: R.string.localizable.signUp(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.setAttributedTitle(title, for: .normal)
    }
    
    func buttonSetupForLogin() {
        let title = NSAttributedString(string: R.string.localizable.signIn(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.setAttributedTitle(title, for: .normal)
        self.isEnabled = false
        self.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 0.5)
    }
    
    func buttonSetupForRegistration() {
        let title = NSAttributedString(string: R.string.localizable.createAccount(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.setAttributedTitle(title, for: .normal)
        self.isEnabled = false
        self.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 0.5)
    }
    
    func buttonSetupForConfirm() {
        let title = NSAttributedString(string: R.string.localizable.confirm(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.setAttributedTitle(title, for: .normal)
        self.isEnabled = false
        self.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 0.5)
    }
    
    func buttonSetupForNewPassword() {
        let title = NSAttributedString(string: R.string.localizable.setPassword(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.setAttributedTitle(title, for: .normal)
        self.isEnabled = false
        self.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 0.5)
    }
    
    func buttonSetupForSearchFlight() {
        let title = NSAttributedString(string: R.string.localizable.searchFlights(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.setAttributedTitle(title, for: .normal)
        self.isEnabled = false
        self.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 0.5)
    }
}

extension UILabel {
    func labelSetupForHello() {
        let title = NSAttributedString(string: R.string.localizable.hello(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.attributedText = title
    }
    
    func labelSetupForPlan() {
        let title = NSAttributedString(string: R.string.localizable.plan(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.attributedText = title
    }
    
    func labelSetupForFrom() {
        let title = NSAttributedString(string: R.string.localizable.from(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        self.attributedText = title
    }
    
    func labelSetupForTo() {
        let title = NSAttributedString(string: R.string.localizable.to(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        self.attributedText = title
    }
    
    func labelSetupForDeparture() {
        let title = NSAttributedString(string: R.string.localizable.departureDate(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        self.attributedText = title
    }
    
    func labelSetupForReturn() {
        let title = NSAttributedString(string: R.string.localizable.returnDate(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        self.attributedText = title
    }
    
    func labelSetupForLanguage() {
        let title = NSAttributedString(string: R.string.localizable.language(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        self.attributedText = title
    }
    
    func labelSetupForSuggested() {
        let title = NSAttributedString(string: R.string.localizable.suggestedLanguages(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        self.attributedText = title
    }
    
    func labelSetupForEnglishUS() {
        let title = NSAttributedString(string: R.string.localizable.englishUS(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.attributedText = title
    }
    
    func labelSetupForDefault() {
        let title = NSAttributedString(string: R.string.localizable.default(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.attributedText = title
    }
    
    func labelSetupForPolish() {
        let title = NSAttributedString(string: R.string.localizable.polish(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.attributedText = title
    }
    
    func labelSetupForEnglishUK() {
        let title = NSAttributedString(string: R.string.localizable.englishUK(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.attributedText = title
    }
    
    func labelSetupForLongText() {
        let title = NSAttributedString(string: R.string.localizable.appWillUse(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        self.attributedText = title
    }
    
    func labelSetupForOtherLang() {
        let title = NSAttributedString(string: R.string.localizable.otherLanguages(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        self.attributedText = title
    }
    
    func labelSetupForDansk() {
        let title = NSAttributedString(string: R.string.localizable.dansk(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        self.attributedText = title
    }
    
    func labelSetupForDanish() {
        let title = NSAttributedString(string: R.string.localizable.danish(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        self.attributedText = title
    }
    
    func labelSetupForNetherlands() {
        let title = NSAttributedString(string: R.string.localizable.netherlands(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        self.attributedText = title
    }
    
    func labelSetupForDutch() {
        let title = NSAttributedString(string: R.string.localizable.dutch(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        self.attributedText = title
    }
    
    func labelSetupForEnglishCanada() {
        let title = NSAttributedString(string: R.string.localizable.englishCanada(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        self.attributedText = title
    }
    
    func labelSetupForEnglishAustralia() {
        let title = NSAttributedString(string: R.string.localizable.englishAustralia(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        self.attributedText = title
    }
    
    func labelSetupForEnglishUnitedStates() {
        let title = NSAttributedString(string: R.string.localizable.englishUnitedStates(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        self.attributedText = title
    }
    
    func labelSetupForEnglishItaly() {
        let title = NSAttributedString(string: R.string.localizable.italy(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        self.attributedText = title
    }
    
    func labelSetupForItalian() {
        let title = NSAttributedString(string: R.string.localizable.italian(), attributes: [NSAttributedString.Key.foregroundColor: R.color.color()!])
        self.attributedText = title
    }
}

extension UITextField {
    func setBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 2)
        bottomLine.backgroundColor = R.color.formTextFieldColor()?.cgColor
        
        self.borderStyle = .none
        
        self.layer.addSublayer(bottomLine)
    }
    
    func setRedBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.systemRed.cgColor
        
        self.borderStyle = .none
        
        self.layer.addSublayer(bottomLine)
    }
    
    func setGreenBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.systemGreen.cgColor
        
        self.borderStyle = .none
        
        self.layer.addSublayer(bottomLine)
    }
}

extension UIImage {

    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}

extension UISegmentedControl {
    func setFontSize() {
        let font = UIFont.systemFont(ofSize: 16)
        self.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
    }
    func removeBorders() {
        let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor.clear.cgColor, andSize: self.bounds.size)
                self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
                self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
                self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)

                let dividerImage = UIImage.getColoredRectImageWith(color: UIColor.clear.cgColor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
                self.setDividerImage(dividerImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 67 / 255, green: 129 / 255, blue: 244 / 255, alpha: 1.0)], for: .selected)
    }
    
    func addUnderlineForSelectedSegment() {
            removeBorders()
            let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
            let underlineHeight: CGFloat = 2.0
            let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
            let underLineYPosition = self.bounds.size.height - 1.0
            let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
            let underline = UIView(frame: underlineFrame)
            underline.backgroundColor = UIColor(red: 67 / 255, green: 129 / 255, blue: 244 / 255, alpha: 1.0)
            underline.tag = 1
            self.addSubview(underline)
        }
    
    func changeUnderlinePosition() {
            guard let underline = self.viewWithTag(1) else {return}
        
            let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
            UIView.animate(withDuration: 0.1, animations: {
                underline.frame.origin.x = underlineFinalXPosition
            })
        }
    
    private func imageWithColor(color: UIColor) -> UIImage {
            let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
            UIGraphicsBeginImageContext(rect.size)
            let context = UIGraphicsGetCurrentContext()
            context!.setFillColor(color.cgColor)
            context!.fill(rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image!
        }
}
extension UISwitch {
    func setOnValueChangeListener(onValueChanged: @escaping () -> Void) {
        self.addAction(UIAction() { action in
            onValueChanged()
        }, for: .valueChanged)
    }
}
extension UIView {
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        paddingTop: CGFloat = 0,
        paddingLeft: CGFloat = 0,
        paddingBottom: CGFloat = 0,
        paddingRight: CGFloat = 0,
        width: CGFloat? = nil,
        height: CGFloat? = nil
        ) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let left = leftAnchor {
            anchor(left: left, paddingLeft: paddingLeft)
        }
    }
    
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        
        guard let view = superview else { return }
        
        anchor(top: view.topAnchor, left: view.leftAnchor,
               bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}

extension String {
    func localizableString(_ name: String) -> String {
        let path = Bundle.main.path(forResource: name, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

extension Bundle {
    class func setLanguage(_ language: String) {
        var onceToken: Int = 0
        
        if onceToken == 0 {
            object_setClass(Bundle.main, PrivateBundle.self)
        }
        onceToken = 1
        objc_setAssociatedObject(Bundle.main, &associatedLanguageBundle, (language != nil) ? Bundle(path: Bundle.main.path(forResource: language, ofType: "lproj") ?? "") : nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

private var associatedLanguageBundle: Character = "0"

class PrivateBundle: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        let bundle: Bundle? = objc_getAssociatedObject(self, &associatedLanguageBundle) as? Bundle
        return (bundle != nil) ?
                (bundle!.localizedString(forKey: key, value: value, table: tableName)) :
                (super.localizedString(forKey: key, value: value, table: tableName))
    }
}

extension UITableView {
    func deselectAllRows(animated: Bool) {
        guard let selectedRows = indexPathsForSelectedRows else { return }
        print(selectedRows)
        for indexPath in selectedRows {
            deselectRow(at: indexPath, animated: animated)
        }
    }
}
