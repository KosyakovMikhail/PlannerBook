//
//  TaskModel.swift
//  PlannerBook
//
//  Created by Macos on 25.11.2022.
//

import RealmSwift

class TaskModel: Object {
    @Persisted var taskName: String = ""
    @Persisted var taskDescription: String = ""
    @Persisted var taskDateStart = Date()
    @Persisted var taskDateFinish = Date()
    @Persisted var id: Int = 1
    @Persisted var color: String = "FFFFFF"
}
