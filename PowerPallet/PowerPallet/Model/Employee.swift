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
    var experationDate: String { get }
}

struct Employee: EmployeeProtocol {
    
    var fullName: String
    
    var wms: String
    
    var experationDate: String
    
}

