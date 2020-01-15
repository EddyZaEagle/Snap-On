//
//  ItemViewController.swift
//  Inventory
//
//  Created by Adam Moreno on 12/16/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol ItemViewControllerDelegate {
    func add2Cart(_ item: ItemsClass)
}

class ItemViewController: UIViewController {
    
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var btnAdd2Cart: UIButton!
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var btnUp: UIButton!
    @IBOutlet weak var btnDown: UIButton!
    
    var item: ItemsClass!
    
    var count: Double!
    var itemQTY: Double!
    var itemName: String!
    var itemImage: UIImage!
    var itemID: String!
    
    var itemDelegate: ItemViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
//        if count == nil {
//            count = item.qty
//        }
//        else {
//            itemQTY = item.qty
//        }
//        lblItem.text = item.item
//        lblDiscription.text = "\(Int(count!))"
        
        setUpViewController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if (itemQTY == 0) {
            print("This Item IS EMPTY!")
            btnUp.isEnabled = false
            btnDown.isEnabled = false
            btnAdd2Cart.isEnabled = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        whenviewDisappears()
    }
    
    @IBAction private func upButton() {
        if count < itemQTY {
            count += 1
            lblDiscription.text = "\(Int(count!))"
        }
    }
    
    @IBAction private func downButton() {
        if count > 0 {
            count -= 1
            lblDiscription.text = "\(Int(count!))"
        }
    }
    
    @IBAction func add2CartButton() {
        switch btnAdd2Cart.tag {
        case 666:
            if count > item.qty {
                item.addQTY(amount: count)
            }
            else if count < item.qty {
                item.subtracttQTY(amount: count)
            }
        default:
            if let delegate = itemDelegate {
                delegate.add2Cart(ItemsClass(id: item.id, item: item.item, qty: count))
                print("Item has been added")
            }
            else { print("Error with iem view controller delegate") }
        }
    }
    
    private func whenviewDisappears() {
        lblDiscription.text?.removeAll()
        lblItem.text?.removeAll()
        imgItem = nil
        count = 0
    }
    
    private func setUpViewController() {
        setUpButton()
        setUpAdd2Cart()
        setUpDownButton()
    }
    
    private func setUpButton() {
        btnUp.translatesAutoresizingMaskIntoConstraints = false
        btnUp.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnUp.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        btnUp.layer.cornerRadius = 20
        btnUp.backgroundColor = .red
        btnUp.setTitle("+", for: .normal)
        btnUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btnUp.setTitleColor(.snapOnGold, for: .normal)
    }
    
    private func setUpDownButton() {
        btnDown.translatesAutoresizingMaskIntoConstraints = false
        btnDown.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnDown.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        btnDown.layer.cornerRadius = 20
        btnDown.backgroundColor = .red
        btnDown.setTitle("-", for: .normal)
        btnDown.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btnDown.setTitleColor(.snapOnGold, for: .normal)
    }
    
    private func setUpAdd2Cart() {
        btnAdd2Cart.translatesAutoresizingMaskIntoConstraints = false
        btnAdd2Cart.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnAdd2Cart.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        btnAdd2Cart.layer.cornerRadius = 20
        btnAdd2Cart.layer.borderColor = UIColor.black.cgColor
        btnAdd2Cart.layer.borderWidth = 2
        btnAdd2Cart.backgroundColor = .red
        btnAdd2Cart.setTitle("Add", for: .normal)
        btnAdd2Cart.setTitleColor(.white, for: .normal)
    }

}
