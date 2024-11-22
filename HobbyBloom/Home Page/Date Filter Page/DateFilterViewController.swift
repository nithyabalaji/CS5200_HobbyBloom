//
//  DateFilterViewController.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/20/24.
//

import UIKit

class DateFilterViewController: UIViewController {
    
    let dateFilterView = DateFilterView()
    var selectionBehavior: UICalendarSelectionMultiDate!
    var selectedDates = [DateComponents]()
    
    override func loadView() {
        view = dateFilterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setCalendarViewSelection()
        dateFilterView.filterButton.addTarget(self, action: #selector(finishSelecting), for: .touchUpInside)
        dateFilterView.clearAllButton.addTarget(self, action: #selector(clearSelection), for: .touchUpInside)
    }
    
    @objc func finishSelecting() {
        print(selectionBehavior.selectedDates)
        self.dismiss(animated: true)
    }
    
    @objc func clearSelection() {
        selectionBehavior.setSelectedDates([], animated: true)
    }
    
    
    func setCalendarViewSelection() {
        selectionBehavior = UICalendarSelectionMultiDate(delegate: self)
        self.dateFilterView.calendarView.selectionBehavior = selectionBehavior
    }

}

extension DateFilterViewController: UICalendarSelectionMultiDateDelegate {
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        //selectedDates.append(dateComponents)
        return
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        //selectedDates.removeAll(where: { $0 == dateComponents } )
        //print(selectedDates)
        return
    }
    
}
