//
//  HomePageViewController.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/7/24.
//

import UIKit
import FirebaseAuth

class HomePageViewController: UIViewController {

    var currentUser: FirebaseAuth.User?
    let homeView = HomePageView()
    let notificationCenter = NotificationCenter.default
    var selectedDates = [DateComponents]()
    var selectedInterests = [String]()
    var selectedPersonality: String?
    let cities = Categories.cities
    var selectedCity = "Boston"
        
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeView.tabBar.delegate = self
        self.updateLinePosition()
        self.updateLocation(selectedCity)
        
        if self.homeView.tabBar.selectedItem?.tag == 0 {
            self.updateFilterConstraints(showFilters: false)
        }
        
        updateLocationLabel(self.selectedCity)
        
        self.homeView.locationArrowButton.addTarget(self, action: #selector(onLocationButtonTapped), for: .touchUpInside)
        self.homeView.buttonDateFilter.addTarget(self, action: #selector(onButtonDateFilterTapped), for: .touchUpInside)
        self.homeView.buttonCategoryFilter.addTarget(self, action: #selector(onButtonCategoryFilterTapped), for: .touchUpInside)
        
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForDatesSelected(notification:)),
            name: .datesToFilterSelected,
            object: nil)
        
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForInterestsSelected(notification:)),
            name: .interestsToFilterSelected,
            object: nil)
        
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForPersonalitySelected(notification:)),
            name: .personalityToFilterSelected,
            object: nil)
        
        let barText = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(onLogOutBarButtonTapped)
        )
        
        navigationItem.rightBarButtonItem = barText
        
        self.homeView.dummyLabel.text = self.currentUser?.email
        
    }
    
    @objc func onLogOutBarButtonTapped(){
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?",
            preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
                }catch{
                    print("Error occured!")
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateLinePosition()
    }
    
    @objc private func onLocationButtonTapped() {
        var menuItems = [UIAction]()
        for city in cities {
            let action = UIAction(title: city, handler: { [weak self] _ in
                self?.updateLocation(city)
            })
            menuItems.append(action)
        }
        
        let menu = UIMenu(title: "Choose a new city", children: menuItems)
        self.homeView.locationArrowButton.menu = menu
        self.homeView.locationArrowButton.showsMenuAsPrimaryAction = true
    }
    
    private func updateLocation(_ city: String) {
        updateLocationLabel(city)
        self.selectedCity = city
    }
    
    private func updateLocationLabel(_ city: String) {
        let symbolAttachment = NSTextAttachment()
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular, scale: .default)
        symbolAttachment.image = UIImage(systemName: "mappin", withConfiguration: config)?.withTintColor(.myDarkPurple, renderingMode: .alwaysOriginal)
        symbolAttachment.bounds = CGRect(x: 0, y: -2, width: 16, height: 16)
        
        let symbolString = NSAttributedString(attachment: symbolAttachment)
        
        let textString = NSAttributedString(string: "Your Location: \(city)", attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.myDarkPurple
        ])
        
        let combinedString = NSMutableAttributedString()
        combinedString.append(symbolString)
        combinedString.append(textString)
        
        self.homeView.locationLabel.attributedText = combinedString
    }

}

// functions dealing with switching tabs
extension HomePageViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.updateLinePosition()
        self.updateFilterConstraints(showFilters: item.tag == 1)
    }
    
    func updateLinePosition() {
        guard let items = self.homeView.tabBar.items else { return }
        guard let selectedItem = self.homeView.tabBar.selectedItem else { return }
        guard let index = items.firstIndex(of: selectedItem) else { return }

        let tabBarWidth = self.homeView.tabBar.frame.width / CGFloat(items.count)
        let xPosition = CGFloat(index) * tabBarWidth + (tabBarWidth / 3)
        let lineHeight: CGFloat = 1.5
        let yPosition = self.homeView.tabBar.frame.height + lineHeight + self.homeView.safeAreaInsets.top + self.homeView.locationLabel.frame.height + 16

        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.homeView.tabUnderline.frame = CGRect(
                x: xPosition,
                y: yPosition,
                width: tabBarWidth / 3,
                height: lineHeight
            )
        }
    }
    
    func updateFilterConstraints(showFilters: Bool){
        if showFilters {
            self.homeView.buttonDateFilter.isHidden = false
            self.homeView.buttonCategoryFilter.isHidden = false
            self.homeView.buttonDateFilter.isEnabled = true
            self.homeView.buttonCategoryFilter.isEnabled = true
            self.homeView.filterButtonsHeightConstraint.constant = 35
        } else {
            self.homeView.buttonDateFilter.isHidden = true
            self.homeView.buttonCategoryFilter.isHidden = true
            self.homeView.buttonDateFilter.isEnabled = false
            self.homeView.buttonCategoryFilter.isEnabled = false
            self.homeView.filterButtonsHeightConstraint.constant = 0
        }
        self.homeView.layoutIfNeeded()
    }
}

