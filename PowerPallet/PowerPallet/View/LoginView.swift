//
//  LoginView.swift
//  PowerPallet
//
//  Created by Adam Moreno on 11/30/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol LoginProtocol {
    func findEmployee(wms: String) -> Bool
    func findPowerPallet(id: String)
    func exitLogin()
}

class LoginView: UIView {
    @IBOutlet weak var btnFind: UIButton!
    @IBOutlet weak var txtValidate: UITextField!
    @IBOutlet weak var navBarLogin: UINavigationBar!
    @IBOutlet weak var navBarItemBack: UINavigationItem!

    var loginDelegate: LoginProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpNavBar()
        setUpFindButton()
        setUpValidationText()
    }
    
    @IBAction private func findButton() {
        if let delegate = loginDelegate, let validationText = txtValidate.text {
            switch txtValidate.tag {
            case 101:
                if (delegate.findEmployee(wms:validationText)) {
                    txtValidate.tag = 666
                    txtValidate.text?.removeAll()
                    DispatchQueue.main.async {
                        self.txtValidate.attributedPlaceholder = NSAttributedString(string: "Enter Power Pallet ID", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                    }
                }
                else { print("Employee not found") }
            case 666:
                delegate.findPowerPallet(id: validationText)
            default:
                print("unknowen error")
            }
        }
        else { print("error with login delegate") }
    }
    
    @IBAction private func exitButton() {
        print("exit")
        
        if let findDelget = loginDelegate {
            txtValidate.tag = 101
            txtValidate.text?.removeAll()
            DispatchQueue.main.async {
                self.txtValidate.attributedPlaceholder = NSAttributedString(string: "Enter WMS", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            }
            findDelget.exitLogin()
        }
        else { print("error with exit home delegate")}
        
    }
    
    private func setUpNavBar() {
        // change title attributes
        navBarLogin.topItem?.title = "SCANNER"
        navBarLogin.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.snapOnGold]
        
        // change bar apperance
        navBarLogin.barStyle = UIBarStyle.black
        navBarLogin.isTranslucent = false
        
        // change left bar button item apperance
        let leftButton = UIBarButtonItem(title: "EXIT", style: .done, target: self, action: #selector(exitButton))
        leftButton.tintColor = .white
        navBarLogin.topItem?.leftBarButtonItem = leftButton
    }
    
    private func setUpValidationText() {
        txtValidate.tag = 101
        txtValidate.layer.borderWidth = 2.5
        txtValidate.layer.cornerRadius = 5
        txtValidate.layer.borderColor = UIColor.black.cgColor
        txtValidate.backgroundColor = .snapOnGray
        txtValidate.textColor = .white
        txtValidate.attributedPlaceholder = NSAttributedString(string: "Enter WMS", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        txtValidate.textAlignment = .center
    }
    
    private func setUpFindButton() {
        btnFind.layer.masksToBounds = true
        btnFind.layer.cornerRadius = 30
        btnFind.layer.borderWidth = 2.5
        btnFind.layer.borderColor = UIColor.black.cgColor
        btnFind.backgroundColor = .snapOnRed
        btnFind.setTitle("Enter", for: .normal)
        btnFind.setTitleColor(.white, for: .normal)
        btnFind.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
}
