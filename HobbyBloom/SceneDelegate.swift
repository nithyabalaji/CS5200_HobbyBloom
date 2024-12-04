//
//  SceneDelegate.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/1/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // Check if the user is logged in
        if isUserLoggedIn() {
            // If logged in, setup the main Tab Bar Controller
            let tabBarController = UITabBarController()
            let homeVC = HomePageViewController()
           // let profileVC = UINavigationController(rootViewController: ProfileViewController())
            
            // Set up tab bar items
            homeVC.tabBarItem = UITabBarItem(
                title: "Home",
                image: UIImage(systemName: "house"),
                selectedImage: UIImage(systemName: "house.fill")
            )
//            profileVC.tabBarItem = UITabBarItem(
//                title: "Profile",
//                image: UIImage(systemName: "person"),
//                selectedImage: UIImage(systemName: "person.fill")
//            )
            
            tabBarController.viewControllers = [homeVC]
            window?.rootViewController = tabBarController
        } else {
            // If not logged in, present the LoginViewController
            let loginVC = LoginScreenViewController()
            let navigationController = UINavigationController(rootViewController: loginVC)
            window?.rootViewController = navigationController
        }
        
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Handle the scene being disconnected
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Handle the scene becoming active
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Handle the scene resigning active
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Handle the scene entering foreground
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Handle the scene entering background
    }
    
    // MARK: - Check if User is Logged In
    func isUserLoggedIn() -> Bool {
        // Example check, replace with actual authentication logic
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: "isUserLoggedIn") // Assuming you save this flag upon login
    }
}
