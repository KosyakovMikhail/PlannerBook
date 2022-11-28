//
//  TaskDetailsView.swift
//  PlannerBook
//

import Foundation
import UIKit

final class TaskDetailsView: UIView {
    
    private let startDatePrefix = "С"
    private let finishDatePrefix = "До"
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: FontNames.mainBold, size: 22)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var startDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont(name: FontNames.main, size: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var finishDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont(name: FontNames.main, size: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont(name: FontNames.main, size: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    func setup() {
        backgroundColor = .white
        setConstraints()
    }
    
    private func setConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        [titleLabel,
         startDateLabel,
         finishDateLabel,
         descriptionLabel].forEach {
            containerView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { maker in
            maker.edges.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        startDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        finishDateLabel.snp.makeConstraints { make in
            make.top.equalTo(startDateLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(finishDateLabel.snp.bottom).offset(18)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview()
        }
    }
    
    func setupData(title: String,
                   description: String,
                   startDate: Date,
                   finishDate: Date) {
        titleLabel.text = title
        descriptionLabel.text = description
        startDateLabel.text = getDateText(date: startDate, prefix: startDatePrefix)
        finishDateLabel.text = getDateText(date: finishDate, prefix: finishDatePrefix)
    }
    
    private func getDateText(date: Date, prefix: String) -> String {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_RU")
        
        let hour = calendar.component(.hour, from: date)
        var hourString = String(hour)
        if hour >= 0 && hour <= 9 {
            hourString = "0\(hourString)"
        }
        if hourString == "0" {
            hourString = "00"
        }
        
        let minute = calendar.component(.minute, from: date)
        var minutesString = String(calendar.component(.minute, from: date))
        if minute >= 0 && minute <= 9 {
            minutesString = "0\(minutesString)"
        }
        
        var timeString = "\(hourString):\(minutesString)"
        
        var dateComponents = DateComponents()
        dateComponents.year = calendar.component(.year, from: date)
        dateComponents.month = calendar.component(.month, from: date)
        dateComponents.day = calendar.component(.day, from: date)
        dateComponents.weekday = calendar.component(.weekday, from: date)
        
        let dayString = String(calendar.component(.day, from: date))
        var weekDayString = ""
        if let weekDayNumber = dateComponents.weekday {
            weekDayString = calendar.weekdaySymbols[weekDayNumber-1]
        }
        var monthString = ""
        if let monthNumber = dateComponents.month {
            monthString = calendar.monthSymbols[monthNumber-1]
        }
        var yearStringWithSpaces = ""
        yearStringWithSpaces = " \(String(calendar.component(.year, from: date)))"
        
//        timeString = "\(prefix) \(dayString) \(monthString)\(yearStringWithSpaces), \(timeString), \(weekDayString) "
        timeString = "\(prefix) \(timeString) \(weekDayString), \(dayString) \(monthString)\(yearStringWithSpaces)"

        return timeString
    }
}
