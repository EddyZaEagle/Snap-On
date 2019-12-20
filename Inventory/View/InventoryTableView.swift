//
//  InventoryTableView.swift
//  Inventory
//
//  Created by Adam Moreno on 12/13/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

class InventoryTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style.self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension InventoryTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inventoryCell", for: indexPath) as! InventoryTableViewCell
        
        cell.imageView?.backgroundColor = .lightGray
        cell.lblItemName.text = "Item number: \(indexPath.row)"
        
        return cell
    }
    
    
}