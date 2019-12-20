//
//  ScannerViewController.swift
//  Inventory
//
//  Created by Adam Moreno on 12/12/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

class ScannerViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let scannerStackView = self.view.subviews[0] as! UIStackView // instance if UIStackView
        
        // instance of ScannerNavigationBar
        let scannerNavBar = scannerStackView.subviews[0] as! ScannerNavigationBar
        scannerNavBar.scannerDelegate = self // setting scanner delegate
        
        let scannerView = scannerStackView.subviews[1] as! ScannerView // instance of ScannerView
        scannerView.scannerDelegate = self // setting scanner delegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let killKeyBoard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(killKeyBoard)
    }
    
    @objc fileprivate func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    
    private func presentInventoryViewController() {
        if let vc = storyboard?.instantiateViewController(identifier: "inventoryVC") as? InventoryViewController {
            vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
        else { print("could not present inventory view controller") }
    }
}

extension ScannerViewController: ScannerNavigationDelegate {
    func dismissScannerViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ScannerViewController: ScannerViewDelegate {
    func findEmployee(txtField: UITextField) {
        if txtField.text!.checkWMS {
            if (txtField.text! == "EMORENAM") {
                presentInventoryViewController()
            }
            else {
                txtField.selectAll(nil)
                print("not employee")
            }
        }
        else { print("not wms barcode!") }
    }
}
