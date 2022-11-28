//
//  TaskModel.swift
//  PlannerBook
//

import RealmSwift

final class TaskModel: Object {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var subtitle: String = ""
    @objc dynamic var startDate = Date()
    @objc dynamic var finishDate = Date()
    @objc dynamic var color: String = UIColor.systemBlue.toHexString()
    
    convenience init(title: String,
                     subtitle: String,
                     startDate: Date,
                     finishDate: Date,
                     color: String = UIColor.systemBlue.toHexString()) {
        self.init()
        self.title = title
        self.subtitle = subtitle
        self.startDate = startDate
        self.finishDate = finishDate
        self.color = color
    }
    
    static override func primaryKey() -> String? {
        return "id"
    }
}
