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
    init(id: String, item: String, qty: Double)
}

class ItemsClass: ItemsProtocol {
    
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
        print("item class deinit!!!!!!")
    }
    
    public var isEmpty: Bool {
        return _qty == 0
    }
    
    public func adjustQTY(amount: Double) {
        _qty -= amount
    }
}
