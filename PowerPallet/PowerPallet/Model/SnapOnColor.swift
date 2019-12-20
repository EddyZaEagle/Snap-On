//
//  SnapOnColor.swift
//  PowerPallet
//
//  Created by Adam Moreno on 11/30/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    open class var snapOnRed: UIColor {
        get {
            return UIColor.init(red: 0.94, green: 0.11, blue: 0.14, alpha: 1.0)
        }
    }
    
    open class var snapOnGold: UIColor {
        get {
            return UIColor.init(red: 0.99, green: 0.73, blue: 0.25, alpha: 1.0)
        }
    }
    
    open class var snapOnGray: UIColor {
        get {
            return UIColor.init(red: 0.44, green: 0.44, blue: 0.45, alpha: 1.0)
        }
    }
}
