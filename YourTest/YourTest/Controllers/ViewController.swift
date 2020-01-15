//
//  ViewController.swift
//  YourTest
//
//  Created by Adam Moreno on 1/13/20.
//  Copyright © 2020 Adam Moreno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var  txtEmail: UITextField!
    
    var _hasFail: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doTask() {
        UserManager.instance.userName(name: txtName.text!)
        UserManager.instance.userEmail(email: txtEmail.text!)
        
        switch UserManager.instance.doKatieTask(link: txtEmail.text!) {
        case 0:
            _hasFail = false
            break
        case 1:
            _hasFail = true
            break
        default:
            print("hasFailed is nil")
            break
        }
        
        if let vc = storyboard?.instantiateViewController(identifier: "otherVC") as? OtherViewController {
            vc.modalPresentationStyle = .fullScreen
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }

}

extension ViewController: KatieDelegate {
    var hasFailed: Bool {
        get {
            return _hasFail
        }
        set {
            _hasFail = newValue
        }
    }
    
    
}
