//
//  EditProfileView.swift
//  HobbyBloom
//
//  Created by Ashmitha appandaraju on 11/18/24.
//

import UIKit

class EditProfileView: UIView {
    var buttonTakePhoto: UIButton!
    var TextFieldName: UITextField!
    var TextFieldEmail: UITextField!
    var TextFieldPassword: UITextField!
    var TextFieldCity: UITextField!
    var labelCityInstructions: UILabel!
        var cityPicker: UIPickerView!
        var buttonSendCity: UIButton!
    var SaveButton: UIButton!
    var image: UIImageView!
    override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.backgroundColor = .white
            setupImage()
            setupTextFieldName()
            setupTextFieldPassword()
        setupLabelCityInstructions()
                setupCityPicker()
                
            setupSaveButton()
            initConstraints()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupImage() {
        buttonTakePhoto = UIButton(type: .system)
               buttonTakePhoto.setTitle("", for: .normal)
               buttonTakePhoto.setImage(UIImage(systemName: "person.circle.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
               buttonTakePhoto.contentHorizontalAlignment = .fill
               buttonTakePhoto.contentVerticalAlignment = .fill
                buttonTakePhoto.tintColor = .myDarkPurple
               buttonTakePhoto.imageView?.contentMode = .scaleAspectFit
               buttonTakePhoto.showsMenuAsPrimaryAction = true
               buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
               self.addSubview(buttonTakePhoto)
    }
    func setupLabelCityInstructions(){
        labelCityInstructions = UILabel()
        labelCityInstructions.text = "Pick your city!"
        labelCityInstructions.translatesAutoresizingMaskIntoConstraints = false
           self.addSubview(labelCityInstructions)
       }
       
       // setting up mood picker...
       func setupCityPicker(){
           cityPicker = UIPickerView()
           cityPicker.isUserInteractionEnabled = true
           cityPicker.translatesAutoresizingMaskIntoConstraints = false
           self.addSubview(cityPicker)
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
                buttonTakePhoto.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                buttonTakePhoto.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
                buttonTakePhoto.widthAnchor.constraint(equalToConstant: 100),
                buttonTakePhoto.heightAnchor.constraint(equalToConstant: 100),

                TextFieldName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                TextFieldName.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor, constant: 16),
                TextFieldName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
                TextFieldName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
                TextFieldName.heightAnchor.constraint(equalToConstant: 44),

                TextFieldPassword.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                TextFieldPassword.topAnchor.constraint(equalTo: TextFieldName.bottomAnchor, constant: 16),
                TextFieldPassword.leadingAnchor.constraint(equalTo: TextFieldName.leadingAnchor),
                TextFieldPassword.trailingAnchor.constraint(equalTo: TextFieldName.trailingAnchor),
                TextFieldPassword.heightAnchor.constraint(equalToConstant: 44),
                            
                            //labelMoodInstructions constraints...
                labelCityInstructions.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                labelCityInstructions.topAnchor.constraint(equalTo: TextFieldPassword.bottomAnchor, constant: 16),
                            
                            //mood picker constraints...
                cityPicker.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                cityPicker.topAnchor.constraint(equalTo: labelCityInstructions.bottomAnchor, constant: 1),
                         

                SaveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                SaveButton.topAnchor.constraint(equalTo: cityPicker.bottomAnchor, constant: 32),
                SaveButton.widthAnchor.constraint(equalToConstant: 120),
                SaveButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        }

}


