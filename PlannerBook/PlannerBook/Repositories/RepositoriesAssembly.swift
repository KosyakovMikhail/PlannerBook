//
//  RepositoriesAssembly.swift
//  PlannerBook
//

import Swinject

final class RepositoriesAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(RealmManager.self) { _ in
            return RealmManager()
        }
        
        container.register(TaskRepository.self) { resolver in
            let realmManager = resolver.resolve(RealmManager.self)
            return TaskRepository(realmManager: realmManager)
        }
    }
}
