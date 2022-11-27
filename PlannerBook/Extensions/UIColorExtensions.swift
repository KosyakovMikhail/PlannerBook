//
//  UIColorExtensions.swift.swift
//  PlannerBook
//
//  Created by Macos on 25.11.2022.
//

import UIKit

extension UIColor {
    
    func colorFromHex(_ hex: String) -> UIColor {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.count != 6 {
            return UIColor.black
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255,
                            green: CGFloat((rgb & 0x00FF00) >> 8) / 255,
                            blue: CGFloat(rgb & 0x0000FF) / 255,
                            alpha: 1.0)
    }
}
