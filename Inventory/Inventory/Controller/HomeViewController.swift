//
//  HomeViewController.swift
//  Inventory
//
//  Created by Adam Moreno on 12/12/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var btnScanner: UIButton!
    @IBOutlet weak var lblHeader: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpHomeViewCoontroller()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /**
     Present Scanner view controller
     */
    @IBAction private func scannerButton() {
        // create instance of master nav bar view controller to present
        if let vc = storyboard?.instantiateViewController(identifier: "masterVC") as? MasterNavBarViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        else { print("Can not present Master Nav Bar view controller")}
    }
    
    /**
     Set up Home's view controller.
     */
    private func setUpHomeViewCoontroller() {
        self.view.backgroundColor = .snapOnRed // initialize view's background color
        setUpHeaderLabel()
        SetUpScannerButton()
    }
    
    /**
     Set up header label
     */
    private func setUpHeaderLabel() {
        lblHeader.text = "Inventory" // initialize text
        lblHeader.font = UIFont.boldSystemFont(ofSize: 28) // initialize font size
        lblHeader.textColor = .snapOnGold // initialize text color to snap on gold
        lblHeader.textAlignment = .center
        lblHeader.accessibilityIdentifier = "HomeHeaderLabel"
    }
    
    /**
     Set up scanner button
     */
    private func SetUpScannerButton() {
        btnScanner.setTitle("Scanner", for: .normal) // set button label
        btnScanner.setTitleColor(.snapOnGold, for: .normal) // set button label font color to snap on gold
        btnScanner.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22) // set button label font size
        btnScanner.accessibilityIdentifier = "HomeEnterButton"
    }
}
