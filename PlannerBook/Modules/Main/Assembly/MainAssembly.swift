//
//  MainAssembly.swift
//  PlannerBook
//

import Swinject

final class MainAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MainCoordinator.self) { _ in
            return MainCoordinator()
        }.initCompleted { (resolver, coordinator) in
            coordinator.controllerHelper = resolver.resolve(ControllerHelper.self)
        }
        
        container.register(MainViewController.self) { resolver in
            let taskRepository = resolver.resolve(TaskRepository.self)
            let coordinator = resolver.resolve(MainCoordinator.self)
            return MainViewController(taskRepository: taskRepository,
                                      coordinator: coordinator)
        }.initCompleted { (resolver, controller) in
            let coordinator = resolver.resolve(MainCoordinator.self)
            coordinator?.baseController = controller
        }
    }
}
