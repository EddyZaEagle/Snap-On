//
//  SafetyTableView.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/1/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit

protocol SafetySpecificationProtocol {
    var safetyCount: Int { get }
    var specificationArrayRef: [SafetyCheckClass] { get }
}

class SafetyTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var safetySpecsDelegate: SafetySpecificationProtocol?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let delegate = safetySpecsDelegate else {
            return 0
        }
        return delegate.safetyCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "safetyCell", for: indexPath) as! SafetyTableViewCell
        var specificationText: String
        if let specsDelegate = safetySpecsDelegate {
            specificationText = specsDelegate.specificationArrayRef[indexPath.row].safetySpecification
            if let specBoolean = specsDelegate.specificationArrayRef[indexPath.row].passFail {
                cell.reuseButtonColor(specBoolean)
            }
        }
        else {
            specificationText = "................"
        }
        
        cell.safetyButton = self
        cell.lblSafetySpecs.text = specificationText
        cell.btnFail.tag = indexPath.row
        cell.btnPass.tag = indexPath.row
        
        return cell
    }
}

extension SafetyTableView: SafetyButtonColor {
    func passFailButton(_ booleanValue: Bool, safetyButton: UIButton) {
        if let arrayDelegate = safetySpecsDelegate {
            arrayDelegate.specificationArrayRef[safetyButton.tag].passFail = booleanValue
        }
        else { print("error with specification array delegate")}
    }
}
