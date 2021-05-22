//
//  ViewController.swift
//  TermsAndConditions
//
//  Created by jrasmusson on 2021-05-21.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet var termsSwitch: UIStackView!
    @IBOutlet var privacySwitch: UISwitch!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var submitButton: UIButton!
    
    // Define publishers
    @Published private var acceptedTerms = false
    @Published private var acceptedPrivacy = false
    @Published private var name = ""
    
    private var stream: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        
        stream = validToSubmit
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: submitButton)
    }

    private var validToSubmit: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest3($acceptedTerms, $acceptedPrivacy, $name)
            .map { terms, privacy, name in
                print("foo - terms: \(terms) privacy: \(privacy) name: \(name)")
                return terms && privacy && !name.isEmpty
            }.eraseToAnyPublisher()
    }
    
    @IBAction func acceptTerms(_ sender: UISwitch) {
        acceptedTerms = sender.isOn
    }
    
    @IBAction func acceptPrivacy(_ sender: UISwitch) {
        acceptedPrivacy = sender.isOn
    }
    
    @IBAction func nameChanged(_ sender: UITextField) {
        name = sender.text ?? ""
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        print("foo - Submit: \(name)")
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

