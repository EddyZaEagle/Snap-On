//
//  SafetyTableViewCell.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/1/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol SafetyButtonColor {
    func passFailButton(_ booleanValue : Bool, safetyButton : UIButton)
}

class SafetyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblSafetySpecs: UILabel!
    @IBOutlet weak var btnPass: UIButton!
    @IBOutlet weak var btnFail: UIButton!
    
    var safetyButton: SafetyButtonColor?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setUpButton()
        lblSafetySpecs.adjustsFontSizeToFitWidth = true
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func passButton(_ sender: UIButton) {
        if (isNil()) { btnPass.backgroundColor = .green }
        else if (isRed()) {
            btnPass.backgroundColor = .green
            btnFail.backgroundColor = .lightGray
        }
        
        if let passDelegate = safetyButton {
            passDelegate.passFailButton(true, safetyButton: btnPass)
        }
        else { print("error with pass delegate") }
    }
    
    @IBAction func failButton(_ sender: UIButton) {
        if (isNil()) { btnFail.backgroundColor = .red }
        else if (isGreen()) {
            btnFail.backgroundColor = .red
            btnPass.backgroundColor = .lightGray
        }
        
        if let failDelegate = safetyButton {
            failDelegate.passFailButton(false, safetyButton: btnFail)
        }
        else { print("error with fail delegate") }
    }
    
    private func isNil() -> Bool {
        return btnPass.backgroundColor == .lightGray && btnFail.backgroundColor == .lightGray
    }
    
    private func isGreen() -> Bool {
        return btnPass.backgroundColor == .green && btnFail.backgroundColor == .lightGray
    }
    
    private func isRed() -> Bool {
        return btnPass.backgroundColor == .lightGray && btnFail.backgroundColor == .red
    }
    
    private func setUpButton() {
        btnPass.setTitle("PASS", for: .normal)
        btnPass.backgroundColor = .lightGray
        
        btnFail.setTitle("FAIL", for: .normal)
        btnFail.backgroundColor = .lightGray
    }
    
    override func prepareForReuse() {
        btnFail.backgroundColor = .lightGray
        btnPass.backgroundColor = .lightGray
    }
    
    func reuseButtonColor(_ safetyBoolean: Bool) {
        if (safetyBoolean) {
            btnPass.backgroundColor = .green
        }
        else {
            btnFail.backgroundColor = .red
        }
    }

}
