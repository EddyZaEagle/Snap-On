//
//  MasterViewController.swift
//  Inventory
//
//  Created by Adam Moreno on 1/2/20.
//  Copyright © 2020 Adam Moreno. All rights reserved.
//

import UIKit

class MasterNavBarViewController: UIViewController {

    @IBOutlet weak var masterview: UIView!
    private var masterTabBar: MasterTabViewController!
    private var scannerVC: ScannerViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        masterTabBar = storyboard?.instantiateViewController(identifier: "masterTabVC") as? MasterTabViewController
        masterTabBar.view.frame = CGRect(x: 0, y: 0, width: self.masterview.frame.width, height: self.masterview.frame.height)

        scannerVC = storyboard?.instantiateViewController(identifier: "scannerVC") as? ScannerViewController
        scannerVC.view.frame = CGRect(x: 0, y: 0, width: self.masterview.frame.width, height: self.masterview.frame.height)
        scannerVC.vcdelegate = self
        
        masterview.addSubview(masterTabBar.view)
        masterview.addSubview(scannerVC.view)
        scannerVC.didMove(toParent: self)
    }

}

extension MasterNavBarViewController: VCDelgate {
    func bringMaster2Front() {
        masterview.bringSubviewToFront(masterTabBar.view)
        masterTabBar.didMove(toParent: self)
    }
}
