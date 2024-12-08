//
//  PhotoFirebaseManager.swift
//  HobbyBloom
//
//  Created by Ashmitha appandaraju on 12/2/24.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

extension EditProfileViewController {
   
    func uploadNewProfilePhotoAndSaveChanges() {
        guard Auth.auth().currentUser != nil else {
                   print("No logged-in user.")
                   return
               }
               
               // If a new image is picked, upload it to Firebase Storage
               if let image = pickedImage, let jpegData = image.jpegData(compressionQuality: 0.7) {
                   let storageRef = storage.reference()
                   let imageRef = storageRef.child("profilePhotos/\(UUID().uuidString).jpg")
                   
                   // Upload the image
                   imageRef.putData(jpegData) { [weak self] _, error in
                       if let error = error {
                           print("Failed to upload image: \(error.localizedDescription)")
                           return
                       }
                       
                       // Get the download URL for the uploaded image
                       imageRef.downloadURL { url, error in
                           if let error = error {
                               print("Failed to fetch download URL: \(error.localizedDescription)")
                               return
                           }
                           
                           // Proceed to update user profile with the photo URL
                           self?.updateUserProfile(photoURL: url)
                       }
                   }
               } else {
                   // No new image, just update other fields
                   updateUserProfile(photoURL: nil)
               }
           }

           func updateUserProfile(photoURL: URL?) {
               guard let currentUser = Auth.auth().currentUser else {
                   print("No logged-in user.")
                   return
               }
               
               let userUID = currentUser.uid // Use UID to identify the document
               let userRef = db.collection("users").document(userUID) // Access Firestore using UID

               // Collect data from text fields (only if modified)
               var updatedData: [String: Any] = [:]
               if let name = Editprofileview.TextFieldName.text, !name.isEmpty {
                   updatedData["name"] = name
               }
               updatedData["city"] = selectedCity
              
               if let photoURLString = photoURL?.absoluteString {
                   updatedData["photo_url"] = photoURLString
               }
               
               // Update Firestore if there is data to update
               if !updatedData.isEmpty {
                   userRef.updateData(updatedData) { [weak self] error in
                       if let error = error {
                           print("Error updating Firestore: \(error.localizedDescription)")
                       } else {
                           print("User profile updated successfully.")
                           self?.navigateToProfilePage()
                       }
                   }
               } else {
                   // If no data to update, navigate directly
                   navigateToProfilePage()
               }
               
               // Update the password if provided
               if let password = Editprofileview.TextFieldPassword.text, !password.isEmpty {
                   currentUser.updatePassword(to: password) { error in
                       if let error = error {
                           print("Failed to update password: \(error.localizedDescription)")
                       } else {
                           print("Password updated successfully.")
                       }
                   }
               }
           }

           func navigateToProfilePage() {
               if let profileVC = navigationController?.viewControllers.first(where: { $0 is ProfileViewController }) {
                   navigationController?.popToViewController(profileVC, animated: true)
               }
           }
}
