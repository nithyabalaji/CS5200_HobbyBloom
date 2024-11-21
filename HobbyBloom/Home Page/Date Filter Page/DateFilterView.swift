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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupSelectDatesLabel()
        setupCalendarView()
        
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
    
    func addSubviewToView(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            selectDatesLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            selectDatesLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            calendarView.topAnchor.constraint(equalTo: self.selectDatesLabel.bottomAnchor, constant: 16),
            calendarView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            
        ])
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
