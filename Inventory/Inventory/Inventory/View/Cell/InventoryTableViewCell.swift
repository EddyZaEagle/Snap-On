//
//  InventoryTableViewCell.swift
//  Inventory
//
//  Created by Adam Moreno on 12/13/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

class InventoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgInventory: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        imgInventory = nil
    }

}
