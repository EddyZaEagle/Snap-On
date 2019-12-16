//
//  InventoryTabBar.swift
//  Inventory
//
//  Created by Adam Moreno on 12/13/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol InventoryTabBarDelegate {
    func bringForwardInventoryTableView()
    func bringForwardScannerView()
    func bringForwardShoppingCart()
}

class InventoryTabBar: UITabBar {
    
    var inventoryDelegate: InventoryTabBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTabBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        print("Tap tab")
        setUpInventorBarItem()
        setUpScannerBarItem()
        setShoppingCartBarItem()
    }
    
    private func setUpInventorBarItem() {
        let inventory = UITabBarItem(title: "Inventory", image: .add, tag: 0)
        self.items![0] = inventory
        self.selectedItem = inventory
        
    }
    
    private func setUpScannerBarItem() {
        let scanner = UITabBarItem(title: "scanner", image: .actions, tag: 1)
        self.items![1] = scanner
    }
    
    private func setShoppingCartBarItem() {
        let cart = UITabBarItem(title: "Cart", image: .checkmark, tag: 2)
        self.items![2] = cart
    }

}

extension InventoryTabBar: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let delegate = inventoryDelegate else {
            return
        }
        
        switch item.tag {
        case 0:
            print("INVENTORY")
            delegate.bringForwardInventoryTableView()
            break
        case 1:
            print("SCANNER")
            delegate.bringForwardScannerView()
            break
        case 2:
            print("CART")
            delegate.bringForwardShoppingCart()
            break
        default:
            print("unknown tab item")
        }
    }
}
