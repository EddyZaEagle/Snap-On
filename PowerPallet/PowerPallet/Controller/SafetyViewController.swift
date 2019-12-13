//
//  SafetyViewController.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/1/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

class SafetyViewController: UIViewController {
    
    @IBOutlet weak var stvSafety: UIStackView!
    @IBOutlet weak var tvSafety: SafetyTableView!
    @IBOutlet weak var navBarSafety: SafetyNavBar!
    @IBOutlet weak var doneView: SafetyDoneView!
    
    private var _specs: [String] = [String().safety1, String().safety2, String().safety3, String().safety4, String().safety5, String().safety6, String().safety7, String().safety8, String().safety9, String().safety10,String().safety11, String().safety12, String().safety13, String().safety14, String().safety15, String().safety16, String().safety17, String().safety18]
    
    private var safetyCheckArray: [SafetyCheckClass] = [SafetyCheckClass]()
    
    private var allDone: Bool {
        for x in safetyCheckArray {
            if x.passFail == nil { return true }
        }
        return false
    }
    
    private var specsFailed: Bool {
        for x in safetyCheckArray {
            if !x.passFail! { return true }
        }
        
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tvSafety.delegate = stvSafety.subviews[2] as! SafetyTableView
        tvSafety.dataSource = stvSafety.subviews[2] as! SafetyTableView
        
        let delegateNavBar = stvSafety.subviews[0] as! SafetyNavBar
        delegateNavBar.safetyNavBarProtocol = self
        
        let delegateDoneView = stvSafety.subviews[3] as! SafetyDoneView
        delegateDoneView.doneDelegate = self
        
        let safetDelegate = stvSafety.subviews[2] as! SafetyTableView
        safetDelegate.safetySpecsDelegate = self
        
        loadSpecificationArray()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tvSafety.allowsSelection = false
    }
    
    private func loadSpecificationArray() {
        for specs in _specs {
            safetyCheckArray.append(SafetyCheckClass(safetySpecification: specs))
        }
    }
    
}

extension SafetyViewController: SafetNavBarProtocol {
    
    func didTapExit() {
        print("Exit button was tapped in protocol")
        
        safetyCheckArray.removeAll()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func didTapBack() {
        print("Back button was tapped in the safety protocol")
        
        tvSafety.isHidden = false
        doneView.isHidden = false
    }
    
    func didTapPDF() {
        print("PDF bring forward")
        
        tvSafety.isHidden = true
        doneView.isHidden = true
    }
}

extension SafetyViewController: DoneProtocol {
    func checkAllSafetySpecs() {
        if(allDone) {
            print("not all specification have been checked off")
        }
        else {
            if (specsFailed) {
                if let vc = storyboard?.instantiateViewController(identifier: "emailVC") as? EmailViewController {
                    vc.emailProtocol = self
                    vc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
                    self.present(vc, animated: true, completion: nil)
                }
                else { print("can't present email view controller") }
            }
            else {
                self.view.window?.rootViewController?.dismiss(animated: true, completion: {
                    self.safetyCheckArray.removeAll()
                })
            }
        }
    }
}

extension SafetyViewController: SafetySpecificationProtocol, SafetyButtonColor, EmailVCProtocol {
    var failedSpecs: [SafetyCheckClass] {
        get {
            let x = safetyCheckArray.filter { !$0.passFail! }
            return x
        }
    }
    
    
    var specificationArrayRef: [SafetyCheckClass] {
        get { return safetyCheckArray }
    }
    
    func passFailButton(_ booleanValue: Bool, safetyButton: UIButton) {
        safetyCheckArray[safetyButton.tag].passFail = booleanValue
    }
    
    var safetyCount: Int {
        get {
            return _specs.count
        }
    }
    
}
