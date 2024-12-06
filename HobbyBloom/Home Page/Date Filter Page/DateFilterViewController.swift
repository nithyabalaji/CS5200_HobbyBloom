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
    var datesSelected = [DateComponents]()
    var completionHandler: (([DateComponents]) -> Void)? // Completion handler to return selected dates
    
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
        completionHandler?(datesSelected) // Call the completion handler with selected dates
        self.dismiss(animated: true)
    }
    
    @objc func clearSelection() {
        selectionBehavior.setSelectedDates([], animated: true)
        datesSelected.removeAll()
    }
    
    func setCalendarViewSelection() {
        selectionBehavior = UICalendarSelectionMultiDate(delegate: self)
        dateFilterView.calendarView.selectionBehavior = selectionBehavior
        for date in datesSelected {
            multiDateSelection(selectionBehavior, didSelectDate: date)
        }
    }
}

extension DateFilterViewController: UICalendarSelectionMultiDateDelegate {
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        selectionBehavior.selectedDates.append(dateComponents)
        if !datesSelected.contains(dateComponents) {
            datesSelected.append(dateComponents)
        }
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        datesSelected.removeAll(where: { $0 == dateComponents })
    }
}
