//
//  ScannerView.swift
//  Inventory
//
//  Created by Adam Moreno on 12/12/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

@objc protocol ScannerViewDelegate {
    @objc optional func findEmployee(txtField: UITextField)
    @objc optional func findItem(txtFireld: UITextField)
}

class ScannerView: UIView {
    
    lazy var txtWMS: UITextField = {
        let text = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        text.layer.borderWidth = 2.5
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.cornerRadius = 5
        text.textAlignment = .center
        text.attributedPlaceholder = NSAttributedString(string: "Enter WMS", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)])
        text.tag = 111
        text.backgroundColor = .snapOnGray
        text.textColor = .white
        return text
    }()
    
    lazy var btnEnter: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.backgroundColor = .snapOnRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 2.5
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Enter", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(enterButton), for: .touchUpInside)
        return button
    }()
    
    var scannerDelegate: ScannerViewDelegate? // refrence to protocol
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpScannerView()
        
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
    @objc fileprivate func enterButton() {
        if let delegate = scannerDelegate {
            switch txtWMS.tag {
            case 101:
                delegate.findEmployee?(txtField: txtWMS)
                break
            case 666:
                delegate.findItem?(txtFireld: txtWMS)
            default:
                print("unknown error")
            }
        }
        else { print("error with scanner enter button delegate") }
    }
    
    /**
     Set up scanner's view
     */
    private func setUpScannerView() {
        self.addSubview(txtWMS)
        self.addSubview(btnEnter)
        setUpWMS_Label()
        setUpEnterButton()
    }
    
    /**
     Set up Enter button
     */
    private func setUpEnterButton() {
        btnEnter.translatesAutoresizingMaskIntoConstraints = false
        
        btnEnter.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        btnEnter.topAnchor.constraint(equalTo: txtWMS.bottomAnchor, constant: 100).isActive = true
    }
    
    /**
     Set up wms's label
     */
    private func setUpWMS_Label() {
        txtWMS.translatesAutoresizingMaskIntoConstraints = false
        
        txtWMS.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        txtWMS.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        txtWMS.heightAnchor.constraint(equalToConstant: 30).isActive = true
        txtWMS.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100).isActive = true
        
        txtWMS.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100).isActive = true
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
