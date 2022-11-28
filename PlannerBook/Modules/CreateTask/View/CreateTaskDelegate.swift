//
//  CreateTaskDelegate.swift
//  PlannerBook
//

import Foundation

protocol CreateTaskDelegate: AnyObject {
    
    func startDateTapped()
    func finishDateTapped()
    func titleChanged(text: String)
    func descriptionChanged(text: String)
}
