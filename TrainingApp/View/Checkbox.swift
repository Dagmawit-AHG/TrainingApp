//
//  Checkbox.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 07/12/2022.
//

import UIKit

class Checkbox: UIView {

    private weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        imageView.image = UIImage(systemName: "checkmark.square.fill")
        imageView.setDimensions(height: 18, width: 18)
        imageView.contentMode = .scaleAspectFit
        
        self.imageView = imageView
        backgroundColor = UIColor.clear
    }
}
