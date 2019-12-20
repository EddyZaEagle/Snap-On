//
//  String.swift
//  Inventory
//
//  Created by Adam Moreno on 12/20/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import Foundation

extension String {
    public var validateWMS: Bool {
        if (self.count != 8) { return false }
        
        for x in self {
            if !isBetweenA_Z(x) { return false }
        }
        
        return true
    }
    
    private func isBetweenA_Z(_ char: Character) -> Bool {
        return char.asciiValue! >= UInt8(65) && char.asciiValue! <= UInt8(90)
    }
}
