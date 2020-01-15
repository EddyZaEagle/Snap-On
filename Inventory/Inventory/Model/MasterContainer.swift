//
//  MasterContainer.swift
//  Inventory
//
//  Created by Adam Moreno on 1/3/20.
//  Copyright © 2020 Adam Moreno. All rights reserved.
//

import Foundation
import UIKit

class WeakObject {
    weak var object: AnyObject?
    init(obj: AnyObject) {
        self.object = obj
    }
}

class MasterContainer {
    private weak var rootController: UIViewController?
    private var controller = [WeakObject]()
    
    init(rootViewController: UIViewController) {
        rootController = rootViewController
    }
    
    public func addController(vc: UIViewController) {
        controller.append(WeakObject(obj: vc))
        rootController?.addChild(vc)
        rootController?.view.addSubview(vc.view)
    }
    
    deinit {
        for x in controller {
            x.object?.view?.removeFromSuperview()
            x.object?.removeFromParent()
        }
    }
}
