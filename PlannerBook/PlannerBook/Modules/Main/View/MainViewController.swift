//
//  MainViewController.swift
//  PlannerBook
//

import UIKit
import FSCalendar
import SnapKit
import RealmSwift

class MainViewController: UIViewController {
    
    private let mainView = MainView()
    private let taskRepository: TaskRepository
    private let coordinator: MainCoordinator
    
    private let closeCalendarTitle = "Свернуть календарь"
    private let openCalendarTitle = "Раскрыть календарь"
    private let hoursCount = 24
    
    private var selectedDate: Date?
    
    private lazy var calendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_RU")
        return calendar
    }()
    
    private lazy var dateComponents: DateComponents = DateComponents()
    
    private var cellModels: [TimeRangeTableViewCellModel] = [] {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    init(taskRepository: TaskRepository?,
         coordinator: MainCoordinator?) {
        guard let taskRepository = taskRepository,
              let coordinator = coordinator
        else { fatalError("MainViewController init") }
        
        self.taskRepository = taskRepository
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("MainViewController.init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let date = mainView.calendarView.selectedDate {
            selectedDate = date
            updateTitle(for: date)
            reloadTasksData(for: date)
        } else if let date = mainView.calendarView.today {
            selectedDate = date
            updateTitle(for: date)
            reloadTasksData(for: date)
        }
    }
    
    private func setup() {
        setupNavBar()
        setupSwipeActions()
        
        mainView.setup()
        
        mainView.calendarView.delegate = self
        mainView.calendarView.dataSource = self
        mainView.calendarView.scope = .week
        mainView.calendarView.firstWeekday = 2
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.showHideButton.addTarget(
            self,
            action: #selector(showHideButtonTapped),
            for: .touchUpInside)
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: FontNames.navBarFont, size: 20) ?? UIFont.systemFont(ofSize: 20)
        ]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(transitToCreateTask)
        )
    }
    
    private func updateTitle(for date: Date) {
        title = getDayMonthString(for: date)
    }
    
    @objc private func transitToCreateTask() {
        if let date = selectedDate {
            coordinator.makeTransition(transition: .createTask(selectedDate: date))
        }
    }
    
    @objc private func showHideButtonTapped() {
        if mainView.calendarView.scope == .week {
            mainView.calendarView.setScope(.month, animated: true)
            mainView.showHideButton.setTitle(closeCalendarTitle, for: .normal)
        } else {
            mainView.calendarView.setScope(.week, animated: true)
            mainView.showHideButton.setTitle(openCalendarTitle, for: .normal)
        }
    }
    
    @objc private func swipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            showHideButtonTapped()
        case .down:
            showHideButtonTapped()
        default:
            break
        }
    }
    
    private func setupSwipeActions() {
        let swipeUp  = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeUp.direction = .up
        mainView.calendarView.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeDown.direction = .down
        mainView.calendarView.addGestureRecognizer(swipeDown)
    }
    
    private func getDefaultCellModels() -> [TimeRangeTableViewCellModel] {
        return Array(0...hoursCount).map { (hour) in
            TimeRangeTableViewCellModel(hour: hour,
                                        timeRange: getHourString(for: hour),
                                        todoItems: [])
        }
    }
    
    private func getHourString(for hour: Int) -> String {
        var hourString = String(hour)
        if hour >= 0 && hour <= 9 {
            hourString = "0\(hourString)"
        }
        if hour == hoursCount {
            hourString = "00"
        }
        return hourString + ":00"
    }
    
    private func updateCellModels(tasks: [TaskModel]) {
        var resultModels = getDefaultCellModels()
        
        for task in tasks {
            if let cellModelIndex = resultModels.firstIndex(where: {
                $0.hour == getHourComponent(date: task.startDate)
            }) {
                resultModels[cellModelIndex].todoItems.append(
                    TaskTicketModel(id: task.id,
                                        title: task.title,
                                        time: getTimeRangeString(from: task.startDate, to: task.finishDate),
                                        startHour: resultModels[cellModelIndex].hour,
                                        color: .colorFromHex(task.color),
                                        descriprion: task.subtitle))
            }
        }
        
        self.cellModels = resultModels
    }
    
    private func getHourComponent(date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: date)
    }
    
    private func getDayMonthString(for date: Date) -> String {
        dateComponents.year = calendar.component(.year, from: date)
        dateComponents.month = calendar.component(.month, from: date)
        dateComponents.day = calendar.component(.day, from: date)
        
        let dayString = String(calendar.component(.day, from: date))
        
        var monthString = ""
        if let monthNumber = dateComponents.month {
            monthString = calendar.monthSymbols[monthNumber-1]
        }
        
        return "\(dayString) \(monthString)"
    }
    
    private func getTimeRangeString(from startDate: Date, to finishDate: Date) -> String {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_RU")
        
        let startHour = calendar.component(.hour, from: startDate)
        var startHourString = String(startHour)
        if startHour >= 0 && startHour <= 9 {
            startHourString = "0\(startHourString)"
        }
        if startHourString == "0" {
            startHourString = "00"
        }
        
        let startMinute = calendar.component(.minute, from: startDate)
        var startMinutesString = String(calendar.component(.minute, from: startDate))
        if startMinute >= 0 && startMinute <= 9 {
            startMinutesString = "0\(startMinutesString)"
        }
        
        let startTimeString = "\(startHourString):\(startMinutesString)"
        
        let finishHour = calendar.component(.hour, from: finishDate)
        var finishHourString = String(finishHour)
        if finishHour >= 0 && finishHour <= 9 {
            finishHourString = "0\(finishHourString)"
        }
        if finishHourString == "0" {
            finishHourString = "00"
        }
        
        let finishMinute = calendar.component(.minute, from: finishDate)
        var finishMinutesString = String(calendar.component(.minute, from: finishDate))
        if finishMinute >= 0 && finishMinute <= 9 {
            finishMinutesString = "0\(finishMinutesString)"
        }
        
        var finishTimeString = "\(finishHourString):\(finishMinutesString)"
        
        var finishDC = DateComponents()
        finishDC.year = calendar.component(.year, from: finishDate)
        finishDC.month = calendar.component(.month, from: finishDate)
        finishDC.day = calendar.component(.day, from: finishDate)
        finishDC.weekday = calendar.component(.weekday, from: finishDate)
        
        var startDC = DateComponents()
        startDC.year = calendar.component(.year, from: startDate)
        startDC.month = calendar.component(.month, from: startDate)
        startDC.day = calendar.component(.day, from: startDate)

        let finishMidnight = calendar.date(from: finishDC)
        let startMidnight = calendar.date(from: startDC)
        
        if startMidnight != finishMidnight {
            let finishDay = String(calendar.component(.day, from: finishDate))
            var finishWeekDay = ""
            if let finishWeekDayNumber = finishDC.weekday {
                finishWeekDay = calendar.weekdaySymbols[finishWeekDayNumber-1]
            }
            var finishMonth = ""
            if let finishMonthNumber = finishDC.month {
                finishMonth = calendar.monthSymbols[finishMonthNumber-1]
            }
            var finishYearStringWithSpaces = ""
            if calendar.component(.year, from: startDate) != calendar.component(.year, from: finishDate) {
                finishYearStringWithSpaces = " \(String(calendar.component(.year, from: finishDate)))"
            }
            
            finishTimeString = "\(finishDay) \(finishMonth)\(finishYearStringWithSpaces), \(finishTimeString), \(finishWeekDay) "
        }
        
        return "\(startTimeString) - \(finishTimeString)"
    }
    
    private func reloadTasksData(for date: Date) {
        let tasks = taskRepository.getTasks(by: date)
        updateCellModels(tasks: tasks)
    }
}

extension MainViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar,
                  boundingRectWillChange bounds: CGRect,
                  animated: Bool) {
        mainView.calendarHeightConstraint.constant = bounds.height
        mainView.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar,
                  didSelect date: Date,
                  at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        updateTitle(for: date)
        reloadTasksData(for: date)
        mainView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0),
                                       at: .top, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < cellModels.count {
            let cellModel = cellModels[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellIdentifier),
               let cell = cell as? TimeRangeTableViewCell{
                cell.delegate = self
                cell.setup(cellModel: cellModel)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MainViewController: TimeRangeTableViewCellDelegate {
    func taskTapped(id: String) {
        coordinator.makeTransition(transition: .taskDetails(id: id))
    }
}
