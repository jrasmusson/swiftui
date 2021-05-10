//
//  TextFieldView.swift
//  CombineDemo
//
//  Created by jrasmusson on 2021-05-10.
//

import Foundation
import UIKit

class TextFieldView: UIView {
    
    let imageView = UIImageView()
    let textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension TextFieldView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let symbolImage = UIImage(systemName: "square.and.pencil", withConfiguration: configuration)
        imageView.image = symbolImage
        imageView.tintColor = .label
        
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Wizard name"
        textField.borderStyle = .roundedRect
    }
    
    func layout() {
        addSubview(imageView)
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: imageView.trailingAnchor, multiplier: 1),
        ])
        
        imageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }
}
