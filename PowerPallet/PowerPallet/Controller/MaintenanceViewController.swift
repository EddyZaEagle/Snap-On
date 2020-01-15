//
//  MaintenanceViewController.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/7/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

class MaintenanceViewController: UIViewController {
    
    @IBOutlet weak var stvMaintenance: UIStackView!
    @IBOutlet weak var cvMaintenance: UICollectionView!
    
    var intArray: [Int] = [1,3,5,6]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let maintenanceDelegate = stvMaintenance.subviews[0] as! MaintenanceNavigationBar
        maintenanceDelegate.maintenanceProtocol = self

        cvMaintenance.delegate = self
        cvMaintenance.dataSource = self
        
        let tapPressGesture = UITapGestureRecognizer(target: self, action: #selector(deleteCellTapped(_:)))
        
        cvMaintenance.addGestureRecognizer(tapPressGesture)
    }
    
    @objc fileprivate func deleteCellTapped(_ gestureGecognizer: UITapGestureRecognizer) {
        let tapPoint = gestureGecognizer.location(in: cvMaintenance)
        guard let indexPath = cvMaintenance.indexPathForItem(at: tapPoint), let tappedCell = cvMaintenance.cellForItem(at: indexPath) else {
            return
        }
        
        guard let myIndex = cvMaintenance.indexPathsForSelectedItems else { return }
        
        print("\(indexPath.description) :.........: \(tappedCell.description)")
        
        let alert: UIAlertController = UIAlertController(title: "FIXED!", message: "Is Power Pallet fixed?", preferredStyle: .actionSheet)
        
        let fixAction: UIAlertAction = UIAlertAction(title: "YES", style: .default) { [weak self] (_) in
            self?.cvMaintenance.deleteItems(at: myIndex)
            self?.intArray.remove(at: indexPath.row)
            
            DispatchQueue.main.async { [weak self] in
                self?.cvMaintenance.reloadData()
            }
            
        }
        
        let notFixedAction: UIAlertAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        
        alert.addAction(fixAction)
        alert.addAction(notFixedAction)
        
        if let popOver = alert.popoverPresentationController {
            popOver.sourceView = tappedCell
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }

}

extension MaintenanceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return intArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "maintenanceCell", for: indexPath) as! MaintenanceCollectionViewCell
        
        cell.lblPowerPallet.text = "This cell number \(intArray[indexPath.row])"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cvMaintenance.bounds.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "maintenanceCell", for: indexPath) as? MaintenanceCollectionViewCell else {
            
            print("nein")
            return
        }
        
        print("ja")
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            print("9")
            cell.contentView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (_) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
                print("nill")
                cell.contentView.transform = .identity
            }, completion: nil)
        }
    }
}

extension MaintenanceViewController: maintenanceNavBarProtocol {
    func back2Home() {
        self.dismiss(animated: true, completion: nil)
    }
}
