////
////  LoginView.swift
////  HobbyBloom
////
////  Created by Bhumi Shah on 12/2/24.
////
//
//import UIKit
//
//class LoginScreenView: UIView {
//
//    var contentWrapper: UIScrollView!
//    var logoImageView: UIImageView!
//    var appNameLabel: UILabel!
//    var loginLabel: UILabel!
//    var emailTextField: UITextField!
//    var passwordTextField: UITextField!
//    var loginButton: UIButton!
//    var errorLabel: UILabel!
//    var noAccountLabel: UILabel!
//    var registerButton: UIButton!
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = .white
//        
//        setupContentWrapper()
//        setupLogoImageView()
//        setupAppNameLabel()
//        setupLoginLabel()
//        setupEmailTextField()
//        setupPasswordTextField()
//        setupLoginButton()
//        setupErrorLabel()
//        setupNoAccountLabel()
//        setupRegisterButton()
//        
//        initConstraints()
//    }
//    
//    func setupContentWrapper() {
//        contentWrapper = UIScrollView()
//        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(contentWrapper)
//    }
//    
//    func setupLogoImageView() {
//        logoImageView = UIImageView()
//        logoImageView.image = UIImage(named: "logo") // Replace with your logo image name
//        logoImageView.contentMode = .scaleAspectFit
//        addSubviewToContainer(subview: logoImageView)
//    }
//    
//    func setupAppNameLabel() {
//        appNameLabel = UILabel()
//        appNameLabel.text = "Hobby Bloom"
//        appNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
//        appNameLabel.textColor = .systemBlue
//        appNameLabel.textAlignment = .center
//        addSubviewToContainer(subview: appNameLabel)
//    }
//    
//    func setupLoginLabel() {
//        loginLabel = UILabel()
//        loginLabel.text = "Login"
//        loginLabel.font = UIFont.boldSystemFont(ofSize: 32)
//        loginLabel.textColor = .systemBlue
//        addSubviewToContainer(subview: loginLabel)
//    }
//    
//    func setupEmailTextField() {
//        emailTextField = UITextField()
//        emailTextField.placeholder = "Email"
//        emailTextField.keyboardType = .emailAddress
//        emailTextField.borderStyle = .roundedRect
//        emailTextField.font = emailTextField.font?.withSize(16)
//        addSubviewToContainer(subview: emailTextField)
//    }
//    
//    func setupPasswordTextField() {
//        passwordTextField = UITextField()
//        passwordTextField.placeholder = "Password"
//        passwordTextField.borderStyle = .roundedRect
//        passwordTextField.isSecureTextEntry = true
//        passwordTextField.font = passwordTextField.font?.withSize(16)
//        addSubviewToContainer(subview: passwordTextField)
//    }
//    
//    func setupLoginButton() {
//        loginButton = UIButton(type: .roundedRect)
//        loginButton.setTitle("Login", for: .normal)
//        setupButton(button: loginButton)
//    }
//    
//    func setupErrorLabel() {
//        errorLabel = UILabel()
//        errorLabel.font = UIFont.systemFont(ofSize: 16)
//        errorLabel.textColor = .systemRed
//        errorLabel.lineBreakMode = .byWordWrapping
//        errorLabel.numberOfLines = 0
//        errorLabel.textAlignment = .center
//        addSubviewToContainer(subview: errorLabel)
//    }
//    
//    func setupNoAccountLabel() {
//        noAccountLabel = UILabel()
//        noAccountLabel.text = "Don't have an account yet? Register here."
//        noAccountLabel.font = UIFont.systemFont(ofSize: 14)
//        noAccountLabel.textColor = .systemBlue
//        addSubviewToContainer(subview: noAccountLabel)
//    }
//    
//    func setupRegisterButton() {
//        registerButton = UIButton(type: .roundedRect)
//        registerButton.setTitle("Register", for: .normal)
//        setupButton(button: registerButton)
//    }
//    
//    func setupButton(button: UIButton) {
//        button.backgroundColor = .systemBlue
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 10
//        button.layer.masksToBounds = true
//        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        addSubviewToContainer(subview: button)
//    }
//    
//    func addSubviewToContainer(subview: UIView) {
//        subview.translatesAutoresizingMaskIntoConstraints = false
//        contentWrapper.addSubview(subview)
//    }
//    
//    func initConstraints() {
//        NSLayoutConstraint.activate([
//            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
//            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
//            contentWrapper.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
//            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
//            
//            logoImageView.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 24),
//            logoImageView.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
//            logoImageView.widthAnchor.constraint(equalToConstant: 100),
//            logoImageView.heightAnchor.constraint(equalToConstant: 100),
//            
//            appNameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
//            appNameLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
//            
//            loginLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 32),
//            loginLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
//            
//            emailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 16),
//            emailTextField.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
//            
//            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
//            passwordTextField.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
//            
//            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
//            loginButton.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
//            
//            errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 12),
//            errorLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
//            errorLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
//            errorLabel.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
//            
//            noAccountLabel.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 48),
//            noAccountLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
//            
//            registerButton.topAnchor.constraint(equalTo: noAccountLabel.bottomAnchor, constant: 12),
//            registerButton.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
//            registerButton.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor)
//        ])
//        textFieldConstraints(emailTextField)
//        textFieldConstraints(passwordTextField)
//    }
//    
//    func textFieldConstraints(_ textField: UITextField) {
//        NSLayoutConstraint.activate([
//            textField.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 48),
//            textField.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -48)
//        ])
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
import UIKit

class LoginScreenView: UIView {

    var contentWrapper: UIScrollView!
    var logoImageView: UIImageView!
    var appNameLabel: UILabel!
    var loginLabel: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var errorLabel: UILabel!
    var noAccountLabel: UILabel!
    var registerButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupContentWrapper()
        setupLogoImageView()
        setupAppNameLabel()
        setupLoginLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupErrorLabel()
        setupNoAccountLabel()
        setupRegisterButton()

        initConstraints()
    }

    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }

    func setupLogoImageView() {
        logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "Logo") // Replace with your logo image name
        logoImageView.contentMode = .scaleAspectFit
        addSubviewToContainer(subview: logoImageView)
    }

    func setupAppNameLabel() {
        appNameLabel = UILabel()
        appNameLabel.text = "Hobby Bloom"
        appNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        appNameLabel.textColor = .myDarkPurple
        appNameLabel.textAlignment = .center
        addSubviewToContainer(subview: appNameLabel)
    }

    func setupLoginLabel() {
        loginLabel = UILabel()
        loginLabel.text = "Login"
        loginLabel.font = UIFont.boldSystemFont(ofSize: 32)
        loginLabel.textColor = .myPurple
        addSubviewToContainer(subview: loginLabel)
    }

    func setupEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.borderStyle = .roundedRect
        emailTextField.font = emailTextField.font?.withSize(16)
        emailTextField.backgroundColor = .myLightPurple
        emailTextField.textColor = .myDarkPurple
        addSubviewToContainer(subview: emailTextField)
    }

    func setupPasswordTextField() {
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.font = passwordTextField.font?.withSize(16)
        passwordTextField.backgroundColor = .myLightPurple
        passwordTextField.textColor = .myDarkPurple
        addSubviewToContainer(subview: passwordTextField)
    }

    func setupLoginButton() {
        loginButton = UIButton(type: .roundedRect)
        loginButton.setTitle("Login", for: .normal)
        setupButton(button: loginButton, backgroundColor: .myPurple)
    }

    func setupErrorLabel() {
        errorLabel = UILabel()
        errorLabel.font = UIFont.systemFont(ofSize: 16)
        errorLabel.textColor = .myDarkRed
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        addSubviewToContainer(subview: errorLabel)
    }

    func setupNoAccountLabel() {
        noAccountLabel = UILabel()
        noAccountLabel.text = "Don't have an account yet? Register here."
        noAccountLabel.font = UIFont.systemFont(ofSize: 14)
        noAccountLabel.textColor = .myPurple
        addSubviewToContainer(subview: noAccountLabel)
    }

    func setupRegisterButton() {
        registerButton = UIButton(type: .roundedRect)
        registerButton.setTitle("Register", for: .normal)
        setupButton(button: registerButton, backgroundColor: .myPurple)
    }

    func setupButton(button: UIButton, backgroundColor: UIColor) {
        button.backgroundColor = backgroundColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        addSubviewToContainer(subview: button)
    }

    func addSubviewToContainer(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(subview)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),

            logoImageView.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 24),
            logoImageView.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),

            appNameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            appNameLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            loginLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 32),
            loginLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            emailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 16),
            emailTextField.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            loginButton.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 12),
            errorLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),

            noAccountLabel.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 48),
            noAccountLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            registerButton.topAnchor.constraint(equalTo: noAccountLabel.bottomAnchor, constant: 12),
            registerButton.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            registerButton.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor)
        ])
        textFieldConstraints(emailTextField)
        textFieldConstraints(passwordTextField)
    }

    func textFieldConstraints(_ textField: UITextField) {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 48),
            textField.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -48)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
