//
//  EditProfileViewController.swift
//  HobbyBloom
//
//  Created by Ashmitha appandaraju on 11/21/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import PhotosUI
class EditProfileViewController: UIViewController {
    var pickedImage:UIImage?
    let Editprofileview = EditProfileView()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    override func viewDidLoad() {
        super.viewDidLoad()
        Editprofileview.buttonTakePhoto.menu = getMenuImagePicker()
        Editprofileview.SaveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    @objc func saveButtonTapped() {
        if validatePassword() {
            uploadNewProfilePhotoAndSaveChanges()
        } else {
            showAlertForIncompleteFields()
        }
    }

    private func validatePassword() -> Bool {
        // Validate if the password is at least 6 characters long
        if let password = Editprofileview.TextFieldPassword.text, !password.isEmpty {
                return password.count >= 6
            }
            return true // If the password field is empty, we consider it valid
    }

    private func showAlertForIncompleteFields() {
        let alertMessage: String
        
        // Check if the password is valid and set the appropriate alert message
        if let password = Editprofileview.TextFieldPassword.text, password.count < 6 {
            alertMessage = "Password must be at least 6 characters long."
        } else {
            alertMessage = "Please complete the required fields."
        }
        
        // Show alert with the message
        let alert = UIAlertController(title: "Form Error",
                                      message: alertMessage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    
    func getMenuImagePicker() -> UIMenu{
            let menuItems = [
                UIAction(title: "Camera",handler: {(_) in
                    self.pickUsingCamera()
                }),
                UIAction(title: "Gallery",handler: {(_) in
                    self.pickPhotoFromGallery()
                })
            ]
            
            return UIMenu(title: "Select source", children: menuItems)
        }
        
        //MARK: take Photo using Camera...
        func pickUsingCamera(){
            let cameraController = UIImagePickerController()
            cameraController.sourceType = .camera
            cameraController.allowsEditing = true
            cameraController.delegate = self
            present(cameraController, animated: true)
        }
        
        //MARK: pick Photo using Gallery...
        func pickPhotoFromGallery(){
            //MARK: Photo from Gallery...
            var configuration = PHPickerConfiguration()
            configuration.filter = PHPickerFilter.any(of: [.images])
            configuration.selectionLimit = 1
            
            let photoPicker = PHPickerViewController(configuration: configuration)
            
            photoPicker.delegate = self
            present(photoPicker, animated: true, completion: nil)
        }
    override func loadView() {
        view = Editprofileview
    }
    

    

}
