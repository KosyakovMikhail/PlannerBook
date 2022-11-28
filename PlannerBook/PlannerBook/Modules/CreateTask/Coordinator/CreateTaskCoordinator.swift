//
//  CreateTaskCoordinator.swift
//  PlannerBook
//

import UIKit

final class CreateTaskCoordinator {
    
    var controllerHelper: ControllerHelper!
    
    weak var baseController: UIViewController?
    
    func makeTransition(transition: Transition) {
        switch transition {
        case .main:
            if let navController = self.baseController?.navigationController,
               let vc = navController.viewControllers.first(where: {
                   type(of: $0) == MainViewController.self
               }) {
                navController.popToViewController(vc, animated: true)
            }
        default:
            break
        }
    }
}

