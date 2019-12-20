//
//  HomeViewController.swift
//  PowerPallet
//
//  Created by Adam Moreno on 11/30/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    enum EmployeeLogin: Error {
        case notWMS
        case notFound
        case badConnection
        case unknownError
        case inValidPermit
    }
    
    enum PowerPalletLogin: Error {
        case notPowerPallet
        case notFound
        case badConnection
        case unknownError
        case isBroken
        case inUse
    }
    
    var ref: DatabaseReference!
    var employee: EmployeeStruct!
    var powerpallet: PowerPalletStruct!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tap)
        
        let delegateHome = self.view.subviews[1] as! HomeView
        delegateHome.homeDelegate = self
        
        let delegateLogin = self.view.subviews[0] as! LoginView
        delegateLogin.loginDelegate = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let loginView = self.view.subviews[1]
        if loginView is LoginView {
            let x = loginView as! LoginView
            x.txtValidate.tag = 101
            x.txtValidate.text?.removeAll()
            DispatchQueue.main.async {
                x.txtValidate.attributedPlaceholder = NSAttributedString(string: "Enter WMS", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            }
        }
        
    }
    
    @objc fileprivate func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    
    private func maintenancePinNumberAlert() {
        let alert: UIAlertController = UIAlertController(title: "PIN NUMBER", message: "Enter pin number", preferredStyle: .alert)
        
        let action: UIAlertAction = UIAlertAction(title: "Enter", style: .default) { (_: UIAlertAction) in
            if let pinText = alert.textFields?.first?.text {
                if pinText.isPin {
                    self.go2MaintenanceVC()
                }
                else {
                    alert.title = "WRONG PIN"
                    alert.message = "Please enter correct pin"
                    alert.textFields?.first?.text?.removeAll()
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "CANCEL", style: .default, handler: nil)
        
        alert.addTextField { (txtPin) in
            txtPin.textAlignment = .center
            txtPin.placeholder = "PIN NUMBER"
            txtPin.keyboardType = .numberPad
        }
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func go2MaintenanceVC() {
        if let vc = storyboard?.instantiateViewController(identifier: "maintenanceVC") as? MaintenanceViewController {
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
        else { print("Could not present maintenance view controller") }
    }
    
    private func go2SafetyViewController() {
        if let vc = self.storyboard?.instantiateViewController(identifier: "safetyVC") as? SafetyViewController {
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: {
                self.view.bringSubviewToFront(self.view.subviews[0])
                self.powerpalletInUse()
            })
        }
        else { print("error can't present safety view controller") }
    }
    
    private func powerpalletInUse() {
        ref = Database.database().reference(withPath: "POWERPALLET").child(powerpallet.id)
        
        ref.updateChildValues(["IS_IN_USE" : true])
    }
}

extension HomeViewController: HomeDelegate {
    func didTapLoginButton() {
        print("login")
        let login = self.view.subviews[0] as! LoginView
        self.view.bringSubviewToFront(login)
    }
    
    func didTapMaintenanceButton() {
        print("maintenace")
        maintenancePinNumberAlert()
    }
}

extension HomeViewController: LoginProtocol {
    func findEmployee(wms: UITextField) {
        
        ref = Database.database().reference(withPath: "EMPLOYEE").child(wms.text!)

        ref.observeSingleEvent(of: DataEventType.value) { (snapshot) in
            if (snapshot.hasChildren()) {
                self.employee = EmployeeStruct(employee: snapshot)
                if (self.employee.experationDate) {
                    wms.text?.removeAll()
                    wms.placeholder = "Enter Power Pallet ID"
                    wms.tag = 666
                }
                else {
                    print("Employee permite as expired!")
                    wms.text?.removeAll()
                }
                
            }
            else { print("WMS NOT FOUND") }
        }
    }
    
    
    func findPowerPallet(id: String) {
        ref = Database.database().reference(withPath: "POWERPALLET").child(id)
        
        ref.observeSingleEvent(of: DataEventType.value) { (snaphot) in
            if (snaphot.hasChildren()) {
                
                self.powerpallet = PowerPalletStruct(powerpallet: snaphot)
                
                if(self.powerpallet.isWorking) {
                    if (!self.powerpallet.isInuse) {
                        self.go2SafetyViewController()
                    }
                    else { print("Power Pallet is in use") }
                }
                else { print("Power Pallet is not working") }
                
                
            }
            else { print("Power pallet not found") }
        }
    }
    
    func exitLogin() {
        self.view.endEditing(true)
        let home = self.view.subviews[0] as! HomeView
        self.view.bringSubviewToFront(home)
    }
}

extension String {
    var isPin: Bool { return self == "3011" }
}
