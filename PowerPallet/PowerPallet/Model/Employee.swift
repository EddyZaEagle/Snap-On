//
//  Employee.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/7/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import Foundation
import Firebase

protocol EmployeeProtocol {
    var fullName: String { get }
    var wms: String { get }
    var experationDate: Bool { get }
    init(id: String, firstName: String, lastName: String, wms: String, experationDate: String)
    init(employee: DataSnapshot)
}

struct EmployeeStruct: EmployeeProtocol {
    
    
    enum wmsLogin: Error {
        case notEightCharators
        case notWMS
        case wmsNotFound
    }
    
    private var _firstName: String
    private var _lastName: String
    private var _wms: String
    private var _valid: String
    
    var fullName: String {
        get {
            return "\(_firstName) \(_lastName)"
        }
    }
    
    var wms: String {
        get {
            return _wms
        }
    }
    
    var experationDate: Bool {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let permite = dateFormatter.date(from: _valid)
            return permite! > Date.init()
        }
    }
    
    init(id: String, firstName: String, lastName: String, wms: String, experationDate: String) {
        _firstName = firstName
        _lastName = lastName
        _wms = wms
        _valid = experationDate
    }
    
    init(employee: DataSnapshot) {
        let temp = employee.value as! NSDictionary
        _firstName = temp["FIRST_NAME"] as! String
        _lastName = temp["LAST_NAME"] as! String
        _wms = temp["WMS"] as! String
        _valid = temp["EXPERATION_DATE"] as! String
    }
    
    public func employeeLogin(wms: String) throws {
        if !wms.isEightCharators { throw wmsLogin.notEightCharators }
        else if !wms.isWMS { throw wmsLogin.notWMS }
    }
}
