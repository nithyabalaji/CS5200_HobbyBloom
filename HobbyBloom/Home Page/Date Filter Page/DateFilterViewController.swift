//
//  DateFilterViewController.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/20/24.
//

import UIKit

class DateFilterViewController: UIViewController {
    
    let dateFilterView = DateFilterView()
    
    override func loadView() {
        view = dateFilterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setCalendarViewSelection()
    }
    
    func setCalendarViewSelection() {
        let multiSelect = UICalendarSelectionMultiDate(delegate: self)
        self.dateFilterView.calendarView.selectionBehavior = multiSelect
    }

}

extension DateFilterViewController: UICalendarSelectionMultiDateDelegate {
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        //print(dateComponents)
        return
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        //print("deselect")
        //print(dateComponents)
        return
    }
    
    
    
}
