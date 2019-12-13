//
//  SafetySpecs.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/7/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import Foundation

protocol SafetyCheck {
    var safetySpecification: String { get }
    var passFail: Bool? { get set }
    init(safetySpecification: String)
}

class SafetyCheckClass: SafetyCheck {
    private var _specification: String
    private var _passFail: Bool?
    
    var safetySpecification: String {
        get {
            return _specification
        }
    }
    
    var passFail: Bool? {
        get { return _passFail }
        set { _passFail = newValue }
    }
    
    required init(safetySpecification: String) {
        _specification = safetySpecification
        _passFail = nil
    }
    
    deinit {
        _specification.removeAll()
        _passFail = nil
    }
    
    
}

extension String {
    public var safety1: String {
        get {
            return "Fork Rollers - Condition, Free of Debris"
        }
    }
    public var safety2: String {
        get {
            return "Drive wheel - Condition, Free of Debris"
        }
    }
    public var safety3: String {
        get {
            return "Steer wheels - Condition, Free of Debris"
        }
    }
    public var safety4: String {
        get {
            return "Steering Operation - Functioning Smoothly"
        }
    }
    public var safety5: String {
        get {
            return "No Riding Label - Attached"
        }
    }
    public var safety6: String {
        get {
            return "Battery - Physical Damage"
        }
    }
    public var safety7: String {
        get {
            return "Capacity Label - Attached"
        }
    }
    public var safety8: String {
        get {
            return "Batter Restraint System - Operates"
        }
    }
    public var safety9: String {
        get {
            return "Throttle - Functioning Smoothly"
        }
    }
    public var safety10: String {
        get {
            return "Lift Lower Function - Operational"
        }
    }
    public var safety11: String {
        get {
            return "Hydraulic Oil Leakes - No Leaks"
        }
    }
    public var safety12: String {
        get {
            return "Operating Mode Indicator - Functioning"
        }
    }
    public var safety13: String {
        get {
            return "Battery Discharge Indicator - Functioning"
        }
    }
    public var safety14: String {
        get {
            return "Belly Button - Functioning"
        }
    }
    public var safety15: String {
        get {
            return "Horn - Functioning"
        }
    }
    public var safety16: String {
        get {
            return "Drive Control - Forward Reverse - Functioning Smoothly"
        }
    }
    public var safety17: String {
        get {
            return "Service Brake - Functioning Smoothly"
        }
    }
    public var safety18: String {
        get {
            return "Parking Brake - Functioning Smoothly"
        }
    }
}
