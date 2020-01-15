//
//  SnapOnString.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/19/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import Foundation

extension String {
    var isEightCharators: Bool {
        return self.count == 8 || self.isEmpty
    }
    
    var isWMS: Bool {
        for x in self {
            if !betweenA_Z(x) { return false }
        }
        return true
    }
    
    private func betweenA_Z(_ char: Character) -> Bool {
        return char.asciiValue! >= UInt8(65) && char.asciiValue! <= UInt8(90)
    }
    
}
