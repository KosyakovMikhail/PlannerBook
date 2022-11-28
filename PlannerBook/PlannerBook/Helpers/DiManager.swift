//
//  DiManager.swift
//  PlannerBook
//

import Swinject
import UIKit

final class DiManager {
    
    static let shared = DiManager()
    
    private init() {}
    
    private let assembler = Assembler([
        HelpersAssembly(),
        RepositoriesAssembly(),
        MainAssembly(),
        TaskDetailsAssembly(),
        CreateTaskAssembly()
    ])
    
    var firstVC: UIViewController? {
        UINavigationController(
            rootViewController: assembler.resolver.resolve(MainViewController.self)!)
    }
}
