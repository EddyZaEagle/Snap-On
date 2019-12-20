//
//  Employee.swift
//  Inventory
//
//  Created by Adam Moreno on 12/20/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import Foundation

protocol EmployeeProtocol {
    var fullName: String { get }
    var wms: String { get }
    init(firstName: String, lastName: String, wms: String)
}

struct EmployeeStruct: EmployeeProtocol {
    
    private var _firstName: String
    private var _lastName: String
    private var _wms: String
    
    var fullName: String {
        get { return "\(_firstName) \(_lastName)"}
    }
    
    var wms: String {
        get { return _wms }
    }
    
    init(firstName: String, lastName: String, wms: String) {
        _firstName = firstName
        _lastName = lastName
        _wms = wms
    }
}
