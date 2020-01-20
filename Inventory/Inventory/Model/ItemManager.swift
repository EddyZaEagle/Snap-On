//
//  ItemManager.swift
//  Inventory
//
//  Created by Adam Moreno on 1/19/20.
//  Copyright © 2020 Adam Moreno. All rights reserved.
//

import Foundation

enum itemsEnum: Int {
    case added = 1
    case removed = 2
    case qtyUpdated = 3
    case qtyEmpty = -1
    case qtyLow = -2
}

final class ItemManager {
    private var items = [Items]()
    static let instance = ItemManager()
    
    private init() {}
    
    var count: Int { get { return items.count } }
    private var isEmpty: Bool { get { return items.isEmpty } }
    
    private func findItem(id: String) -> Int {
        if (isEmpty) { return -2 }
        
        for (index, item) in items.enumerated() {
            if (item.id == id) { return index }
        }
        
        return -1
    }
    
    func addItem(id: String, item: String, qty: Double) {
        items.append(Items(id: id, item: item, qty: qty))
    }
    
    func getItem(index: Int) -> Items {
        return items[index]
    }
    
    
    func upDateQTY(index: Int, qty: Double) -> itemsEnum {
        if (items[index].isEmpty) { return .qtyEmpty }
        
        if (items[index].qty < qty) { return .qtyLow }
        
        items[index].subtracttQTY(amount: qty)
        
        return .qtyUpdated
    }
    
    
}
