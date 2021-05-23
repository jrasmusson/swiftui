//
//  ViewController.swift
//  CombineDemo
//
//  Created by jrasmusson on 2021-05-10.
//

import UIKit
import SwiftUI
import Combine

final class ViewController: UIViewController {
    
    // Combine
    
    // Step 1: Create a publisher to compare passwords
    @Published var password = ""
    @Published var passwordAgain = ""
    
    // Define a publisher of type String? that takes the two passwords and combines them into one result that can never fail.
    var validatedPassword: AnyPublisher<String?, Never> {
        return Publishers.CombineLatest($password, $passwordAgain)
            .map { password, passwordRepeat in
                guard password == passwordRepeat, password.count > 0 else { return nil }
                return password
            }
            .map {
                ($0 ?? "") == "password1" ? nil : $0
            }
            .eraseToAnyPublisher()
    }
    
    // Step 2: Debounce rapidly typed username
   @Published var username: String = ""
    
    // Define a publisher for username that returns a String and can never fail.
    var validatedUsername: AnyPublisher<String?, Never> {
        return $username
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { username in
                
                // For making asynchronous calls create a `Future`.
                // A `Future` can take the value from our published stream and create a new publisher of type `Future`
                // When you construct a future you give it a closure that takes a promise.
                // A promise is just another closure, that takes the result. Success or failure.
                // To use it its pretty simple. You simply call your asynchronous function, pass the result into the promise.
                return Future { promise in
                    // (Result<Output, Failure>) -> Void
                    self.usernameAvailable(username) { available in
                        promise(.success(available ? username : nil))
                    }
                }
            }
            .eraseToAnyPublisher() // Let's you keep the original AnyPublisher<String?, Never> signature, and not have to return output of flatMap
    }
    
    func usernameAvailable(_ username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    // Step 3: Take these two publisher signals we have and use them to enable the create button if both pass
        
    var validatedCredentials: AnyPublisher<(String, String)?, Never> {
        return Publishers.CombineLatest(validatedUsername, validatedPassword)

            .receive(on: RunLoop.main) // <<—— run on main thread

            .map { validatedEMail, validatedPassword in
                print("validatedEMail: \(validatedEMail ?? "not set"), validatedPassword: \(validatedPassword ?? "not set")")

                guard let eMail = validatedEMail, let password = validatedPassword else { return nil }

                return (eMail, password)

        }
        .eraseToAnyPublisher()
        
//    var validatedCredentials: AnyPublisher<(String, String)?, Never> {
//
//        let validatedCredentials = Publishers.CombineLatest(validatedUsername, validatedPassword)
//            .map { (username, password) -> (String?, String?) in
//                print("1 \(username) \(password)")
//                return (username, password)
//            }
//            .map { (username, password) -> (String, String)? in
//                guard let uname = username, let pwd = password else { return nil }
//                print("2 \(uname) \(pwd)")
//                return (uname, pwd)
//            }
//            .eraseToAnyPublisher()
//
//
//        return validatedCredentials
                    
//        return Publishers.CombineLatest(validatedUsername, validatedPassword) { username, password in
//            guard let uname = username, let pwd = password else { return nil }
//            return (uname, pwd)
//        }
//        .eraseToAnyPublisher()
    }
    
    var createButtonStream: AnyCancellable?
    
    // UI elements
    let stackView = UIStackView()
    
    let nameTextField = TextFieldView(symbolName: "person.circle", placeholderText: "Wizard name")
    let passwordTextField = TextFieldView(symbolName: "lock.circle", placeholderText: "Password", isSecureTextEntry: true)
    let repeatTextField = TextFieldView(symbolName: "lock.circle", placeholderText: "Repeat password", isSecureTextEntry: true)
    let createButton = makeButton(withText: "Create Account")
        
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
        
//        createButton.isEnabled = false
        createButton.addTarget(self, action: #selector(createButtonTapped(_:)), for: .primaryActionTriggered)
        
        createButtonStream = validatedCredentials
            .map { $0 != nil }
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: createButton)

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
        stackView.addArrangedSubview(createButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        stackView.setCustomSpacing(32.0, after: repeatTextField)
    }
}

// MARK: - TextFieldViewDelegate

extension ViewController: TextFieldViewDelegate {
    func didEnterText(_ sender: TextFieldView, _ text: String?) {
        guard let text = text else { return }
        if sender == nameTextField {
            print("Name text entered: \(text)")
            username = text
        }
        if sender == passwordTextField {
            print("Password text entered: \(text)")
            password = text
        }
        if sender == repeatTextField {
            print("Repeat text entered: \(text)")
            passwordAgain = text
        }
    }
    
    func didEndEditing(_ sender: TextFieldView, _ text: String?) {
        
    }
}

func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 8
    return button
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

// MARK: - Actions

extension ViewController {
    
    @objc func createButtonTapped(_ sender: UIButton) {
        print("Create button tapped!")
    }
}
