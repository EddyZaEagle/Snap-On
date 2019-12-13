//
//  PowerPallet.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/7/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import Foundation

protocol PowerPalletProtocol {
    var id: String { get }
    var isWorking: Bool { get }
    var isInuse: Bool { get }
    init(id: String, isWorking: Bool, isInUse: Bool)
}

struct PowerPalletStruct: PowerPalletProtocol {
    
    private var _id: String
    private var _isWorking: Bool
    private var _isInUse: Bool
    
    var id: String {
        get {
            return _id
        }
    }
    
    var isWorking: Bool {
        get {
            return _isWorking
        }
    }
    
    var isInuse: Bool {
        get {
            return _isInUse
        }
    }
    
    init(id: String, isWorking: Bool, isInUse: Bool) {
        _id = id
        _isWorking = isWorking
        _isInUse = isInUse
    }
}
