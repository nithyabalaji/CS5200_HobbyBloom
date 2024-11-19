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
        
        title = "Home"
        
        self.homeView.tabBar.delegate = self
        self.updateLinePosition()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateLinePosition()
    }

}

extension HomePageViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        updateLinePosition()
    }
    
    func updateLinePosition() {
        guard let items = self.homeView.tabBar.items else { return }
        guard let selectedItem = self.homeView.tabBar.selectedItem else { return }
        guard let index = items.firstIndex(of: selectedItem) else { return }

        let tabBarWidth = self.homeView.tabBar.frame.width / CGFloat(items.count)
        let xPosition = CGFloat(index) * tabBarWidth + (tabBarWidth / 3)
        let lineHeight: CGFloat = 3.0
        let yPosition = self.homeView.tabBar.frame.height + lineHeight + self.homeView.safeAreaInsets.top

        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.homeView.tabUnderline.frame = CGRect(
                x: xPosition,
                y: yPosition,
                width: tabBarWidth / 3,
                height: lineHeight
            )
        }
    }
}

