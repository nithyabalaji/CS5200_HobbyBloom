//
//  HomePageView.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/7/24.
//

import UIKit

class HomePageView: UIView {
    
    var tabBar: UITabBar!
    var tabUnderline: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTabBar()
        setupTabUnderline()
        
        initConstraints()
    }
    
    func setupTabBar() {
        tabBar = UITabBar()
        let forYouTab = UITabBarItem(title: "For You", image: nil, tag: 0)
        let allEventsTab = UITabBarItem(title: "All Events", image: nil, tag: 1)
        self.setupTabBarItem(forYouTab)
        self.setupTabBarItem(allEventsTab)
        tabBar.items = [forYouTab, allEventsTab]
        
        tabBar.layer.borderWidth = 0
        tabBar.tintColor = .systemRed
        //tabBar.backgroundColor = .blue
        //tabBar.unselectedItemTintColor = .green
        tabBar.isTranslucent = false
        tabBar.selectedItem = forYouTab
        
        self.addSubviewToView(subview: tabBar)
    }
    
    func setupTabBarItem(_ item: UITabBarItem) {
        item.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 16)], for: .normal)
        //item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
    }
    
    func setupTabUnderline() {
        tabUnderline = UIView()
        tabUnderline.backgroundColor = .red 
        self.addSubviewToView(subview: tabUnderline)
    }
    
    func addSubviewToView(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
    }
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            tabBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tabBar.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
