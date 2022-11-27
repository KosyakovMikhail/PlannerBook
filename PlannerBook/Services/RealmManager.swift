//
//  RealmManager.swift
//  PlannerBook
//
//  Created by Macos on 25.11.2022.
//

import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveTaskModel(model: TaskModel) {
        try! localRealm.write{
            localRealm.add(model)
        }
    }
}
