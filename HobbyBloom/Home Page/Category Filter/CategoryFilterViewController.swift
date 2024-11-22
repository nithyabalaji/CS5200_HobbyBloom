//
//  CategoryFilterViewController.swift
//  HobbyBloom
//
//  Created by Nithya Balaji on 11/21/24.
//

import UIKit

class CategoryFilterViewController: UIViewController {
    
    let categoryFilterView = CategoryFilterView()
    
    override func loadView() {
        view = categoryFilterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //setCalendarViewSelection()
    }

}
