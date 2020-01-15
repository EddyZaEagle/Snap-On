//
//  OtherViewController.swift
//  YourTest
//
//  Created by Adam Moreno on 1/13/20.
//  Copyright © 2020 Adam Moreno. All rights reserved.
//

import UIKit

protocol KatieDelegate {
    var hasFailed: Bool { get set }
}

class OtherViewController: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    var delegate: KatieDelegate?
    
    
    private var _hasFailed: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()

        lblName.text = UserManager.instance.getUserName()
        lblEmail.text = UserManager.instance.getUserEmail()
        
        if let delegate = delegate {
            print("The value foe has failed is: .....\(delegate.hasFailed)!")
        }
        else { print("error with delegate") }
        
        
    }
    

}
