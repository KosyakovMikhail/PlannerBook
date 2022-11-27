//
//  UIViewControllerExtensions.swift
//  PlannerBook
//
//  Created by Macos on 25.11.2022.
//
import UIKit
import SnapKit

extension UIViewController {
    
    func alertForCellDescription(label: UILabel, name: String, placeholder: String, completionHandler: @escaping (String) -> Void) {

        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)

        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            let textFieldAlert = alert.textFields?.first
            guard let text = textFieldAlert?.text else { return }
            label.text = text
            completionHandler(text)
        }

        alert.addTextField() { (textFieldAlert) in
            textFieldAlert.placeholder = placeholder
            textFieldAlert.adjustsFontSizeToFitWidth = false
            textFieldAlert.clearButtonMode = UITextField.ViewMode.whileEditing
            textFieldAlert.returnKeyType = UIReturnKeyType.done
            textFieldAlert.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            textFieldAlert.snp.makeConstraints { make in
                make.height.equalTo(200)
                make.width.equalTo(200)
            }
        }

        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)

        alert.addAction(ok)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)
    }
}
