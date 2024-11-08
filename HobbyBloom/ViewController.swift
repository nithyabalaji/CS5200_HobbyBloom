//
//  ViewController.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/1/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If user is logged in, push main navigation controller
        let mainNavigationController = NavigationViewController()
        self.navigationController?.pushViewController(mainNavigationController, animated: true)
    }
}
