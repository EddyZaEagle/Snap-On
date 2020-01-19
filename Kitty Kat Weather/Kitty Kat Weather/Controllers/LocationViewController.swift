//
//  LocationViewController.swift
//  Kitty Kat Weather
//
//  Created by Adam Moreno on 1/17/20.
//  Copyright © 2020 Adam Moreno. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    private var locationView: LocationView!

    override func viewDidLoad() {
        super.viewDidLoad()

        locationView = self.view as? LocationView
        locationView.locationDelegate = self
    }

}

extension LocationViewController: LocationDelegatet {
    func printLocation() {
        LocationManager.instance.fetchDarkSky { (result) in
            switch result {
            case .success(let weather):
                print(weather)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
}
