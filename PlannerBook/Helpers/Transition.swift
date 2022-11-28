//
//  Transition.swift
//  PlannerBook
//

import Foundation

enum Transition {
    case taskDetails(id: String)
    case main
    case createTask(selectedDate: Date)
}
