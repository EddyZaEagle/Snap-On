//
//  MaintenanceCollectionViewCell.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/3/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

class MaintenanceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblPowerPallet: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.backgroundColor = .snapOnRed
        
    }
    
}
