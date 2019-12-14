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
        setUpInventoryNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpInventoryNavigationBar()
    }
    
    @objc fileprivate func dismiss2HomeScene() {
        if let delegate = inventoryDelegate {
            delegate.exitApplication()
        }
        else { print("error with exit application delegate") }
    }
    
    private func setUpInventoryNavigationBar() {
        self.barStyle = UIBarStyle.black
        self.isTranslucent = false
        setUpNavigationTitle()
        setUpLeftBarButtonItem()
    }
    
    private func setUpNavigationTitle() {
        self.topItem?.title = "INVENTORY"
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor.self : UIColor.snapOnGold]
    }
    
    private func setUpLeftBarButtonItem() {
        let left = UIBarButtonItem(title: "Exit", style: .done, target: self, action: #selector(dismiss2HomeScene))
        left.tintColor = .white
        self.topItem?.leftBarButtonItem = left
    }

}
