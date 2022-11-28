//
//  TaskRepository.swift
//  PlannerBook
//

import Foundation

final class TaskRepository {
    
    let realmManager: RealmManager
    
    init(realmManager: RealmManager?) {
        guard let realmManager = realmManager
        else { fatalError("TaskRepository init") }
        
        self.realmManager = realmManager
    }
    
    func getTasks(by date: Date) -> [TaskModel] {
        let calendar = Calendar.current
        let fromDate = calendar.date(bySettingHour: 0,
                                     minute: 0,
                                     second: 0,
                                     of: date,
                                     direction: .backward)
        let toDate = fromDate?.addingTimeInterval(3600 * 24 - 1)
        
        return realmManager.obtainElements(
            predicate: NSPredicate(format: "startDate BETWEEN {%@, %@}",
                                   argumentArray: [fromDate ?? Date(),
                                                   toDate ?? Date()]),
            sortedBy: "startDate")
    }
    
    func getTask(by id: String) -> TaskModel? {
        return realmManager.obtainElement(predicate: NSPredicate(format: "id == %@", id))
    }
    
    func saveTask(model: TaskModel) {
        realmManager.save(model)
    }
}
