//
//  ScannerView.swift
//  Inventory
//
//  Created by Adam Moreno on 12/12/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol ScannerViewDelegate {
    func findEmployee(wms: String)
}

class ScannerView: UIView {

    @IBOutlet weak var btnEnter: UIButton!
    @IBOutlet weak var txtWMS: UITextField!
    
    var scannerDelegate: ScannerViewDelegate? // refrence to protocol
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        setUpScannerView()
    }
    
    /**
     Adopting and implementing delegate to check if wms text blongs to an employee at snapon
     */
    @IBAction private func enterButton() {
        if let delegate = scannerDelegate, let wmsText = txtWMS.text {
            if (wmsText.checkWMS) {
                delegate.findEmployee(wms: wmsText)
            }
        }
        else { print("error with scanner enter button delegate") }
    }
    
    /**
     Set up scanner's view
     */
    private func setUpScannerView() {
        setUpWMS_Label()
        setUpEnterButton()
    }
    
    /**
     Set up Enter button
     */
    private func setUpEnterButton() {
        btnEnter.translatesAutoresizingMaskIntoConstraints = false
        btnEnter.heightAnchor.constraint(equalToConstant: 60).isActive = true
        btnEnter.widthAnchor.constraint(equalToConstant: 60).isActive = true
        btnEnter.backgroundColor = .snapOnRed
        btnEnter.setTitleColor(.black, for: .normal)
        btnEnter.layer.cornerRadius = 30
        btnEnter.layer.borderWidth = 2.5
        btnEnter.layer.borderColor = UIColor.black.cgColor
        btnEnter.setTitle("Enter", for: .normal)
        btnEnter.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    /**
     Set up wms's label
     */
    private func setUpWMS_Label() {
        txtWMS.tag = 111
        txtWMS.layer.cornerRadius = 5
        txtWMS.layer.borderWidth = 2.5
        txtWMS.layer.borderColor = UIColor.black.cgColor
        txtWMS.backgroundColor = .snapOnGray
        txtWMS.textColor = .white
        txtWMS.attributedPlaceholder = NSAttributedString(string: "Enter WMS", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)])
        txtWMS.textAlignment = .center
    }

}

extension String {
    
    /**
     Checks if charactor are between A and Z in acii values and is not greater than eight.
     - Returns: Boolean
     */
    var checkWMS: Bool {
        if (self.count > 8 && self.isEmpty) { return false } // if wms's charactor count is greater then 8 and is empty
        // iterate through wms string
        for x in self {
            if !isCharA2ZACII(wmsChar: x) { return false }
        }
        
        return true
    }
    
    /**
     Sees if charactor is between 65 and 90
     - Returns: Boolean
     */
    private func isCharA2ZACII(wmsChar: Character) -> Bool {
        return wmsChar.asciiValue! >= UInt8(65) && wmsChar.asciiValue! <= UInt8(90)
    }
}
