//
//  EditProfileView.swift
//  HobbyBloom
//
//  Created by Ashmitha appandaraju on 11/18/24.
//

import UIKit

class EditProfileView: UIView {

    var TextFieldName: UITextField!
    var TextFieldEmail: UITextField!
    var TextFieldPassword: UITextField!
    var TextFieldCity: UITextField!
    var SaveButton: UIButton!
    var image: UIImageView!
    override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.backgroundColor = .white
            setupImage()
            setupTextFieldName()
            setupTextFieldEmail()
            setupTextFieldPassword()
            setupTextFieldCity()
        setupSaveButton()
            initConstraints()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupImage() {
        image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.tintColor = .myDarkPurple
        image.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(image)
    }

    func setupTextFieldName()
    {
        TextFieldName = UITextField()
        TextFieldName.placeholder = "Name"
        TextFieldName.backgroundColor = UIColor.purple.withAlphaComponent(0.2)
        TextFieldName.layer.cornerRadius = 8
            TextFieldName.layer.masksToBounds = true
        TextFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(TextFieldName)
    }
    func setupTextFieldEmail()
    {
        TextFieldEmail = UITextField()
        TextFieldEmail.placeholder = "Email"
        TextFieldEmail.keyboardType = .emailAddress
        TextFieldEmail.backgroundColor = UIColor.purple.withAlphaComponent(0.2)
        TextFieldEmail.layer.cornerRadius = 8
        TextFieldEmail.translatesAutoresizingMaskIntoConstraints =  false
        self.addSubview(TextFieldEmail)
    }
    func setupTextFieldPassword()
    {
        TextFieldPassword = UITextField()
        TextFieldPassword.placeholder = "Password"
        TextFieldPassword.isSecureTextEntry = true
        TextFieldPassword.backgroundColor = UIColor.purple.withAlphaComponent(0.2)
        TextFieldPassword.layer.cornerRadius = 8
        TextFieldPassword.translatesAutoresizingMaskIntoConstraints =  false
        self.addSubview(TextFieldPassword)
    }
    func setupTextFieldCity()
    {
        TextFieldCity = UITextField()
        TextFieldCity.placeholder = "City"
        TextFieldCity.backgroundColor = UIColor.purple.withAlphaComponent(0.2)
        TextFieldCity.layer.cornerRadius = 8
        TextFieldCity.translatesAutoresizingMaskIntoConstraints =  false
        self.addSubview(TextFieldCity)
    }
    func setupSaveButton() {
            SaveButton = UIButton(type: .system)
            SaveButton.setTitle("Save", for: .normal)
            SaveButton.setTitleColor(.white, for: .normal)
        SaveButton.backgroundColor = .myDarkPurple
            SaveButton.layer.cornerRadius = 20
            SaveButton.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(SaveButton)
        }
   
    func initConstraints() {
            NSLayoutConstraint.activate([
                image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                image.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
                image.widthAnchor.constraint(equalToConstant: 100),
                image.heightAnchor.constraint(equalToConstant: 100),

                TextFieldName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                TextFieldName.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
                TextFieldName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
                TextFieldName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
                TextFieldName.heightAnchor.constraint(equalToConstant: 44),

                TextFieldEmail.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                TextFieldEmail.topAnchor.constraint(equalTo: TextFieldName.bottomAnchor, constant: 16),
                TextFieldEmail.leadingAnchor.constraint(equalTo: TextFieldName.leadingAnchor),
                TextFieldEmail.trailingAnchor.constraint(equalTo: TextFieldName.trailingAnchor),
                TextFieldEmail.heightAnchor.constraint(equalToConstant: 44),

                TextFieldPassword.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                TextFieldPassword.topAnchor.constraint(equalTo: TextFieldEmail.bottomAnchor, constant: 16),
                TextFieldPassword.leadingAnchor.constraint(equalTo: TextFieldName.leadingAnchor),
                TextFieldPassword.trailingAnchor.constraint(equalTo: TextFieldName.trailingAnchor),
                TextFieldPassword.heightAnchor.constraint(equalToConstant: 44),

                TextFieldCity.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                TextFieldCity.topAnchor.constraint(equalTo: TextFieldPassword.bottomAnchor, constant: 16),
                TextFieldCity.leadingAnchor.constraint(equalTo: TextFieldName.leadingAnchor),
                TextFieldCity.trailingAnchor.constraint(equalTo: TextFieldName.trailingAnchor),
                TextFieldCity.heightAnchor.constraint(equalToConstant: 44),

                SaveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                SaveButton.topAnchor.constraint(equalTo: TextFieldCity.bottomAnchor, constant: 32),
                SaveButton.widthAnchor.constraint(equalToConstant: 120),
                SaveButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        }

}
