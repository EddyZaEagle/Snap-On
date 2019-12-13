//
//  InventoryNavigationBar.swift
//  Inventory
//
//  Created by Adam Moreno on 12/12/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol InventoryNavBarDelegate {
    func exitApplication()
}

class InventoryNavigationBar: UINavigationBar {

    var inventoryDelegate: InventoryNavBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc fileprivate func dismiss2HomeScene() {
        if let delegate = inventoryDelegate {
            delegate.exitApplication()
        }
        else { print("error with exit application delegate") }
    }
    
    private func setUpInventoryNavigationBar() {
        
    }
    
    private func setUpNavigationTitle() {
        self.topItem?.title = "INVENTORY"
        
    }

}
