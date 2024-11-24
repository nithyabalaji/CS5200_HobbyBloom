//
//  DateFilterViewController.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/20/24.
//

import UIKit

class DateFilterViewController: UIViewController {
    
    let dateFilterView = DateFilterView()
    let notificationCenter = NotificationCenter.default
    var selectionBehavior: UICalendarSelectionMultiDate!
    var datesSelected = [DateComponents]()
    
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
        notificationCenter.post(
            name: .datesToFilterSelected,
            object: self.datesSelected)
        self.dismiss(animated: true)
    }
    
    @objc func clearSelection() {
        selectionBehavior.setSelectedDates([], animated: true)
        self.datesSelected.removeAll()
    }
    
    
    func setCalendarViewSelection() {
        selectionBehavior = UICalendarSelectionMultiDate(delegate: self)
        self.dateFilterView.calendarView.selectionBehavior = selectionBehavior
        for date in self.datesSelected {
            self.multiDateSelection(selectionBehavior, didSelectDate: date)
        }
    }

}

extension DateFilterViewController: UICalendarSelectionMultiDateDelegate {
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        selectionBehavior.selectedDates.append(dateComponents)
        if !self.datesSelected.contains(dateComponents) {
            self.datesSelected.append(dateComponents)
        }
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        self.datesSelected.removeAll(where: { $0 == dateComponents })
    }
    
}
