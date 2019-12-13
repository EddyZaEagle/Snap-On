//
//  EmailSendView.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/2/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol SendProtocol {
    func sendEmail()
}

class EmailSendView: UIView {

    @IBOutlet weak var  btnSend: UIButton!
    
    var sendProtolcol: SendProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSendButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpSendButton()
    }
    
    @IBAction private func sendButton() {
        if let send = sendProtolcol {
            send.sendEmail()
        }
        else { print("error with send protocol") }
    }
    
    private func setUpSendButton() {
        self.backgroundColor = .black
        btnSend.backgroundColor = .snapOnRed
        btnSend.setTitle("Send", for: .normal)
        btnSend.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        btnSend.setTitleColor(.snapOnGold, for: .normal)
        
        btnSend.layer.cornerRadius = 5
        btnSend.layer.borderColor = UIColor.snapOnGray.cgColor
        btnSend.layer.borderWidth = 2
    }

}
