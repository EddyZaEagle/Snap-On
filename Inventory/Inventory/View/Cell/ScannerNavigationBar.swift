//
//  ScannerNavigationBar.swift
//  Inventory
//
//  Created by Adam Moreno on 12/12/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol ScannerNavigationDelegate {
    func dismissScannerViewController()
}

class ScannerNavigationBar: UINavigationBar {
    
    var scannerDelegate: ScannerNavigationDelegate? // reference to protocol
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpNavigationBar()
    }
    
     /**
     Adopting and implementing delegate to dismiss scanner view controller
     */
    @objc fileprivate func leftButton() {
        if let delegate = scannerDelegate {
            delegate.dismissScannerViewController()
        }
        else { print("error with scanner left button protocol") }
    }
    
    /**
     Set up scanner's navigation bar
     */
    private func setUpNavigationBar() {
        self.barStyle = UIBarStyle.black
        self.isTranslucent = false
        setUpNavigationTitle()
        setUpLeftBarItemButton()
    }
    
    /**
     Set up Navigation title
     */
    private func setUpNavigationTitle() {
        self.topItem?.title = "Scanner" // set top item title text
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.snapOnGold] // set title text color to gold
    }
    
    /**
     Set up Navigation left button
     */
    private func setUpLeftBarItemButton() {
        // Initialize bar button item
        let left = UIBarButtonItem(title: "BACK", style: .done, target: self, action: #selector(leftButton))
        left.tintColor = .white // set left button label text font color
        self.topItem?.leftBarButtonItem = left // assigning left bar button item
    }

}
