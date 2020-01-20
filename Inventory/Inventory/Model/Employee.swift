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
}

struct Employee: EmployeeProtocol {
    
    var _firstName: String
    var _lastName: String
    var _wms: String
    
    var fullName: String {
        get { return "\(_firstName) \(_lastName)"}
    }
    
    var wms: String {
        get { return _wms }
    }
}
