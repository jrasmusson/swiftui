//
//  TextFieldView.swift
//  CombineDemo
//
//  Created by jrasmusson on 2021-05-10.
//

import Foundation
import UIKit

protocol TextFieldViewDelegate: AnyObject {
    func didEnterText(_ sender: TextFieldView, _ text: String?)
    func didEndEditing(_ sender: TextFieldView, _ text: String?)
}

class TextFieldView: UIView {
    
    let imageView = UIImageView()
    let textField = UITextField()
    
    weak var delegate: TextFieldViewDelegate?
    
    init(symbolName: String, placeholderText: String) {
        super.init(frame: .zero)
        
        setup()
        style(symbolName, placeholderText)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 44)
    }
}

extension TextFieldView {
    
    func setup() {
        textField.delegate = self
    }
    
    func style(_ symbolName: String, _ placeholderText: String) {
        translatesAutoresizingMaskIntoConstraints = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let symbolImage = UIImage(systemName: symbolName, withConfiguration: configuration)
        imageView.image = symbolImage
        imageView.tintColor = .label
        
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholderText
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

// MARK: - UITextFieldDelegate

extension TextFieldView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText = textField.text ?? ""
        let newText = (textFieldText as NSString).replacingCharacters(in: range, with: string)
        print(newText)
        delegate?.didEnterText(self, textField.text)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != nil {
            delegate?.didEndEditing(self, textField.text)
        }
        
        self.textField.text = ""
    }
}
