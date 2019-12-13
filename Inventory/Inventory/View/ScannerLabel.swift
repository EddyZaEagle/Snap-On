//
//  ScannerLabel.swift
//  Inventory
//
//  Created by Adam Moreno on 12/12/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol ScannerLabelProtocol {
    var scannerLabel : UILabel! { get set }
}

class ScannerLabel: UILabel {

    var scannerDelgegate: ScannerLabelProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpScannerLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpScannerLabel()
    }
    
    private func setUpScannerLabel() {
        self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        self.textColor = .black
        self.font = UIFont.boldSystemFont(ofSize: 28)
        self.textAlignment = .center
    }

}
