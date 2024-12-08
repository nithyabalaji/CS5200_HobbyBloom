////
////  RegisterScreenView.swift
////  HobbyBloom
////
////  Created by Bhumi Shah on 12/2/24.
////
//
//import UIKit
//
//class RegisterScreenView: UIView {
//    
//    var contentWrapper: UIScrollView!
//    var registerLabel: UILabel!
//    var nameTextField: UITextField!
//    var emailTextField: UITextField!
//    var passwordTextField: UITextField!
//    var cityPickerView: UIPickerView!  // Change to UIPickerView
//    var quizInstructionLabel: UILabel!
//    var takeQuizButton: UIButton!
//    var errorLabel: UILabel!
//    var backButton: UIButton! 
//    
//    let activityIndicator = UIActivityIndicatorView(style: .large)
//    
//    let cities = ["Select a city","Boston", "New York", "Chicago", "Miami", "San Francisco"]
//    var selectedCity: String?
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = .white
//        
//        setupContentWrapper()
//        setupRegisterLabel()
//        setupNameTextField()
//        setupEmailTextField()
//        setupPasswordTextField()
//        setupCityPickerView()  // Change to UIPickerView
//        setupQuizInstructionLabel()
//        setupTakeQuizButton()
//        setupErrorLabel()
//        setupViews()
//        initConstraints()
//        setupBackButton()
//    }
//    
//    private func setupViews() {
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        activityIndicator.hidesWhenStopped = true
//        addSubview(activityIndicator)
//        
//        NSLayoutConstraint.activate([
//            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
//        ])
//    }
//    
//    func setupBackButton() {
//        let backButton = UIButton(type: .system)
//        backButton.setTitle("Back", for: .normal)
//        backButton.setTitleColor(.systemBlue, for: .normal)
//        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        backButton.translatesAutoresizingMaskIntoConstraints = false
//        addSubviewToContainer(subview: backButton)
//        
//        NSLayoutConstraint.activate([
//            backButton.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 16),
//            backButton.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16)
//        ])
//        
//        self.backButton = backButton
//    }
//
//    func setupContentWrapper() {
//        contentWrapper = UIScrollView()
//        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(contentWrapper)
//    }
//    
//    func setupRegisterLabel() {
//        registerLabel = UILabel()
//        registerLabel.text = "Register"
//        registerLabel.font = UIFont.boldSystemFont(ofSize: 32)
//        registerLabel.textColor = .systemBlue
//        addSubviewToContainer(subview: registerLabel)
//    }
//    
//    func setupNameTextField() {
//        nameTextField = UITextField()
//        nameTextField.placeholder = "Name"
//        nameTextField.borderStyle = .roundedRect
//        nameTextField.font = nameTextField.font?.withSize(16)
//        addSubviewToContainer(subview: nameTextField)
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
//        passwordTextField.isSecureTextEntry = true
//        passwordTextField.borderStyle = .roundedRect
//        passwordTextField.font = passwordTextField.font?.withSize(16)
//        addSubviewToContainer(subview: passwordTextField)
//    }
//    
//    // New method for setting up the city picker view
//    func setupCityPickerView() {
//        cityPickerView = UIPickerView()
//        cityPickerView.delegate = self
//        cityPickerView.dataSource = self
//        cityPickerView.translatesAutoresizingMaskIntoConstraints = false
//        addSubviewToContainer(subview: cityPickerView)
//    }
//    
//    func setupQuizInstructionLabel() {
//        quizInstructionLabel = UILabel()
//        quizInstructionLabel.text = "Take the quiz to find the perfect activities for you"
//        quizInstructionLabel.font = UIFont.systemFont(ofSize: 16)
//        quizInstructionLabel.textColor = .darkGray
//        quizInstructionLabel.numberOfLines = 0
//        quizInstructionLabel.textAlignment = .center
//        addSubviewToContainer(subview: quizInstructionLabel)
//    }
//    
//    func setupTakeQuizButton() {
//        takeQuizButton = UIButton(type: .roundedRect)
//        takeQuizButton.setTitle("Take Quiz", for: .normal)
//        setupButton(button: takeQuizButton)
//    }
//    
//    func setupErrorLabel() {
//        errorLabel = UILabel()
//        errorLabel.font = UIFont.systemFont(ofSize: 16)
//        errorLabel.textColor = .systemRed
//        errorLabel.numberOfLines = 0
//        errorLabel.textAlignment = .center
//        addSubviewToContainer(subview: errorLabel)
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
//            registerLabel.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 48),
//            registerLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
//            
//            nameTextField.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 16),
//            nameTextField.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
//            
//            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
//            emailTextField.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
//            
//            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
//            passwordTextField.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
//            
//            cityPickerView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
//            cityPickerView.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
//            cityPickerView.widthAnchor.constraint(equalTo: contentWrapper.widthAnchor, multiplier: 0.8),
//            cityPickerView.heightAnchor.constraint(equalToConstant: 150),
//            
//            quizInstructionLabel.topAnchor.constraint(equalTo: cityPickerView.bottomAnchor, constant: 16),
//            quizInstructionLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
//            quizInstructionLabel.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
//            
//            takeQuizButton.topAnchor.constraint(equalTo: quizInstructionLabel.bottomAnchor, constant: 24),
//            takeQuizButton.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
//            
//            errorLabel.topAnchor.constraint(equalTo: takeQuizButton.bottomAnchor, constant: 12),
//            errorLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
//            errorLabel.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
//            errorLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentWrapper.bottomAnchor),
//        ])
//        textFieldConstraints(nameTextField)
//        textFieldConstraints(emailTextField)
//        textFieldConstraints(passwordTextField)
//    }
//    
//    func textFieldConstraints(_ textField: UITextField) {
//        NSLayoutConstraint.activate([
//            textField.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 48),
//            textField.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -48),
//        ])
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//extension RegisterScreenView: UIPickerViewDelegate, UIPickerViewDataSource {
//    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return cities.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return cities[row]
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        selectedCity = cities[row]
//    }
//}
import UIKit

class RegisterScreenView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var contentWrapper: UIScrollView!
    var registerLabel: UILabel!
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var cityPickerView: UIPickerView!
    var quizInstructionLabel: UILabel!
    var takeQuizButton: UIButton!
    var errorLabel: UILabel!
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    let cities = ["Select a city","Boston", "New York", "Chicago", "Austin", "San Francisco"]
    var selectedCity: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupRegisterLabel()
        setupNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupCityPickerView()
        setupQuizInstructionLabel()
        setupTakeQuizButton()
        setupErrorLabel()
        setupViews()
        initConstraints()
    }
    
    private func setupViews() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupRegisterLabel() {
        registerLabel = UILabel()
        registerLabel.text = "Register"
        registerLabel.font = UIFont.boldSystemFont(ofSize: 32)
        registerLabel.textColor = .myPurple // Same color as in LoginView
        addSubviewToContainer(subview: registerLabel)
    }
    
    func setupNameTextField() {
        nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.font = nameTextField.font?.withSize(16)
        nameTextField.backgroundColor = .myLightPurple
        nameTextField.textColor = .myDarkPurple
        nameTextField.layer.borderColor = UIColor.myPurple.cgColor // Same color as in LoginView
        addSubviewToContainer(subview: nameTextField)
    }
    
    func setupEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.borderStyle = .roundedRect
        emailTextField.font = emailTextField.font?.withSize(16)
        emailTextField.backgroundColor = .myLightPurple
        emailTextField.textColor = .myDarkPurple
        emailTextField.layer.borderColor = UIColor.myPurple.cgColor // Same color as in LoginView
        addSubviewToContainer(subview: emailTextField)
    }
    
    func setupPasswordTextField() {
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.font = passwordTextField.font?.withSize(16)
        passwordTextField.backgroundColor = .myLightPurple
        passwordTextField.textColor = .myDarkPurple
        passwordTextField.layer.borderColor = UIColor.myPurple.cgColor // Same color as in LoginView
        addSubviewToContainer(subview: passwordTextField)
    }
    
    func setupCityPickerView() {
        cityPickerView = UIPickerView()
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
        cityPickerView.translatesAutoresizingMaskIntoConstraints = false
        addSubviewToContainer(subview: cityPickerView)
    }
    
    func setupQuizInstructionLabel() {
        quizInstructionLabel = UILabel()
        quizInstructionLabel.text = "Take the quiz to find the perfect activities for you"
        quizInstructionLabel.font = UIFont.systemFont(ofSize: 16)
        quizInstructionLabel.textColor = .myPurple
        quizInstructionLabel.numberOfLines = 0
        quizInstructionLabel.textAlignment = .center
        addSubviewToContainer(subview: quizInstructionLabel)
    }
    
    func setupTakeQuizButton() {
        takeQuizButton = UIButton(type: .roundedRect)
        takeQuizButton.setTitle("Take Quiz", for: .normal)
        setupButton(button: takeQuizButton)
    }
    
    func setupErrorLabel() {
        errorLabel = UILabel()
        errorLabel.font = UIFont.systemFont(ofSize: 16)
        errorLabel.textColor = .myRed // Same color as in LoginView
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        addSubviewToContainer(subview: errorLabel)
    }
    
    func setupButton(button: UIButton) {
        button.backgroundColor = .myPurple // Same color as in LoginView
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

            registerLabel.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 24),
            registerLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 32),
            nameTextField.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            emailTextField.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            cityPickerView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            cityPickerView.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            quizInstructionLabel.topAnchor.constraint(equalTo: cityPickerView.bottomAnchor, constant: 32),
            quizInstructionLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            takeQuizButton.topAnchor.constraint(equalTo: quizInstructionLabel.bottomAnchor, constant: 16),
            takeQuizButton.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: takeQuizButton.bottomAnchor, constant: 12),
            errorLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),

        ])
        
        textFieldConstraints(nameTextField)
        textFieldConstraints(emailTextField)
        textFieldConstraints(passwordTextField)
    }
    
    func textFieldConstraints(_ textField: UITextField) {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 48),
            textField.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -48)
        ])
    }
    
    // MARK: - UIPickerViewDelegate & UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCity = cities[row]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
