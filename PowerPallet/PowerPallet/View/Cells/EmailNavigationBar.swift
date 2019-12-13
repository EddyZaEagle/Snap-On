//
//  EmailNavigationBar.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/2/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol EmailProtocol {
    func didTapBackButton()
}

class EmailNavigationBar: UINavigationBar {
    
    var emailProtocol: EmailProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpEmailNavBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpEmailNavBar()
    }
    
    @objc fileprivate func leftButton() {
        if let leftDelegate = emailProtocol {
            leftDelegate.didTapBackButton()
        }
        else { print("error with email delegate") }
    }

    private func setUpEmailNavBar() {
        self.topItem?.title = "EMAIL"
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.snapOnGold]
        
        // change bar apperance
        self.barStyle = UIBarStyle.black
        self.isTranslucent = false
    }

}
