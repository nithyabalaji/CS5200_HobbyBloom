//
//  CategoryFilterView.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/21/24.
//

import UIKit

class CategoryFilterView: UIView {

    var selectCategoryLabel: UILabel!
    var clearAllButton: UIButton!
    var filterButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupSelectDatesLabel()
        setupClearAllButton()
        setupFilterButton()
        
        initConstraints()
    }
    
    func setupSelectDatesLabel() {
        selectCategoryLabel = UILabel()
        selectCategoryLabel.text = "Select Category"
        selectCategoryLabel.font = UIFont.boldSystemFont(ofSize: 22)
        self.addSubviewToView(subview: selectCategoryLabel)
    }
    
    func setupClearAllButton() {
        clearAllButton = UIButton(type: .system)
        clearAllButton.setTitle("Clear all", for: .normal)
        clearAllButton.tintColor = .myDarkPurple
        clearAllButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubviewToView(subview: clearAllButton)
    }
    
    func setupFilterButton() {
        filterButton = UIButton(type: .roundedRect)
        filterButton.setTitle("Filter", for: .normal)
        filterButton.backgroundColor = .myDarkPurple
        filterButton.tintColor = .white
        filterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        filterButton.layer.cornerRadius = 20
        filterButton.layer.masksToBounds = true
        filterButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 30,bottom: 10,right: 30)
        self.addSubviewToView(subview: filterButton)
    }
    
    func addSubviewToView(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            selectCategoryLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            selectCategoryLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            clearAllButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            clearAllButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            filterButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            filterButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

