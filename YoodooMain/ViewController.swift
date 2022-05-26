//
//  ViewController.swift
//  YoodooMain
//
//  Created by Pardy Panda's New Mac Mini on 26/05/22.
//

import UIKit
import FSCalendar

class ViewController: UIViewController {
    
    @IBOutlet weak var calender: FSCalendar!
    @IBOutlet weak var calenderHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var monthLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calender.delegate = self
        calender.dataSource = self
        
        getCurrentMonth()
        
        calender.scope = .week
        calender.calendarHeaderView.removeFromSuperview()
        
        
        calender.appearance.weekdayFont = UIFont(name: "Poppins-Medium", size: 15)
        calender.appearance.titleFont = UIFont(name: "Poppins-Medium", size: 25)
        calender.appearance.borderRadius = 0.10
        calender.appearance.selectionColor = .blue.withAlphaComponent(0.5)
        calender.appearance.todayColor = .gray
        calender.appearance.weekdayTextColor = .black

    }
    
    func getCurrentMonth(){


        let month = Calendar.current.component(.month, from: calender.currentPage)
        let monthName = DateFormatter().monthSymbols[month - 1]
        self.monthLabel.text = monthName
    }


}

extension ViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        getCurrentMonth()
    }
        
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calenderHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
    }
    
}

