//
//  MaskedCorners.swift
//  PlannerBook
//
//  Created by Macos on 22.11.2022.
//

import Foundation

public struct CACornerMask : OptionSet {
    public var rawValue: UInt
    
    public init(rawValue: UInt)
    public static var layerMinXMinYCorner: CACornerMask { get }
    public static var layerMaxXMinYCorner: CACornerMask { get }
    public static var layerMinXMaxYCorner: CACornerMask { get }
    public static var layerMaxXMaxYCorner: CACornerMask { get }
}
