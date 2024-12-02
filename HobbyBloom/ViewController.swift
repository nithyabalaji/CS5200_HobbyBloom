////
////  ViewController.swift
////  HobbyBloom
////
////  Created by Nithya Balaji on 11/1/24.
////
//
//import UIKit
//
//class ViewController: UITabBarController, UITabBarControllerDelegate {
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        self.setupNavigationBar()
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        
//        // if user is not logged in, display login screen modally
//
//    }
//    
//    func setupNavigationBar() {
//        //MARK: setting up home tab bar...
//        let tabHome = HomePageViewController()
//        let tabHomeBarItem = UITabBarItem(
//            title: "Home",
//            image: UIImage(systemName: "house"),
//            selectedImage: UIImage(systemName: "house.fill")
//        )
//        tabHome.tabBarItem = tabHomeBarItem
//        tabHome.title = "Home"
//        let tabProfile = UINavigationController(rootViewController: ProfileViewController())
////        let tabProfile = ProfileViewController()
//        let tabProfileBarItem = UITabBarItem(
//            title: "Profile",
//            image: UIImage(systemName: "person"),
//            selectedImage: UIImage(systemName: "person.fill")
//        )
//        tabProfile.tabBarItem = tabProfileBarItem
//        tabProfile.title = "Profile"
//        /*
//        //MARK: setting up home tab bar...
//        let tabHome1 = UINavigationController(rootViewController: HomePageViewController())
//        let tabHomeBarItem1 = UITabBarItem(
//            title: "Home",
//            image: UIImage(systemName: "house"),
//            selectedImage: UIImage(systemName: "house.fill")
//        )
//        tabHome1.tabBarItem = tabHomeBarItem1
//        tabHome1.title = "Home"
//         */
//        
//        //MARK: setting up this view controller as the Tab Bar Controller...
//        self.viewControllers = [tabHome, tabProfile]
//        
//        
//        self.selectedViewController = tabHome
//        self.tabBar.backgroundColor = UIColor.myDarkPurple
//        self.tabBar.tintColor = .white
//        self.tabBar.unselectedItemTintColor = UIColor.myLightPurple
//        //self.tabBar.isTranslucent = true
//        self.tabBar.layer.borderWidth = 1
//        self.tabBar.layer.borderColor = UIColor.myDarkPurple.cgColor
//         
//    }
//}
import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Check if the user is logged in
        if !isUserLoggedIn() {
            // If not logged in, show the login screen modally
            presentLoginViewController()
        } else {
            // If logged in, proceed with tab bar setup
            setupNavigationBar()
        }
    }
    
    func setupNavigationBar() {
        //MARK: setting up home tab bar...
        let tabHome = HomePageViewController()
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
    
    // MARK: - Check if User is Logged In
    func isUserLoggedIn() -> Bool {
        // Example check, replace with actual authentication logic
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: "isUserLoggedIn") // Assuming you save this flag upon login
    }
    
    // MARK: - Present Login Screen Modally
    func presentLoginViewController() {
        let loginViewController = LoginScreenViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)
        present(navigationController, animated: true, completion: nil)
    }
}
