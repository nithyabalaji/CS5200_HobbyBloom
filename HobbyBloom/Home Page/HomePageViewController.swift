//
//  HomePageViewController.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/7/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class HomePageViewController: UIViewController {
    var currentUser: FirebaseAuth.User?
    let homeView = HomePageView()
    let notificationCenter = NotificationCenter.default
    var selectedDates = [DateComponents]()
    var selectedInterests = [String]()
    var selectedPersonality: String?
    let cities = Categories.cities
    var selectedCity = "Boston"
    var activities: [Activity] = []
    var filteredActivities: [Activity] = []
        
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
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForInterestsSelected(notification:)),
            name: .interestsToFilterSelected,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForPersonalitySelected(notification:)),
            name: .personalityToFilterSelected,
            object: nil
        )
        
        fetchUserPreferences() // Fetch user preferences for "For You"
        fetchActivities() // Fetch activities
        self.homeView.tableView.delegate = self
        self.homeView.tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateLinePosition()
    }
    
    // MARK: - Fetch Activities
    func fetchActivities() {
        print("Fetching activities")
        let db = Firestore.firestore()
        db.collection("activities").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching activities: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No activities found in Firebase")
                return
            }
            
            self.activities = documents.compactMap { document in
                do {
                    let activity = try document.data(as: Activity.self)
                    print("Fetched activity: \(activity)")
                    return activity
                } catch {
                    print("Error decoding activity: \(error)")
                    return nil
                }
            }
            
            print("Total activities fetched: \(self.activities.count)")
            self.filterActivities() // Apply filters after fetching activities
        }
    }
    
    // MARK: - Fetch User Preferences
    func fetchUserPreferences() {
        guard let user = Auth.auth().currentUser else { return }
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching user preferences: \(error.localizedDescription)")
                return
            }
            guard let data = snapshot?.data() else { return }
            self.selectedInterests = data["interests"] as? [String] ?? []
            self.selectedPersonality = (data["personality"] as? [String])?.first
            self.filterActivities() // Reapply filters after fetching preferences
        }
    }
    
    func filterActivities() {
        if self.homeView.tabBar.selectedItem?.tag == 0 {
            // "For You" Tab
            filteredActivities = activities.filter { activity in
                (selectedPersonality != nil && activity.personality_tags.contains(selectedPersonality ?? "")) ||
                !Set(activity.interest_tags).isDisjoint(with: selectedInterests)
            }
        } else {
            // "All Events" Tab
            filteredActivities = activities.filter { activity in
                (selectedDates.isEmpty || selectedDates.contains(activity.dateComponents)) &&
                (selectedInterests.isEmpty || !Set(activity.interest_tags).isDisjoint(with: selectedInterests))
            }
            if selectedDates.isEmpty && selectedInterests.isEmpty {
                filteredActivities = activities // Show all events if no filters are applied
            }
        }
        print("Filtered Activities: \(filteredActivities)")
        self.homeView.tableView.reloadData()
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
// MARK: - UITabBarDelegate
extension HomePageViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.updateLinePosition()
        self.updateFilterConstraints(showFilters: item.tag == 1)
        self.filterActivities() // Reapply filters when switching tabs
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
    
    func updateFilterConstraints(showFilters: Bool) {
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
// MARK: - UITableViewDelegate and UITableViewDataSource
extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredActivities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.reuseIdentifier, for: indexPath) as! ActivityCell
        let activity = self.filteredActivities[indexPath.row]
        cell.configure(with: activity)
        return cell
    }
}
