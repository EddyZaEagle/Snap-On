//
//  EmployeeManger.swift
//  PowerPallet
//
//  Created by Adam Moreno on 1/15/20.
//  Copyright © 2020 Adam Moreno. All rights reserved.
//

import Foundation

final class EmployeeManager {
    private var employee: Employee?
    public static let inistance = EmployeeManager()
    
    private init() {}
    
    public func CreatUser(firstName: String, lastName: String, wms: String, experationDate: String) {
        employee = Employee(fullName: "\(firstName) \(lastName)", wms: wms, experationDate: experationDate)
    }
    
    private func validDate() {
        let dateforemate = DateFormatter()
        
    }
}
