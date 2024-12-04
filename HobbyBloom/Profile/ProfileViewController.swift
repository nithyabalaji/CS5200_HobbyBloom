//
//  ProfileViewController.swift
//  HobbyBloom
//
//  Created by Ashmitha appandaraju on 11/19/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let editButton = UIBarButtonItem(
                    title: "Edit",
                    style: .plain,
                    target: self,
                    action: #selector(editButtonTapped)
                )
                navigationItem.rightBarButtonItem = editButton
        // Do any additional setup after loading the view.
    }
    let profileview = ProfileView()
    let db = Firestore.firestore()
    var currentUser: FirebaseAuth.User?
    override func loadView() {
        view = profileview
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            setupAuthenticatedUI()
        }
    @objc func editButtonTapped() {
            let editProfileViewController = EditProfileViewController()
            navigationController?.pushViewController(editProfileViewController, animated: true)
        }
    func setupAuthenticatedUI() {
            // Check if a user is logged in
            if let user = Auth.auth().currentUser {
                self.currentUser = user
                fetchUserProfile(for: user)
                self.setupLeftBarButton(isLoggedin: true)
            } else {
                presentLoginScreen()
                self.setupLeftBarButton(isLoggedin: false)
            }
        }
    func setupLeftBarButton(isLoggedin: Bool) {
        if isLoggedin {
            let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(onLogOutBarButtonTapped))
            navigationItem.leftBarButtonItem = logoutButton
        } else {
            presentLoginScreen()
        }
    }
    @objc func onLogOutBarButtonTapped() {
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: { _ in
            do {
                try Auth.auth().signOut()
                self.presentLoginScreen()
            } catch {
                print("Error occurred while logging out!")
            }
        }))
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(logoutAlert, animated: true)
    }
     func presentLoginScreen() {
         let loginController = UINavigationController(rootViewController: LoginScreenViewController())
         loginController.modalPresentationStyle = .fullScreen
         present(loginController, animated: true, completion: nil)
        }

        func fetchUserProfile(for user: FirebaseAuth.User) {
            guard let userEmail = user.email else { return }
            if let url = self.currentUser?.photoURL{
                self.profileview.profileImageView.loadRemoteImage(from: url)
                            }
            // Fetch the user document from Firestore
            db.collection("users").document(userEmail).getDocument { [weak self] (document, error) in
                guard let self = self else { return }

                if let error = error {
                    print("Error fetching user document: \(error.localizedDescription)")
                    return
                }

                if let document = document, document.exists, let data = document.data() {
                    self.configureProfile(with: data)
                } else {
                    print("User document does not exist.")
                }
            }
        }

         func configureProfile(with data: [String: Any]) {
            // Extract user data from Firestore document
            let name = data["name"] as? String ?? "Unknown"
            let age = data["age"] as? Int ?? 0
            let city = data["city"] as? String ?? "Unknown"
            let email = data["email"] as? String ?? "Unknown"
            let interests = data["interests"] as? [String] ?? []
            let personality = data["personality"] as? String ?? "Unknown"
            let photoURL = data["photo_url"] as? String

            // Update the profile view
            profileview.nameLabel.text = "\(name), \(age)"
            profileview.locationLabel.text = city
            profileview.emailLabel.text = email
            profileview.configureTags(for: profileview.interestsCollectionView, with: interests)
            profileview.configureTags(for: profileview.personalityCollectionView, with: [personality])
             if let photoURL = photoURL, let url = URL(string: photoURL) {
                         loadImage(from: url) { image in
                             self.profileview.profileImageView.image = image
                         }
                     }
        }

         func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    print("Failed to load image: \(error.localizedDescription)")
                    completion(nil)
                    return
                }

                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    completion(nil)
                }
            }.resume()
        }
   
}
