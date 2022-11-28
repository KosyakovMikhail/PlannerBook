//
//  TaskDetailsAssembly.swift
//  PlannerBook
//

import Swinject

final class TaskDetailsAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(TaskDetailsViewController.self) { (resolver: Resolver, id: String) in
            let taskRepository = resolver.resolve(TaskRepository.self)
            return TaskDetailsViewController(taskId: id, taskRepository: taskRepository)
        }
    }
}
