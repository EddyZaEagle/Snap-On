//
//  InventoryViewController.swift
//  Inventory
//
//  Created by Adam Moreno on 12/12/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController {
    
    private var inventoryStackView: UIStackView!
    private var inventoryNavBar: InventoryNavigationBar!
    private var inventoryTableView: InventoryTableView!
    private var cartCollectionView: CartCollectionView!
    private var inventoryTabBar: InventoryTabBar!
    private var scannerView: ScannerView!
    
    private var _itemArray: [ItemsClass]! //array fot items
    private var _cartArray: [ItemsClass] = [ItemsClass]() // cart array
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //populate array with items
        thisIsDUmmyTesting4TableView()
        
        creatInstance()
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //these are dummy values for testing only
    private func thisIsDUmmyTesting4TableView() {
        let item01 = ItemsClass(id: "010001", item: "Hammer", qty: 12)
        let item02 = ItemsClass(id: "020002", item: "Nails", qty: 5)
        let item03 = ItemsClass(id: "030003", item: "Paint", qty: 8)
        let item04 = ItemsClass(id: "040004", item: "Cordless Drill", qty: 99)
        let item05 = ItemsClass(id: "050005", item: "Screw Driver", qty: 25)
        
        _itemArray = [item01, item02, item03, item04, item05]
    }
    
    private func creatInstance() {
        inventoryStackView = self.view.subviews[0] as? UIStackView
        
        inventoryNavBar = inventoryStackView.subviews[0] as? InventoryNavigationBar
        inventoryNavBar.inventoryDelegate = self
        
        inventoryTableView = inventoryStackView.subviews[1].subviews[2] as? InventoryTableView
        inventoryTableView.delegate = inventoryStackView.subviews[1].subviews[2] as? InventoryTableView
        inventoryTableView.dataSource = inventoryStackView.subviews[1].subviews[2] as? InventoryTableView
        inventoryTableView.inventoryDelegate = self
        
        scannerView = inventoryStackView.subviews[1].subviews[1] as? ScannerView
        
        cartCollectionView = inventoryStackView.subviews[1].subviews[0] as? CartCollectionView
        cartCollectionView.delegate = inventoryStackView.subviews[1].subviews[0] as? CartCollectionView
        cartCollectionView.dataSource = inventoryStackView.subviews[1].subviews[0] as? CartCollectionView
        cartCollectionView.cartDelegate = self
        
        inventoryTabBar = inventoryStackView.subviews[2] as? InventoryTabBar
        inventoryTabBar.delegate = inventoryStackView.subviews[2] as? InventoryTabBar
        inventoryTabBar.inventoryDelegate = self
    }
}

extension InventoryViewController: InventoryNavBarDelegate {
    func exitApplication() {
        _itemArray.removeAll()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

extension InventoryViewController: InventoryTabBarDelegate {
    /**
     Brings inventory table view to front of UIScreen
     */
    func bringForwardInventoryTableView() {
        inventoryStackView.subviews[1].bringSubviewToFront(inventoryTableView)
    }
    
    /**
    Brings scanner  view to front of UIScreen
    */
    func bringForwardScannerView() {
        inventoryStackView.subviews[1].bringSubviewToFront(scannerView)
    }
    
    /**
    Brings cart collection view to front of UIScreen
    */
    func bringForwardShoppingCart() {
        
        // reload collection's view data on main thread
        DispatchQueue.main.async { [weak self] in
            self?.cartCollectionView.reloadData()
        }
        
        inventoryStackView.subviews[1].bringSubviewToFront(cartCollectionView)
    }
}

extension InventoryViewController: InventoryTableViewDelegate {
    var itemArray: [ItemsClass] {
        get {
            return _itemArray
        }
    }
    
    func itemSelected(_ index: Int) {
        if let vc = storyboard?.instantiateViewController(identifier: "itemVC") as? ItemViewController {
            vc.item = _itemArray[index]
            vc.itemDelegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension InventoryViewController: CartCollectionViewDelegate {
    var cartArray: [ItemsClass] {
        get { return _cartArray }
    }
}

extension InventoryViewController: ItemViewControllerDelegate {
    func add2Cart(_ item: ItemsClass) {
        for x in _cartArray {
            if (x.equals(id: item.id)) {
                print("item is already in cart")
                return
            }
        }
        
        _cartArray.append(item)
    }
}
