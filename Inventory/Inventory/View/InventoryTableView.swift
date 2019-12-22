//
//  InventoryTableView.swift
//  Inventory
//
//  Created by Adam Moreno on 12/13/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol InventoryTableViewDelegate {
    func itemSelected(_ index: Int)
    var itemArray: [ItemsClass] { get }
}

class InventoryTableView: UITableView {

    var inventoryDelegate: InventoryTableViewDelegate?

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style.self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension InventoryTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let delegate = inventoryDelegate else {
            return 0
        }
        
        return delegate.itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inventoryCell", for: indexPath) as! InventoryTableViewCell
        
        guard let delegate = inventoryDelegate else {
            cell.lblItemName.text = "Cell number: \(indexPath.row)"
            return cell
        }
        
        cell.lblItemName.text = delegate.itemArray[indexPath.row].item
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = inventoryDelegate {
            delegate.itemSelected(indexPath.row)
        }
        else { print("error with inventory table view delegate") }
    }
    
}
