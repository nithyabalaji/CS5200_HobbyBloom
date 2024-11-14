//
//  HomePageViewController.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/7/24.
//

import UIKit

class HomePageViewController: UIViewController {

    let homeView = HomePageView()
        
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let logoutButton = UIBarButtonItem(title: "blah", style: .plain, target: self, action: #selector(onLogOutBarButtonTapped))
        navigationItem.rightBarButtonItem = logoutButton
        title = "Home"
    }
    
    @objc func onLogOutBarButtonTapped() {
        
    }

}
