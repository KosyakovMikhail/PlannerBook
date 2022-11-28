//
//  HelpersAssembly.swift
//  PlannerBook
//

import Swinject

final class HelpersAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ControllerHelper.self) { resolver in
            return ControllerHelper(resolver: resolver)
        }
    }
}
    
