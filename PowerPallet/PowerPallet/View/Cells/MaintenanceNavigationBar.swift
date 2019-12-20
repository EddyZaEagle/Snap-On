//
//  MaintenanceNavigationBar.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/2/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol maintenanceNavBarProtocol {
    func back2Home()
}

class MaintenanceNavigationBar: UINavigationBar {

    var maintenanceProtocol: maintenanceNavBarProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpNaigationBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpNaigationBar()
    }
    
    @objc fileprivate func leftBarButton() {
        if let delegate = maintenanceProtocol {
            delegate.back2Home()
        }
    }
    
    private func setUpNaigationBar() {
        self.topItem?.title = "SAETY CHECK"
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.snapOnGold]
        
        // change bar apperance
        self.barStyle = UIBarStyle.black
        self.isTranslucent = false
        
        // change left bar button item apperance
        let left = UIBarButtonItem(title: "BACK", style: .done, target: self, action: #selector(leftBarButton))
        left.tintColor = .white
        self.topItem?.leftBarButtonItem = left
    }

}
