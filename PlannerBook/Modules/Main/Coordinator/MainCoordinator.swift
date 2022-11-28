//
//  MainCoordinator.swift
//  PlannerBook
//

import UIKit

final class MainCoordinator {
    
    var controllerHelper: ControllerHelper!
    
    weak var baseController: UIViewController?
    
    func makeTransition(transition: Transition) {
        switch transition {
        case .taskDetails(let id):
            let vc = controllerHelper.getController(by: TaskDetailsViewController.self,
                                                    arg: id)
            baseController?.navigationController?.pushViewController(vc,
                                                                     animated: true)
        case .createTask(let selectedDate):
            let vc = controllerHelper.getController(by: CreateTaskViewController.self,
                                                    arg: selectedDate)
            baseController?.navigationController?.pushViewController(vc,
                                                                     animated: true)
        default:
            break
        }
    }
}
