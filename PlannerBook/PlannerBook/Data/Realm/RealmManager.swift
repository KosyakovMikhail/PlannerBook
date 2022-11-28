//
//  RealmManager.swift
//  PlannerBook
//

import Foundation
import RealmSwift
import RxRealm

class RealmManager {
    
    private var realm: Realm {
        do {
            let realm = try Realm()
            return realm
        } catch {
            fatalError("RealmManager Realm.init()")
        }
    }
    
    func obtainElement<RealmModel: Object>(predicate: NSPredicate?) -> RealmModel? {
        let models: [RealmModel] = obtainElements(predicate: predicate)
        return models.first
    }
    
    func obtainElements<RealmModel: Object>(predicate: NSPredicate?,
                                            sortedBy keyPath: String? = nil) -> [RealmModel] {
        var models = realm.objects(RealmModel.self)
        
        if let predicate = predicate {
            models = models.filter(predicate)
        }
        
        if let keyPath = keyPath {
            models = models.sorted(byKeyPath: keyPath)
        }
        
        print("Realm is located at:", realm.configuration.fileURL!)
        
        return models.toArray()
    }
    
    func save<RealmModel: Object>(_ model: RealmModel) {
        try? realm.safeWrite { [weak self] in
            self?.realm.add(model, update: .all)
        }
    }
}

extension Realm {
    
    func safeWrite(_ execute: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try execute()
        } else {
            try write(execute)
        }
    }
}
