//
//  HomePageView.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/7/24.
//

import UIKit

class HomePageView: UIView {
    
    var locationButton: UIButton!
    var tabBar: UITabBar!
    var tabUnderline: UIView!
    var filterButtonsView: UIView!
    var buttonDateFilter: UIButton!
    var buttonCategoryFilter: UIButton!
    var dummyLabel: UILabel!
    var filterButtonsHeightConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLocationButton()
        setupTabBar()
        setupTabUnderline()
        setupFilterButtonsView()
        
        dummyLabel = UILabel()
        dummyLabel.text = "HELLOOOOOOO"
        self.addSubviewToView(subview: dummyLabel)
        
        initConstraints()
    }
    
    func setupLocationButton() {
        locationButton = UIButton(type: .system)
        locationButton.setImage(UIImage(systemName: "mappin"), for: .normal)
        locationButton.tintColor = .myDarkPurple
        locationButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        addSubviewToView(subview: locationButton)
    }
    
    func setupTabBar() {
        tabBar = UITabBar()
        let forYouTab = UITabBarItem(title: "For You", image: nil, tag: 0)
        let allEventsTab = UITabBarItem(title: "All Events", image: nil, tag: 1)
        self.setupTabBarItem(forYouTab)
        self.setupTabBarItem(allEventsTab)
        tabBar.items = [forYouTab, allEventsTab]
        
        //tabBar.layer.borderWidth = 0
        tabBar.tintColor = .myRed
        //tabBar.backgroundColor = .blue
        //tabBar.unselectedItemTintColor = .green
        tabBar.clipsToBounds = true
        tabBar.isTranslucent = false
        tabBar.selectedItem = forYouTab
        
        self.addSubviewToView(subview: tabBar)
    }
    
    func setupTabBarItem(_ item: UITabBarItem) {
        item.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16, weight: .semibold)], for: .normal)
        //item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
    }
    
    func setupTabUnderline() {
        tabUnderline = UIView()
        tabUnderline.backgroundColor = .myRed
        self.addSubviewToView(subview: tabUnderline)
    }
    
    func setupFilterButtonsView() {
        filterButtonsView = UIView()
        self.addSubviewToView(subview: filterButtonsView)
        setupButtonDateFilter()
        setupButtonCategoryFilter()
    }
    
    func setupButtonDateFilter() {
        buttonDateFilter = UIButton(type: .roundedRect)
        buttonDateFilter.setImage(UIImage(systemName: "calendar"), for: .normal)
        buttonDateFilter.setTitle("Select Dates", for: .normal)
        self.setupFilterButtons(button: buttonDateFilter)
    }
    
    func setupButtonCategoryFilter() {
        buttonCategoryFilter = UIButton(type: .roundedRect)
        buttonCategoryFilter.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
        buttonCategoryFilter.setTitle("Select Categories", for: .normal)
        self.setupFilterButtons(button: buttonCategoryFilter)
    }
    
    func setupFilterButtons(button: UIButton) {
        button.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        //button.setTitleColor(.darkGray, for: .normal)
        button.tintColor = .darkGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        //button.layer.cornerRadius = 10
        //button.layer.masksToBounds = true
        //button.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.filterButtonsView.addSubview(button)
    }
    
    func addSubviewToView(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
    }
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            locationButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            
            tabBar.topAnchor.constraint(equalTo: self.locationButton.bottomAnchor, constant: 16),
            tabBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 20),
            
            filterButtonsView.topAnchor.constraint(equalTo: self.tabBar.bottomAnchor, constant: 16),
            filterButtonsView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            filterButtonsView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            filterButtonsView.heightAnchor.constraint(equalToConstant: 32),
            
            dummyLabel.topAnchor.constraint(equalTo: self.filterButtonsView.bottomAnchor, constant: 32),
            dummyLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32)
        ])
        
        constraintsForFilters()
        filterButtonsHeightConstraint = filterButtonsView.heightAnchor.constraint(equalToConstant: 35)
        filterButtonsHeightConstraint.isActive = true
    }
    
    func constraintsForFilters() {
        NSLayoutConstraint.activate([
            buttonDateFilter.topAnchor.constraint(equalTo: self.filterButtonsView.topAnchor),
            buttonDateFilter.bottomAnchor.constraint(equalTo: self.filterButtonsView.bottomAnchor),
            buttonDateFilter.leadingAnchor.constraint(equalTo: self.filterButtonsView.leadingAnchor, constant: 32),
            buttonDateFilter.trailingAnchor.constraint(equalTo: self.filterButtonsView.centerXAnchor),
            buttonCategoryFilter.topAnchor.constraint(equalTo: self.buttonDateFilter.topAnchor),
            buttonCategoryFilter.leadingAnchor.constraint(equalTo: self.buttonDateFilter.trailingAnchor),
            buttonCategoryFilter.trailingAnchor.constraint(equalTo: self.filterButtonsView.trailingAnchor, constant: -32),
            buttonDateFilter.heightAnchor.constraint(equalTo: buttonCategoryFilter.heightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
