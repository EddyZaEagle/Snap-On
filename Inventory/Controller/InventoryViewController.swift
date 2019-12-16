//
//  InventoryViewController.swift
//  Inventory
//
//  Created by Adam Moreno on 12/12/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController {
    
    lazy var scanner: ScannerView = {
        let stackView = self.view.subviews[0]
        let view = ScannerView(frame: CGRect(x: 0, y: 0, width: stackView.subviews[1].bounds.width, height: stackView.subviews[1].bounds.height))
        view.backgroundColor = .white
        
        return view
    }()
    
    weak var inventory: InventoryTableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let inventoryStackView = self.view.subviews[0] as! UIStackView
        
        let navBar = inventoryStackView.subviews[0] as! InventoryNavigationBar
        navBar.inventoryDelegate = self
        
        let tableView = inventoryStackView.subviews[1].subviews[2] as! InventoryTableView
        tableView.delegate = inventoryStackView.subviews[1].subviews[2] as! InventoryTableView
        tableView.dataSource = inventoryStackView.subviews[1].subviews[2] as! InventoryTableView
        
        let collection = inventoryStackView.subviews[1].subviews[0] as! CartCollectionView
        collection.delegate = inventoryStackView.subviews[1].subviews[0] as! CartCollectionView
        collection.dataSource = inventoryStackView.subviews[1].subviews[0] as! CartCollectionView
        
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
        let secondStack = self.view.subviews[0].subviews[1].subviews
        for x in secondStack {
            if (x is InventoryTableView) {
                self.view.subviews[0].subviews[1].bringSubviewToFront(x)
            }
        }
    }
    
    func bringForwardScannerView() {
        let secondStack = self.view.subviews[0].subviews[1].subviews
        for x in secondStack {
            if (x is ScannerView) {
                self.view.subviews[0].subviews[1].bringSubviewToFront(x)
            }
        }
    }
    
    func bringForwardShoppingCart() {
        let secondStack = self.view.subviews[0].subviews[1].subviews
        for x in secondStack {
            if (x is CartCollectionView) {
                self.view.subviews[0].subviews[1].bringSubviewToFront(x)
            }
        }
    }
    
}
