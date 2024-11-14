//
//  ViewController.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/1/24.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: setting up home tab bar...
        let tabHome = HomePageViewController()
        let tabHomeBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "house.fill")
        )

        tabHome.tabBarItem = tabHomeBarItem
        tabHome.title = "Home"
        
        //MARK: setting up home tab bar...
        let tabHome1 = UINavigationController(rootViewController: HomePageViewController())
        let tabHomeBarItem1 = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "house.fill")
        )
        tabHome1.tabBarItem = tabHomeBarItem1
        tabHome1.title = "Home"
        
        //MARK: setting up this view controller as the Tab Bar Controller...
        self.viewControllers = [tabHome, tabHome1]
        
        self.selectedViewController = tabHome
        self.tabBar.backgroundColor = .systemIndigo
        self.tabBar.tintColor = .white
        self.tabBar.isTranslucent = true
        self.tabBar.layer.borderWidth = 1
        self.tabBar.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // if user is not logged in, display login screen modally
    }
}
