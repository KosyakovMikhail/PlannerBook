//
//  ViewController.swift
//  PlannerBook
//
//  Created by Macos on 22.11.2022.
//

import UIKit
import FSCalendar
import SnapKit
import RealmSwift

class MainViewController: UIViewController {
    
    var calendarHeightContraint: NSLayoutConstraint!
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    
    let showHideButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open calendar", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        button.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let idTaskCell = "idTaskCell"
    
    let localRealm = try! Realm()
    var taskModel: Results<TaskModel>!
    
// MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        title = "Planner Book"
        
        taskModel = localRealm.objects(TaskModel.self)
        
        navigationController?.navigationBar.titleTextAttributes =
        [.foregroundColor: UIColor.black,
         .font: UIFont(name: "Arial-BoldMT", size: 20) ?? "nil"]

        calendar.delegate = self
        calendar.dataSource = self
        calendar.scope = .week
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: idTaskCell)
        
        setConstraints()
        swipeAction()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToNewTaskController))
    }

// MARK: - Objc Methods
    
    @objc func goToNewTaskController() {
        let newTaskPage = NewTask()
        navigationController?.pushViewController(newTaskPage, animated: true)
    }
    
    @objc func showHideButtonTapped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideButton.setTitle("Close calendar", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideButton.setTitle("Open Calendar", for: .normal)
        }
        
    }
    
    @objc func swipe(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case .up:
            showHideButtonTapped()
        case .down:
            showHideButtonTapped()
        default:
            break
        }
    }
    
// MARK: - SwipeGentureRecognizer
    
    func swipeAction() {
        
        let swipeUp  = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
    }
   
}

// MARK: - FSCalendarDataSource, FSCalendarDelegate

extension MainViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightContraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else { return }
        print(weekday)
        
//        let predicateRepeat = NSPredicate(format: "", <#T##args: CVarArg...##CVarArg#>)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTaskCell,
                                                 for: indexPath) as! MainTableViewCell
        switch indexPath.row {
        case 0: cell.backgrounViewCell.backgroundColor = .cyan
        case 1: cell.backgrounViewCell.backgroundColor = .lightGray
        case 2: cell.backgrounViewCell.backgroundColor = .green
        case 3: cell.backgrounViewCell.backgroundColor = .blue
        default:
            cell.backgroundColor = .white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

// MARK: - SetConstraints

extension MainViewController {
    
    func setConstraints() {
        
        view.addSubview(calendar)
        calendar.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().inset(90)
//            make.height.equalTo(300)
        }
        calendarHeightContraint = NSLayoutConstraint(item: calendar,
                                                     attribute: .height,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1,
                                                     constant: 300)
        calendar.addConstraint(calendarHeightContraint)
        
        view.addSubview(showHideButton)
        showHideButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(calendar.snp.bottom)
            make.width.equalTo(100)
            make.height.equalTo(20)
//            make.height.equalTo(300)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview()
            make.top.equalTo(showHideButton.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
        
    }
    
}

extension MainViewController {

    enum MainTableCellIndentifiers: String {
        case todoItem
        case hourSeparator
    }
}
