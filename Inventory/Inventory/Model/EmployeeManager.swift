//
//  EmployeeManager.swift
//  Inventory
//
//  Created by Adam Moreno on 1/19/20.
//  Copyright © 2020 Adam Moreno. All rights reserved.
//

import Foundation

enum employeeEnum: Int {
    case notWMS = -2
    case found = 1
    case notFound = -1
    case employeeRemoved = 2
}

enum shoppingCartEnum: Int {
    case added = 1
    case removed = 2
    case edited = 3
    case alreadyInCart = -2
    case notInCart = -1
    case empty = -3
}

final class EmployeeManager {
    private var employee: Employee!
    static var instance = EmployeeManager()
    
    private var shoppingCart = [Items]()
    
    var count: Int { get { return shoppingCart.count} } // returns the count in shopping cart
    var isEmpty: Bool { get { return shoppingCart.isEmpty } } // check if cart is empty
    
    private init() {}
    
    func createUser(firstName: String, lastName: String, wms: String) -> employeeEnum {
        if (!wms.validateWMS) { return .notWMS }
        
        if (wms == "EMORENAM") {
            employee = Employee(_firstName: firstName, _lastName: lastName, _wms: wms)
            return .found
        }
        else { return .notFound }
    }
    
    func removeEmployee() {
        employee = nil
    }
    
    private func findItem(id: String) -> Int {
        for (index, item) in shoppingCart.enumerated() {
            if (item.id == id) { return index }
        }
        
        return -1
    }
    
    func addItem(id: String, itemName: String, qty: CDouble) -> shoppingCartEnum {
        // check to see if item is already in cart
        if (findItem(id: id) != -1) { return .alreadyInCart }
        
        // adds item to cart
        shoppingCart.append(Items(id: id, item: itemName, qty: qty))
        
        return .added
    }
    
    func removeItem(id: String) -> shoppingCartEnum {
        // check if cart is empty
        if (isEmpty) { return .empty }
        
        // checks to see if in cart
        let index = findItem(id: id) // inferres integer of item index in the array
        if (index == -1) { return .notInCart }
        
        // remove item from cart
        shoppingCart.remove(at: index)
        
        return .removed
    }
    
    func editItem(id: String, newItem: Items) -> shoppingCartEnum {
        // checks if cart is empty
        if (isEmpty) { return .empty }
        
        //checks if item is in cart
        let index = findItem(id: id)
        if (index == -1) { return .notInCart }
        
        // removes old item from cart
        shoppingCart.remove(at: index)
        // insert new item in cart
        shoppingCart.insert(newItem, at: index)
        
        return .edited
    }
}
