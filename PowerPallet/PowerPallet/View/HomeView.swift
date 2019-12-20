//
//  HomeView.swift
//  PowerPallet
//
//  Created by Adam Moreno on 11/30/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol HomeDelegate {
    func didTapLoginButton()
    func didTapMaintenanceButton()
}

class HomeView: UIView {
    
    @IBOutlet weak var lblheader: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnMaintenance: UIButton!
    
    var homeDelegate: HomeDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHomeView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //setHomeView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setHomeView()
    }
    
    @IBAction private func loginButton() {
        if let loginDelegate = homeDelegate {
            loginDelegate.didTapLoginButton()
        }
        else { print("Error with home delegate") }
    }
    
    @IBAction private func maintenanceButton() {
        if let maintenanceDelegate = homeDelegate {
            maintenanceDelegate.didTapMaintenanceButton()
        }
        else { print("Error with home delegate") }
    }
    
    private func setHomeView() {
        self.backgroundColor = .snapOnRed
        setLoginButton()
        setUpHeaderLabel()
        setMaintenanceButton()
    }
    
    private func setUpHeaderLabel() {
        lblheader.text = "Power Pallet"
        lblheader.font = UIFont.boldSystemFont(ofSize: 22)
        lblheader.textColor = .snapOnGold
    }
    
    private func setLoginButton() {
        btnLogin.setTitle("LogIn", for: .normal)
        btnLogin.setTitleColor(.snapOnGold, for: .normal)
        btnLogin.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
    }
    
    private func setMaintenanceButton() {
        btnMaintenance.setTitle("Maintenance", for: .normal)
        btnMaintenance.setTitleColor(.snapOnGold, for: .normal)
        btnMaintenance.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
    }

}
