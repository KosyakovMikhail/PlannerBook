//
//  NewTask.swift
//  PlannerBook
//
//  Created by Macos on 22.11.2022.
//

import UIKit

class NewTask: UITableViewController {
    
    private var taskModel = TaskModel()
    
    let idAddTaskCell = "idAddTaskCell"
    let idAddTaskHeader = "idAddTaskHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        tableView.register(AddTaskTableViewCell.self, forCellReuseIdentifier: idAddTaskCell)
        tableView.register(HeaderAddTaskTableViewCell.self
                           , forHeaderFooterViewReuseIdentifier: idAddTaskHeader)
        tableView.separatorStyle = .none
        
//        navigationController?.navigationBar.backgroundColor = .lightGray

        title = "Add new task"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc private func saveButtonTapped() {
        RealmManager.shared.saveTaskModel(model: taskModel)
        taskModel = TaskModel()
//        tableView.reloadRows(at: [[0,0], [0,1], [1,0], [1,1]], with: .none)
        tableView.reloadData()
        let goToMainController = MainViewController()
        navigationController?.pushViewController(goToMainController, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 2
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idAddTaskCell, for: indexPath) as! AddTaskTableViewCell        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case [0,1]: return 200
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idAddTaskHeader) as! HeaderAddTaskTableViewCell
        header.headerConfigure(section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! AddTaskTableViewCell
        
        switch indexPath {
        case [1,0]:
            startAlertDateTime(label: cell.nameCellLabel) { (date) in
            self.taskModel.taskDateStart = date
        }
        case [1,1]:
            endsAlertDateTime(label: cell.nameCellLabel) { (date) in
            self.taskModel.taskDateFinish = date
        }
        case [0,0]:
            alertForCellName(label: cell.nameCellLabel, name: "Task Name", placeholder: "Enter task name") { text in
            self.taskModel.taskName = text
        }
        case [0,1]:
            alertForCellDescription(label: cell.nameCellLabel, name: "Task Description", placeholder: "Enter task description") { text in
            self.taskModel.taskDescription = text
        }
        default:
            print("Erorr")
        }
    }

}
