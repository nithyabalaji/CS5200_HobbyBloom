//
//  HomePageView.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/7/24.
//

import UIKit

class HomePageView: UIView {
    
    var tabBar: UITabBar!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTabBar()
        
        initConstraints()
    }
    
    func setupTabBar() {
        tabBar = UITabBar()
        let forYouTab = UITabBarItem(title: "For You", image: nil, tag: 0)
        let allEventsTab = UITabBarItem(title: "All Events", image: nil, tag: 1)
        self.setupTabBarItem(forYouTab)
        self.setupTabBarItem(allEventsTab)
        tabBar.items = [forYouTab, allEventsTab]
        
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.gray.cgColor
        tabBar.backgroundColor = .systemPurple
        tabBar.tintColor = .systemRed
        tabBar.selectedItem = forYouTab
        self.addSubviewToView(subview: tabBar)
    }
    
    func setupTabBarItem(_ item: UITabBarItem) {
        item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
    }
    
    func addSubviewToView(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
    }
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            //profilePic.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8)
            tabBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tabBar.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
