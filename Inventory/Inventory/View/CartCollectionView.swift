//
//  CartCollectionView.swift
//  Inventory
//
//  Created by Adam Moreno on 12/16/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol CartCollectionViewDelegate {
    func itemSelected(_ index: Int)
    var cartArray: [ItemsClass] { get }
}

class CartCollectionView: UICollectionView {
    
    var cartDelegate: CartCollectionViewDelegate?
    
}

extension CartCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let delegate = cartDelegate else {
            print("error with cart collection view delegate")
            return 0
        }
        
        return delegate.cartArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCollectionViewCell
        
        guard let delegate = cartDelegate else {
            cell.lblItemDiscription.text = "Item number: \(indexPath.row)"
            
            return cell
        }
        
        cell.lblItemDiscription.text = delegate.cartArray[indexPath.row].item
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Tapped item \(indexPath.row)")
        if let delegate = cartDelegate {
            delegate.itemSelected(indexPath.row)
        }
        else { print("error eith cart selected delegate") }
    }
    
}
