//
//  CreateTaskViewController.swift
//  PlannerBook
//

import Foundation
import UIKit

final class CreateTaskViewController: UIViewController {
    
    private let mainView: CreateTaskView
    private let selectedDate: Date
    private let taskRepository: TaskRepository
    private let coordinator: CreateTaskCoordinator
    
    private var startDate = Date()
    private var finishDate = Date()
    private var titleText = ""
    private var descriptionText = ""
    
    init(selectedDate: Date,
         taskRepository: TaskRepository?,
         coordinator: CreateTaskCoordinator?) {
        guard let taskRepository = taskRepository,
              let coordinator = coordinator
        else { fatalError("CreateTaskViewController init") }
        
        self.taskRepository = taskRepository
        self.selectedDate = selectedDate
        self.coordinator = coordinator
        
        let startDate = selectedDate
        let finishDate = selectedDate.addingTimeInterval(3600)
        
        self.startDate = startDate
        self.finishDate = finishDate
        
        let startDateString = CreateTaskViewController.getDateTimeString(for: startDate)
        let finishDateString = CreateTaskViewController.getDateTimeString(for: finishDate)
        
        mainView = CreateTaskView(startDateString: startDateString,
                                  finishDateString: finishDateString)
        
        super.init(nibName: nil, bundle: nil)
        
        mainView.delegate = self
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainView.endEditing(true)
    }
    
    private func setup() {
        mainView.setConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self, action: #selector(saveButtonTapped))
    }
    
    private static func getDateTimeString(for date: Date) -> String {
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateTimeFormatter.string(from: date)
    }
    
    @objc private func saveButtonTapped() {
        let taskModel = TaskModel(title: titleText,
                                  subtitle: descriptionText,
                                  startDate: startDate,
                                  finishDate: finishDate)
        taskRepository.saveTask(model: taskModel)
        coordinator.makeTransition(transition: .main)
    }
}

extension CreateTaskViewController: CreateTaskDelegate {
    func startDateTapped() {
        alertDateTime(currentDate: startDate) { [weak self] (date) in
            self?.startDate = date
            self?.mainView.startDateButton.setTitle(
                CreateTaskViewController.getDateTimeString(for: date),
                for: .normal)
        }
    }
    
    func finishDateTapped() {
        alertDateTime(currentDate: finishDate) { [weak self] (date) in
            self?.finishDate = date
            self?.mainView.finishDateButton.setTitle(
                CreateTaskViewController.getDateTimeString(for: date),
                for: .normal)
        }
    }
    
    func titleChanged(text: String) {
        titleText = text
    }
    
    func descriptionChanged(text: String) {
        descriptionText = text
    }
}
