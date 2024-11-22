//
//  HomePageViewController.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/7/24.
//

import UIKit

class HomePageViewController: UIViewController {

    let homeView = HomePageView()
    //let datesSelected
        
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        
        self.homeView.tabBar.delegate = self
        self.updateLinePosition()
        
        if self.homeView.tabBar.selectedItem?.tag == 0 {
            self.updateFilterConstraints(showFilters: false)
        }
        
        self.homeView.buttonDateFilter.addTarget(self, action: #selector(onButtonDateFilterTapped), for: .touchUpInside)
        self.homeView.buttonCategoryFilter.addTarget(self, action: #selector(onButtonCategoryFilterTapped), for: .touchUpInside)
        
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateLinePosition()
    }
    
    @objc func onButtonDateFilterTapped() {
        let dateFilterController = DateFilterViewController()
                
        dateFilterController.modalPresentationStyle = .pageSheet
        
        if let dateFilterSheet = dateFilterController.sheetPresentationController {
            dateFilterSheet.detents = [.large()]
            dateFilterSheet.prefersGrabberVisible = true
        }
        
        present(dateFilterController, animated: true)
    }
    
    @objc func onButtonCategoryFilterTapped() {
        let categoryFilterController = CategoryFilterViewController()
                
        categoryFilterController.modalPresentationStyle = .pageSheet
        
        if let categoryFilterSheet = categoryFilterController.sheetPresentationController {
            categoryFilterSheet.detents = [.large()]
            categoryFilterSheet.prefersGrabberVisible = true
        }
        
        present(categoryFilterController, animated: true)
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

