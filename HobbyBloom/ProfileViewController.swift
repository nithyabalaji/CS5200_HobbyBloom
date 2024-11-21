//
//  ProfileViewController.swift
//  HobbyBloom
//
//  Created by Ashmitha appandaraju on 11/19/24.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureProfile()
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
        
    override func loadView() {
        view = profileview
    }
    @objc func editButtonTapped() {
            let editProfileViewController = EditProfileViewController()
            navigationController?.pushViewController(editProfileViewController, animated: true)
        }
    func configureProfile() {
        profileview.nameLabel.text = "Jhon Doe, 25"
        profileview.locationLabel.text = "Boston, MA"
        profileview.emailLabel.text = "doe.jhon@gmail.com"

        profileview.configureTags(for: profileview.interestsStackView, with: ["Gaming", "Football", "Chess", "Long drives"])
        profileview.configureTags(for: profileview.skillsStackView, with: ["Swimming", "Hiking","Swimming","Swimming","Swimming","Swimming","Swimming","Swimming","Swimming"])
        profileview.configureTags(for: profileview.personalityStackView, with: ["Introvert"])
        }
   
}
