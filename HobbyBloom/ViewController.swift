//
//  ViewController.swift
//  HobbyBloom
//
// Created by Nithya Balaji on 11/1/24.
//

import UIKit
import FirebaseAuth

class ViewController: UITabBarController, UITabBarControllerDelegate {
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleAuth = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }
            if let user = user {
                self.currentUser = user
                self.setupNavigationBar()
            } else {
                self.presentLoginViewController()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func setupNavigationBar() {
        //MARK: setting up home tab bar...
        let homeController = HomePageViewController()
        homeController.currentUser = self.currentUser
        let tabHome = UINavigationController(rootViewController: homeController)
        let tabHomeBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        tabHome.tabBarItem = tabHomeBarItem
        tabHome.title = "Home"
        
        let tabProfile = UINavigationController(rootViewController: ProfileViewController())
        let tabProfileBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        tabProfile.tabBarItem = tabProfileBarItem
        tabProfile.title = "Profile"
        
        //MARK: setting up this view controller as the Tab Bar Controller...
        self.viewControllers = [tabHome, tabProfile]
        
        self.selectedViewController = tabHome
        self.tabBar.backgroundColor = UIColor.myDarkPurple
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = UIColor.myLightPurple
        self.tabBar.layer.borderWidth = 1
        self.tabBar.layer.borderColor = UIColor.myDarkPurple.cgColor
    }
    
    // MARK: - Present Login Screen Modally
    func presentLoginViewController() {
        let loginViewController = UINavigationController(rootViewController: LoginScreenViewController())
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true, completion: nil)
    }
}
