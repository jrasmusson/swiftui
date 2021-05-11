//
//  ViewController.swift
//  CombineDemo
//
//  Created by jrasmusson on 2021-05-10.
//

import UIKit
import SwiftUI

final class ViewController: UIViewController {
    
    let stackView = UIStackView()
    
    let nameTextField = TextFieldView(symbolName: "person.circle", placeholderText: "Wizard name")
    let passwordTextField = TextFieldView(symbolName: "lock.circle", placeholderText: "Password")
    let repeatTextField = TextFieldView(symbolName: "lock.circle", placeholderText: "Repeat password")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

extension ViewController {
    
    func setup() {
        nameTextField.delegate = self
        passwordTextField.delegate = self
        repeatTextField.delegate = self
    }
    
    func style() {
        title = "Wizard School Signup"
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
    }
    
    func layout() {
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(repeatTextField)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

extension ViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}

@available(iOS 13.0, *)
struct ViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ViewController()
                .navigationBarTitle(Text("Wizard School Signup"), displayMode: .inline)
                .preferredColorScheme(.dark)
        }
    }
}
#endif

// MARK: - TextFieldViewDelegate

extension ViewController: TextFieldViewDelegate {
    func didEnterText(_ sender: TextFieldView, _ text: String?) {
        if sender == nameTextField {
            print("Name text entered: \(text)")
        }
        if sender == passwordTextField {
            print("Password text entered: \(text)")
        }

    }
    
    func didEndEditing(_ sender: TextFieldView, _ text: String?) {
        
    }
}
