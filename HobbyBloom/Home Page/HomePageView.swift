//
//  HomePageView.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/7/24.
//

import UIKit
class HomePageView: UIView {
    
    var locationLabel: UILabel!
    var locationArrowButton: UIButton!
    var tabBar: UITabBar!
    var tabUnderline: UIView!
    var filterButtonsView: UIView!
    var buttonDateFilter: UIButton!
    var buttonCategoryFilter: UIButton!
    var filterButtonsLine: UIView!
    var tableView: UITableView!
    var filterButtonsHeightConstraint: NSLayoutConstraint!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLocationButton()
        setupTabBar()
        setupTabUnderline()
        setupFilterButtonsView()
  
        setupTableView()
        initConstraints()
    }
    
    
    func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = true
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(ActivityCell.self, forCellReuseIdentifier: ActivityCell.reuseIdentifier)
        addSubview(tableView)
    }
    
    func setupLocationButton() {
        locationLabel = UILabel()
        addSubviewToView(subview: locationLabel)
        
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular, scale: .default)
        locationArrowButton = UIButton(type: .system)
        locationArrowButton.setImage(UIImage(systemName: "chevron.down", withConfiguration: config), for: .normal)
        locationArrowButton.tintColor = .myDarkPurple
        addSubviewToView(subview: locationArrowButton)
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
        filterButtonsLine = UIView()
        filterButtonsLine.backgroundColor = .lightGray
        filterButtonsLine.translatesAutoresizingMaskIntoConstraints = false
        self.filterButtonsView.addSubview(filterButtonsLine)
    }
    
    func setupButtonDateFilter() {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular, scale: .default)
        buttonDateFilter = UIButton(type: .roundedRect)
        buttonDateFilter.setImage(UIImage(systemName: "calendar", withConfiguration: imageConfig), for: .normal)
        buttonDateFilter.setTitle("Select Dates", for: .normal)
        buttonDateFilter.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        self.setupFilterButtons(button: buttonDateFilter)
    }
    
    func setupButtonCategoryFilter() {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular, scale: .default)
        buttonCategoryFilter = UIButton(type: .roundedRect)
        buttonCategoryFilter.setImage(UIImage(systemName: "line.3.horizontal.decrease", withConfiguration: imageConfig), for: .normal)
        buttonCategoryFilter.setTitle("Select Categories", for: .normal)
        buttonCategoryFilter.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        self.setupFilterButtons(button: buttonCategoryFilter)
    }
    
    func setupFilterButtons(button: UIButton) {
        button.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        //button.setTitleColor(.darkGray, for: .normal)
        button.tintColor = .darkGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        //button.layer.borderColor = UIColor.lightGray.cgColor
        //button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
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
            locationLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            locationArrowButton.centerYAnchor.constraint(equalTo: self.locationLabel.centerYAnchor),
            locationArrowButton.leadingAnchor.constraint(equalTo: self.locationLabel.trailingAnchor, constant: 3),
            
            tabBar.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor, constant: 16),
            tabBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 20),
            
            filterButtonsView.topAnchor.constraint(equalTo: self.tabBar.bottomAnchor, constant: 16),
            filterButtonsView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            filterButtonsView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: self.filterButtonsView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
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
            filterButtonsLine.centerXAnchor.constraint(equalTo: self.filterButtonsView.centerXAnchor),
            filterButtonsLine.topAnchor.constraint(equalTo: self.buttonDateFilter.topAnchor, constant: 4),
            filterButtonsLine.bottomAnchor.constraint(equalTo: self.buttonDateFilter.bottomAnchor, constant: -4),
            filterButtonsLine.widthAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
