//
//  ScannerViewController.swift
//  Inventory
//
//  Created by Adam Moreno on 12/12/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol VCDelgate {
    func bringMaster2Front()
}

class ScannerViewController: UIViewController {
    
    private var scannerView: ScannerView!
    
    var vcdelegate: VCDelgate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    
    }
    
    // called only once - DO: Initialization here
    override func viewDidLoad() {
        super.viewDidLoad()

        let killKeyBoard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(killKeyBoard)
        
        scannerView = self.view.subviews[0] as? ScannerView // instance of ScannerView
        scannerView.scannerDelegate = self // setting scanner delegate
        
    }
    
    @objc fileprivate func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    
    private func presentInventoryViewController() {
        if let vc = storyboard?.instantiateViewController(identifier: "masterTabVC") as? MasterTabViewController {
            
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
        if txtField.text!.validateWMS {
            if (txtField.text! == "EMORENAM") {
                if let delegate = vcdelegate {
                    delegate.bringMaster2Front()
                }
                else { print("error master") }
            }
            else {
                txtField.selectAll(nil)
                print("not employee")
            }
        }
        else { print("not wms barcode!") }
    }
}
