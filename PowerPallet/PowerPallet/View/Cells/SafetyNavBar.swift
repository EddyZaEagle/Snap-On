//
//  SafetyNavBar.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/1/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol SafetNavBarProtocol {
    func didTapExit()
    func didTapBack()
    func didTapPDF()
}

class SafetyNavBar: UINavigationBar {
    
    @IBOutlet weak var btnLeftButton: UIBarItem!
    @IBOutlet weak var btnRightButton: UIBarItem!
    
    var safetyNavBarProtocol: SafetNavBarProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpNavBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpNavBar()
    }
    
    @objc fileprivate func leftButton() {
        print("left button was tapped")
        
        if let leftDelgate = safetyNavBarProtocol {
            if (self.topItem?.rightBarButtonItem == nil) {
                leftDelgate.didTapBack()
                self.topItem?.leftBarButtonItem?.title = "EXIT"
                
                let right = UIBarButtonItem(title: "PDF", style: .plain, target: self, action: #selector(rightButton))
                right.tintColor = .white
                self.topItem?.rightBarButtonItem = right
            }
            else {
                leftDelgate.didTapExit()
            }
        }
        else {
            print("error with left button delegate")
        }
    }
    
    @objc fileprivate func rightButton() {
        print("right button was tapped")
        
        if let rightdelegate = safetyNavBarProtocol {
            rightdelegate.didTapPDF()
            self.topItem?.rightBarButtonItem = nil
            self.topItem?.leftBarButtonItem?.title = "BACK"
        }
        else { print("error with safety right delegate right button") }
    }

    private func setUpNavBar(){
        self.topItem?.title = "SAETY CHECK"
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.snapOnGold]
        
        // change bar apperance
        self.barStyle = UIBarStyle.black
        self.isTranslucent = false
        
        // change left bar button item apperance
        let left = UIBarButtonItem(title: "EXIT", style: .done, target: self, action: #selector(leftButton))
        left.tintColor = .white
        self.topItem?.leftBarButtonItem = left
        
        // CHange right bar button item apperance
        let right = UIBarButtonItem(title: "PDF", style: .plain, target: self, action: #selector(rightButton))
        right.tintColor = .white
        self.topItem?.rightBarButtonItem = right

    }
    
    
    
    

}
