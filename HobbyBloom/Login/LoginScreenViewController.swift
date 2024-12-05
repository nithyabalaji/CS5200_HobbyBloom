//
//  LoginScreenViewController.swift
//  HobbyBloom
//
//  Created by Bhumi Shah on 12/2/24.
//

import UIKit
import FirebaseAuth

class LoginScreenViewController: UIViewController {
    
    let loginScreen = LoginScreenView()
    
    override func loadView() {
        view = loginScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        loginScreen.loginButton.addTarget(self, action: #selector(onButtonLoginTapped), for: .touchUpInside)
        loginScreen.registerButton.addTarget(self, action: #selector(onButtonRegisterTapped), for: .touchUpInside)
    }
    
    @objc func onButtonLoginTapped() {
        let emailInput = loginScreen.emailTextField.text
        let passwordInput = loginScreen.passwordTextField.text
        
        if let email = emailInput, let password = passwordInput {
            if !email.isEmpty, !password.isEmpty {
                loginScreen.errorLabel.text = ""
                login(email: email, password: password)
            } else {
                loginScreen.errorLabel.text = "Email and password should be filled out before logging in."
            }
        }
    }

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let self = self else { return }
            
            if let error = error {
                self.loginScreen.errorLabel.text = "Incorrect email or password. \(error.localizedDescription)"
            } else {
                self.dismiss(animated: true)
            }
        }
    }
    
    @objc func onButtonRegisterTapped() {
        print("Register button tapped")
        let registerController = RegisterScreenViewController()
        navigationController?.pushViewController(registerController, animated: true)
    }


    @objc func hideKeyboardOnTap() {
        view.endEditing(true)
    }
}


