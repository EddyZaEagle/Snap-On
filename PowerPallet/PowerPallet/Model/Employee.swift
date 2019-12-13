//
//  Employee.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/7/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import Foundation

protocol EmployeeProtocol {
    var id: String { get }
    var firdtNsmr: String { get }
    var lastName: String { get }
    var wms: String { get }
    var experationDate: Bool { get }
    init(id: String, firstName: String, lastName: String, wms: String, experationDate: Date)
}

struct EmployeeStruct: EmployeeProtocol {
    
    private var _id: String
    private var _firstName: String
    private var _lastName: String
    private var _wms: String
    private var _valid: Date
    
    var id: String {
        get {
            return _id
        }
    }
    
    var firdtNsmr: String {
        get {
            return _firstName
        }
    }
    
    var lastName: String {
        get {
            return _lastName
        }
    }
    
    var wms: String {
        get {
            return _wms
        }
    }
    
    var experationDate: Bool {
        get {
            return _valid < Date.init()
        }
    }
    
    init(id: String, firstName: String, lastName: String, wms: String, experationDate: Date) {
        _id = id
        _firstName = firstName
        _lastName = lastName
        _wms = wms
        _valid = experationDate
    }
}
