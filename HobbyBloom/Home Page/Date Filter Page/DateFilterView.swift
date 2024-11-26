//
//  DateFilterView.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/20/24.
//

import UIKit

class DateFilterView: UIView {

    var selectDatesLabel: UILabel!
    var calendarView: UICalendarView!
    var clearAllButton: UIButton!
    var filterButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupSelectDatesLabel()
        setupCalendarView()
        setupClearAllButton()
        setupFilterButton()
        
        initConstraints()
    }
    
    func setupSelectDatesLabel() {
        selectDatesLabel = UILabel()
        selectDatesLabel.text = "Select Dates"
        selectDatesLabel.font = UIFont.boldSystemFont(ofSize: 22)
        self.addSubviewToView(subview: selectDatesLabel)
    }
    
    func setupCalendarView() {
        calendarView = UICalendarView()
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.tintColor = .myLightPurple
        calendarView.availableDateRange = DateInterval(start: .now, end: .distantFuture)

        self.addSubviewToView(subview: calendarView)
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
    
    func her() {
        //self.calendarView.selectionBehavior.sele
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            selectDatesLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            selectDatesLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            calendarView.topAnchor.constraint(equalTo: self.selectDatesLabel.bottomAnchor, constant: 16),
            calendarView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            
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
