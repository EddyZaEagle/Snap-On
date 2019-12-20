//
//  SafetyDoneView.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/1/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol DoneProtocol {
    func checkAllSafetySpecs()
}

class SafetyDoneView: UIView {
    
    @IBOutlet weak var btnDone: UIButton!
    
    var doneDelegate: DoneProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDoneButton()
        self.backgroundColor  = .black
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setDoneButton()
        self.backgroundColor = .black
    }
    
    @IBAction private func DoneButton() {
        if let done = doneDelegate {
            done.checkAllSafetySpecs()
        }
        else { print("error with done delegate") }
        
        
    }
    
    private func setDoneButton() {
        btnDone.backgroundColor = .snapOnRed
        btnDone.setTitle("DONE", for: .normal)
        btnDone.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        btnDone.setTitleColor(.snapOnGold, for: .normal)
        
        btnDone.layer.cornerRadius = 5
        btnDone.layer.borderColor = UIColor.snapOnGray.cgColor
        btnDone.layer.borderWidth = 2
    }
}
