//
//  ViewController.swift
//  TCDemo
//
//  Created by jrasmusson on 2021-05-12.
//

import UIKit
import SwiftUI

final class ViewController: UIViewController {

    let termsLabel = UILabel()
    let privacyLabel = UILabel()
    
    let termsSwitch = UISwitch()
    let privacySwitch = UISwitch()
    
    let nameField = UITextField()
    let submitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

extension ViewController {
    func setup() {
        title = "Terms of Use"
    }
    
    func style() {
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        termsLabel.text = "I accept the terms and conditions"
        
        termsSwitch.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func layout() {
        view.addSubview(termsLabel)
        view.addSubview(termsSwitch)
        
        NSLayoutConstraint.activate([
            termsLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            termsLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            termsSwitch.centerYAnchor.constraint(equalTo: termsLabel.centerYAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: termsSwitch.trailingAnchor, multiplier: 1)
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
            .navigationBarTitle(Text("Navigation Title"), displayMode: .inline)
    }
  }
}
#endif
