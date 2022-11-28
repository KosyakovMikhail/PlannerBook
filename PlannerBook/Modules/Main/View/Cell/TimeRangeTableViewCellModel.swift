//
//  TimeRangeTableViewCellModel.swift
//  PlannerBook
//

import UIKit

struct TimeRangeTableViewCellModel {
    
    static let cellIdentifier: String = "TimeRangeTableViewCell"

    var cellIdentifier: String {
        return Self.cellIdentifier
    }
    
    let hour: Int
    let timeRange: String
    var todoItems: [TaskTicketModel]
}
