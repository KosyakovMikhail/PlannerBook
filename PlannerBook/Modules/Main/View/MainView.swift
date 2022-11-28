//
//  MainView.swift
//  PlannerBook
//

import UIKit
import FSCalendar

final class MainView: UIView {
    
    private let showHideButtonTitle = "Раскрыть календарь"
    
    var calendarHeightConstraint: NSLayoutConstraint!
    
    lazy var calendarView: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()

    lazy var showHideButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(showHideButtonTitle, for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont(name: FontNames.mainBold, size: 14)
        return button
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            MainTableViewCell.self,
            forCellReuseIdentifier: MainTableViewCell.cellIdentifier)
        tableView.register(
            TimeRangeTableViewCell.self,
            forCellReuseIdentifier: TimeRangeTableViewCellModel.cellIdentifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    func setup() {
        backgroundColor = .white
        setConstraints()
    }
    
    private func setConstraints() {
        [calendarView,
         showHideButton,
         tableView].forEach {
            addSubview($0)
        }
        
        calendarView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(90)
        }
        
        calendarHeightConstraint = NSLayoutConstraint(
            item: calendarView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 300)
        calendarView.addConstraint(calendarHeightConstraint)
        
        showHideButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(calendarView.snp.bottom)
            make.width.equalTo(140)
            make.height.equalTo(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(showHideButton.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
