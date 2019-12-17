//
//  ItemCollectionViewCell.swift
//  Inventory
//
//  Created by Adam Moreno on 12/16/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblItemDiscription: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnUp: UIButton!
    @IBOutlet weak var btnDown: UIButton!
    @IBOutlet weak var txtQTY: UITextView!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .snapOnRed
    }
    
}
