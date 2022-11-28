//
//  TaskDetailsViewController.swift
//  PlannerBook
//

import Foundation
import UIKit

final class TaskDetailsViewController: UIViewController {
    
    private let mainView = TaskDetailsView()
    private let taskId: String
    private let taskRepository: TaskRepository
    
    private var taskModel: TaskModel?
    
    init(taskId: String,
         taskRepository: TaskRepository?) {
        guard let taskRepository = taskRepository
        else { fatalError("TaskDetailsViewController init") }
        
        self.taskRepository = taskRepository
        self.taskId = taskId
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
    
    private func setup() {
        mainView.setup()
        taskModel = taskRepository.getTask(by: taskId)
        if let taskModel = taskModel {
            mainView.setupData(title: taskModel.title,
                               description: taskModel.subtitle,
                               startDate: taskModel.startDate,
                               finishDate: taskModel.finishDate)
        }
    }
}
