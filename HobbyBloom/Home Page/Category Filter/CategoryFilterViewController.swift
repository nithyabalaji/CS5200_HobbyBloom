//
//  CategoryFilterViewController.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/21/24.
//


import UIKit

class CategoryFilterViewController: UIViewController {
    
    let categoryFilterView = CategoryFilterView()
    var allInterests = [String]()
    var allPersonalities = [String]()
    var selectedInterests = [String]()
    var selectedPersonality: String?
    var completionHandler: (([String], String?) -> Void)? // Completion handler to return selected interests and personality
    
    override func loadView() {
        view = categoryFilterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllCategories()
        categoryFilterView.filterButton.addTarget(self, action: #selector(finishSelecting), for: .touchUpInside)
        categoryFilterView.clearAllButton.addTarget(self, action: #selector(clearSelection), for: .touchUpInside)
        
        categoryFilterView.interestsCollectionView.dataSource = self
        categoryFilterView.interestsCollectionView.delegate = self
        categoryFilterView.personalityCollectionView.dataSource = self
        categoryFilterView.personalityCollectionView.delegate = self
    }
    
    func getAllCategories() {
        allInterests.append(contentsOf: Categories.interests)
        allPersonalities.append(contentsOf: Categories.personality)
    }
    
    @objc func finishSelecting() {
        completionHandler?(selectedInterests, selectedPersonality) // Call the completion handler
        self.dismiss(animated: true)
    }
    
    @objc func clearSelection() {
        selectedInterests.removeAll()
        categoryFilterView.interestsCollectionView.reloadData()
        selectedPersonality = nil
        categoryFilterView.personalityCollectionView.reloadData()
    }
}

extension CategoryFilterViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryFilterView.interestsCollectionView {
            return allInterests.count
        } else {
            return allPersonalities.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCategoriesCell", for: indexPath) as! FilterCategoriesCell
        
        if collectionView == categoryFilterView.interestsCollectionView {
            let categoryName = allInterests[indexPath.row]
            cell.configure(tag: categoryName)
            if selectedInterests.contains(categoryName) {
                cell.label.backgroundColor = .myPurple
                cell.label.textColor = .white
            } else {
                cell.label.backgroundColor = .white
                cell.label.textColor = .myPurple
            }
        } else {
            let categoryName = allPersonalities[indexPath.row]
            cell.configure(tag: categoryName)
            if let personality = selectedPersonality, personality == categoryName {
                cell.label.backgroundColor = .myPurple
                cell.label.textColor = .white
            } else {
                cell.label.backgroundColor = .white
                cell.label.textColor = .myPurple
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryFilterView.interestsCollectionView {
            let categoryName = allInterests[indexPath.row]
            if selectedInterests.contains(categoryName) {
                selectedInterests.removeAll(where: { $0 == categoryName })
            } else if selectedInterests.count < 5 {
                selectedInterests.append(categoryName)
            }
        } else {
            let categoryName = allPersonalities[indexPath.row]
            if selectedPersonality == categoryName {
                selectedPersonality = nil
            } else {
                selectedPersonality = categoryName
            }
        }
        collectionView.reloadData()
    }
}
