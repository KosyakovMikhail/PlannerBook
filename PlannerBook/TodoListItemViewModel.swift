//
//  TodoListItemViewModel.swift
//  PlannerBook
//
//  Created by Macos on 22.11.2022.
//

import Foundation
import UIKit

protocol TodoListItemViewModel { }

struct TodoListHourItemViewModel : TodoListItemViewModel  {
    let hourLabel: String
    let hour: Int
}

extension TodoListHourItemViewModel {
    
    init(hour: Int) {
        self.hourLabel = getHourString(for: hour)
        self.hour = hour
    }
}

private func getHourString(for hour: Int) -> String {
    
    var hourString = String(hour)
    
    if hour >= 0 && hour <= 9 {
        hourString = "0\(hourString)"
    }
    if hour == 24 {
        hourString = "00"
    }
    
    return hourString + ":00"
}

private func getHourNumber(date: Date) -> Int {
    let calendar = Calendar.current
    return calendar.component(.hour, from: date)
}
