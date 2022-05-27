//
//  ViewController.swift
//  YoodooMain
//
//  Created by Pardy Panda's New Mac Mini on 26/05/22.
//

import UIKit
import FSCalendar

class ViewController: UIViewController {
    
    let formatter = DateFormatter()
    let now = Date()
    var array: [Int]?
    
    @IBOutlet weak var calender: FSCalendar!
    @IBOutlet weak var timeTableView: UITableView!
    @IBOutlet weak var calenderHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var timeStampArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calender.delegate = self
        calender.dataSource = self
        
        timeTableView.delegate = self
        timeTableView.dataSource = self
        
        getCurrentMonth()
//        calculate(date: )
        
        calender.scope = .week
        calender.calendarHeaderView.removeFromSuperview()
        
        
        calender.appearance.weekdayFont = UIFont(name: "Poppins-Medium", size: 15)
        calender.appearance.titleFont = UIFont(name: "Poppins-Medium", size: 25)
        calender.appearance.borderRadius = 0.10
        calender.appearance.selectionColor = .blue.withAlphaComponent(0.5)
        calender.appearance.todayColor = .gray
        calender.appearance.weekdayTextColor = .black
        
        timeTableView.register(UINib(nibName: "TimeTableViewCell", bundle: nil), forCellReuseIdentifier: "timecell")

    }
    
    func getCurrentMonth(){


        let month = Calendar.current.component(.month, from: calender.currentPage)
        let monthName = DateFormatter().monthSymbols[month - 1]
        self.monthLabel.text = monthName
    }
    
    func calculate(date: Date) {
        timeStampArray = []
        for i in 0...24 {
            
            let oneHourAgo = Calendar.current.date(byAdding: .hour, value: i, to: date)
            if Calendar.current.isDate(date, inSameDayAs: oneHourAgo ?? Date()){
                formatter.dateFormat = "h:mm a"
                let stringDate = formatter.string(from: oneHourAgo!)
                timeStampArray.append(stringDate)
                print(timeStampArray)
            } else {
                print("Different")
            }
            
            self.timeTableView.reloadData()
        }
    }

    @IBAction func datePickerChanged(_ sender: Any) {
        print(datePicker.date)
        calculate(date: datePicker.date)
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


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeStampArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timecell") as! TimeTableViewCell
        let times = timeStampArray[indexPath.row]
        cell.timeStamp.text = times
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
