
//
//  FilterButtonsManager.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/24/24.
//
import UIKit
// code for handling the filter buttons
extension HomePageViewController {
    @objc func onButtonDateFilterTapped() {
        let dateFilterController = DateFilterViewController()
        dateFilterController.datesSelected = self.selectedDates
                
        dateFilterController.modalPresentationStyle = .pageSheet
        
        if let dateFilterSheet = dateFilterController.sheetPresentationController {
            dateFilterSheet.detents = [.large()]
            dateFilterSheet.prefersGrabberVisible = true
        }
        
        present(dateFilterController, animated: true)
    }
    
    @objc func onButtonCategoryFilterTapped() {
        let categoryFilterController = CategoryFilterViewController()
        categoryFilterController.selectedInterests = self.selectedInterests
        categoryFilterController.selectedPersonality = self.selectedPersonality
                
        categoryFilterController.modalPresentationStyle = .pageSheet
        
        if let categoryFilterSheet = categoryFilterController.sheetPresentationController {
            categoryFilterSheet.detents = [.large()]
            categoryFilterSheet.prefersGrabberVisible = true
        }
        
        present(categoryFilterController, animated: true)
    }
    
    @objc func notificationReceivedForDatesSelected(notification: Notification){
        self.selectedDates = (notification.object as! [DateComponents])
        self.updateDateFilterButtonView()
        self.filterActivities()
    }
    
    func updateDateFilterButtonView() {
        if self.selectedDates.count > 0 {
            self.homeView.buttonDateFilter.layer.borderColor = UIColor.myPurple.cgColor
            self.homeView.buttonDateFilter.backgroundColor = .myPurple
            self.homeView.buttonDateFilter.setTitle("Dates Selected", for: .normal)
            self.homeView.buttonDateFilter.tintColor = .white
        } else {
            self.homeView.buttonDateFilter.layer.borderColor = UIColor.lightGray.cgColor
            self.homeView.buttonDateFilter.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
            self.homeView.buttonDateFilter.setTitle("Select Dates", for: .normal)
            self.homeView.buttonDateFilter.tintColor = .darkGray
        }
    }
    
    @objc func notificationReceivedForInterestsSelected(notification: Notification){
        self.selectedInterests = (notification.object as! [String])
        self.updateCategoriesFilterButtonView()
        self.filterActivities()
    }
    
    @objc func notificationReceivedForPersonalitySelected(notification: Notification){
        self.selectedPersonality = (notification.object as! String?)
        self.updateCategoriesFilterButtonView()
        self.filterActivities()
    }
    
    func updateCategoriesFilterButtonView() {
        if self.selectedPersonality != nil || self.selectedInterests.count > 0 {
            self.homeView.buttonCategoryFilter.layer.borderColor = UIColor.myPurple.cgColor
            self.homeView.buttonCategoryFilter.backgroundColor = .myPurple
            self.homeView.buttonCategoryFilter.setTitle("Categories Selected", for: .normal)
            self.homeView.buttonCategoryFilter.tintColor = .white
        } else {
            self.homeView.buttonCategoryFilter.layer.borderColor = UIColor.lightGray.cgColor
            self.homeView.buttonCategoryFilter.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
            self.homeView.buttonCategoryFilter.setTitle("Select Categories", for: .normal)
            self.homeView.buttonCategoryFilter.tintColor = .darkGray
        }
    }
}
