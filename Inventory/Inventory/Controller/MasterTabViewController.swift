//
//  MasterTabViewController.swift
//  Inventory
//
//  Created by Adam Moreno on 1/4/20.
//  Copyright © 2020 Adam Moreno. All rights reserved.
//

import UIKit

class MasterTabViewController: UIViewController {
    
    @IBOutlet weak var masterView: UIView!
    private var tabBar: InventoryTabBar!
    private var inventoryVC: InventoryViewController!
    private var scannerVC: ScannerViewController!
    private var itemVC: ItemViewController!
    
    // Called only once - DO: Intialization here
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar = self.view.subviews[1] as? InventoryTabBar
        tabBar.delegate = self.view.subviews[1] as? InventoryTabBar
        tabBar.inventoryDelegate = self

        inventoryVC = storyboard?.instantiateViewController(identifier: "inventoryVC") as? InventoryViewController
        inventoryVC.view.frame = CGRect(x: 0, y: 0, width: self.masterView.frame.width, height: self.masterView.frame.height)
        
        scannerVC = storyboard?.instantiateViewController(identifier: "scannerVC") as? ScannerViewController
        scannerVC.view.frame = CGRect(x: 0, y: 0, width: self.masterView.frame.width, height: self.masterView.frame.height)
        
        itemVC = storyboard?.instantiateViewController(identifier: "itemVC") as? ItemViewController
        itemVC.view.frame = CGRect(x: 0, y: 0, width: self.masterView.frame.width, height: self.masterView.frame.height)
        
        masterView.addSubview(itemVC.view)
        masterView.addSubview(scannerVC.view)
        masterView.addSubview(inventoryVC.view)
        
        inventoryVC.didMove(toParent: self)
        
    }

}

extension MasterTabViewController: InventoryTabBarDelegate {
    func bringForwardInventoryTableView() {
        masterView.bringSubviewToFront(inventoryVC.view)
        inventoryVC.didMove(toParent: self)
    }
    
    func bringForwardScannerView() {
        masterView.bringSubviewToFront(scannerVC.view)
        scannerVC.didMove(toParent: self)
    }
    
    func bringForwardShoppingCart() {
        masterView.bringSubviewToFront(itemVC.view)
        itemVC.didMove(toParent: self)
    }
    
    
}
