//
//  ControllerHelper.swift
//  PlannerBook
//

import UIKit
import Swinject

final class ControllerHelper {
    
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    public func getController<T>(by type: T.Type, name: String? = nil) -> T {
        guard let controller = resolver.resolve(type, name: name) else {
            fatalError()
        }

        return controller
    }
    
    public func getController<T, Arg>(by type: T.Type, name: String? = nil, arg: Arg) -> T {
        guard let controller = resolver.resolve(type, name: name, argument: arg) else {
            fatalError()
        }
        
        return controller
    }
}
