//
//  InventoryViewController.swift
//  Inventory
//
//  Created by Adam Moreno on 12/12/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController {
    
    lazy var scannerView: ScannerView = {
        let view = ScannerView()
        
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let inventoryStackView = self.view.subviews[0] as! UIStackView
        
        inventoryStackView.backgroundColor = .purple
        
        let navBar = inventoryStackView.subviews[0] as! InventoryNavigationBar
        navBar.inventoryDelegate = self
        
        let tableView = inventoryStackView.subviews[1] as! InventoryTableView
        tableView.delegate = inventoryStackView.subviews[1] as! InventoryTableView
        tableView.dataSource = inventoryStackView.subviews[1] as! InventoryTableView
        
        let tabBar = inventoryStackView.subviews[2] as! InventoryTabBar
        tabBar.delegate = inventoryStackView.subviews[2] as! InventoryTabBar
        tabBar.inventoryDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension InventoryViewController: InventoryNavBarDelegate {
    func exitApplication() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

extension InventoryViewController: InventoryTabBarDelegate {
    func bringForwardInventoryTableView() {
        self.view.sendSubviewToBack(scannerView)
    }
    
    func bringForwardScannerView() {
        let scan = ScannerView()
        self.view.insertSubview(scan, at: 0)
    }
    
    func bringForwardShoppingCart() {
        print("Shopping cart view controller")
    }
    
    
}
