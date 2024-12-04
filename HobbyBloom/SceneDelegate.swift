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
        guard let _ = (scene as? UIWindowScene) else { return }
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
