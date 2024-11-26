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
    var interestsLabel: UILabel!
    var personalityLabel: UILabel!
    var interestsCollectionView: UICollectionView!
    var personalityCollectionView: UICollectionView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupSelectCategoriesLabel()
        setupCollectionViewLabels()
        setupCollectionViews()
        setupClearAllButton()
        setupFilterButton()
        
        initConstraints()
    }
    
    func setupSelectCategoriesLabel() {
        selectCategoryLabel = UILabel()
        selectCategoryLabel.text = "Select Categories"
        selectCategoryLabel.font = UIFont.boldSystemFont(ofSize: 22)
        self.addSubviewToView(subview: selectCategoryLabel)
    }
    
    func setupCollectionViewLabels() {
        interestsLabel = UILabel()
        interestsLabel.text = "Interests (select up to 5)"
        interestsLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.addSubviewToView(subview: interestsLabel)
        
        personalityLabel = UILabel()
        personalityLabel.text = "Personality (select up to 1)"
        personalityLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.addSubviewToView(subview: personalityLabel)
    }
    
    func setupCollectionViews() {
        self.interestsCollectionView = createCollectionView()
        self.addSubviewToView(subview: interestsCollectionView)
        self.personalityCollectionView = createCollectionView()
        self.addSubviewToView(subview: personalityCollectionView)
    }
    
    func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(FilterCategoriesCell.self, forCellWithReuseIdentifier: "FilterCategoriesCell")
        return collectionView
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
            
            interestsLabel.topAnchor.constraint(equalTo: self.selectCategoryLabel.bottomAnchor, constant: 32),
            interestsLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            interestsCollectionView.topAnchor.constraint(equalTo: self.interestsLabel.bottomAnchor, constant: 16),
            interestsCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            interestsCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            interestsCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            personalityLabel.topAnchor.constraint(equalTo: self.interestsCollectionView.bottomAnchor, constant: 32),
            personalityLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            personalityCollectionView.topAnchor.constraint(equalTo: self.personalityLabel.bottomAnchor, constant: 16),
            personalityCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            personalityCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            personalityCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            clearAllButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            clearAllButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            filterButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            filterButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            filterButton.heightAnchor.constraint(equalToConstant: 40),
            filterButton.widthAnchor.constraint(equalToConstant: 96)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FilterCategoriesCell: UICollectionViewCell {
    let label = PaddingLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .myPurple
        label.backgroundColor = .white
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.myPurple.cgColor
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
        label.padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        label.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(tag: String) {
        label.text = tag
    }
}

