//
//  UIColorExtensions.swift.swift
//  PlannerBook
//

import UIKit

extension UIColor {
    
    static func colorFromHex(_ hex: String) -> UIColor {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        var rgb: UInt64 = 0
        Scanner(string: hexString.replacingOccurrences(of: "#", with: ""))
            .scanHexInt64(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255,
                            green: CGFloat((rgb & 0x00FF00) >> 8) / 255,
                            blue: CGFloat(rgb & 0x0000FF) / 255,
                            alpha: 1.0)
    }
    
    func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let rgb: Int = (Int)(red*255)<<16 | (Int)(green*255)<<8 | (Int)(blue*255)<<0

        return NSString(format: "#%06X", rgb) as String
    }
}
