//
//  PowerPallet.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/7/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import Foundation
import Firebase

protocol PowerPalletProtocol {
    var id: String { get }
    var isWorking: Bool { get }
    var isInuse: Bool { get }
    init(id: String, isWorking: Bool, isInUse: Bool)
    init(powerpallet: DataSnapshot)
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
    
    init(powerpallet: DataSnapshot) {
        let temp = powerpallet.value as! NSDictionary
        _id = temp["ID"] as! String
        _isWorking = temp["IS_WORKING"] as! Bool
        _isInUse = temp["IS_IN_USE"] as! Bool
    }
}
