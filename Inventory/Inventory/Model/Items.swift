//
//  Items.swift
//  Inventory
//
//  Created by Adam Moreno on 12/20/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import Foundation

protocol ItemsProtocol {
    var id: String { get }
    var item: String { get }
    var qty: Double { get }
}

class Items: ItemsProtocol {
    
    private var _id: String
    private var _item: String
    private var _qty: Double
    
    var id: String {
        get { return _id }
    }
    
    var item: String {
        get { return _item }
    }
    
    var qty: Double {
        get { return _qty }
    }
    
    required init(id: String, item: String, qty: Double) {
        _id = id
        _item = item
        _qty = qty
    }
    
    deinit {
        print("item is now nil")
    }
    
    public var isEmpty: Bool {
        return _qty == 0
    }
    
    public func addQTY(amount: Double) {
        _qty += (_qty - amount)
    }
    
    public func subtracttQTY(amount: Double) {
        _qty -= (amount - _qty)
    }
    
    public func equals(id: String) -> Bool {
        return _id == id
    }
}
