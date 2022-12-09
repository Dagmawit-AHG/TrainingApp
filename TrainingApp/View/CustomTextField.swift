//
//  CustomTextField.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 01/12/2022.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: self.frame.height-2, width: self.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.systemGray4.cgColor
        
        self.borderStyle = .none
        
        self.layer.addSublayer(bottomLine)
        
//        borderStyle = .bezel
//        frame = CGRect(x: 0, y: self.frame.size.height - CGFloat(1.0), width:  self.frame.size.width, height: self.frame.size.height)
//        textColor = .black
//        keyboardType = .emailAddress
//        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been initialized")
    }
}
