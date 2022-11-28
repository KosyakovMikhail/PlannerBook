//
//  UIViewControllerExtensions.swift
//  PlannerBook
//

import UIKit
import SnapKit

extension UIViewController {
    
    func alertDateTime(currentDate: Date, completion: @escaping (Date) -> Void) {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = Locale.init(identifier: "Ru_ru")
        datePicker.date = currentDate
        
        alert.view.addSubview(datePicker)
        
        let okAction = UIAlertAction(title: "Ок", style: .default) { (action) in
            let date = datePicker.date
            completion(date)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        alert.view.heightAnchor.constraint(equalToConstant: 330).isActive = true
        datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 150).isActive = true
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 0).isActive = true
        
        present(alert, animated: true, completion: nil)
    }
}
