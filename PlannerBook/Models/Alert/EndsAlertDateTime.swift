//
//  EndsAlertDateTime.swift
//  PlannerBook
//
//  Created by Macos on 24.11.2022.
//

import UIKit
import SnapKit

extension UIViewController {
    
    func endsAlertDateTime(label: UILabel, completionHandler: @escaping (Date) -> Void) {
        
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = NSLocale(localeIdentifier: "RU_ru") as Locale
        datePicker.timeZone = .current
        datePicker.preferredDatePickerStyle = .wheels
        
        alert.view.addSubview(datePicker)
        
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
            let dateString = dateFormatter.string(from: datePicker.date)
            let date = datePicker.date
    
            completionHandler( date )
            
            label.text = dateString
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        alert.view.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.snp.makeConstraints { make in
            make.width.equalTo(alert.view.snp.width)
            make.height.equalTo(160)
            make.top.equalTo(alert.view.snp.top).inset(20)
        }
        
        present(alert, animated: true, completion: nil)
    }
}
