//
//  CreateTaskAssembly.swift
//  PlannerBook
//

import Swinject

final class CreateTaskAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(CreateTaskCoordinator.self) { _ in
            return CreateTaskCoordinator()
        }.initCompleted { (resolver, coordinator) in
            coordinator.controllerHelper = resolver.resolve(ControllerHelper.self)
        }
        
        container.register(CreateTaskViewController.self) {  (resolver: Resolver, selectedDate: Date) in
            let taskRepository = resolver.resolve(TaskRepository.self)
            let coordinator = resolver.resolve(CreateTaskCoordinator.self)
            return CreateTaskViewController(selectedDate: selectedDate,
                                            taskRepository: taskRepository,
                                            coordinator: coordinator)
        }.initCompleted { (resolver, controller) in
            let coordinator = resolver.resolve(CreateTaskCoordinator.self)
            coordinator?.baseController = controller
        }
    }
}
