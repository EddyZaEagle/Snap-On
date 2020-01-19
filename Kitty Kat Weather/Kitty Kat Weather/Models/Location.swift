//
//  Location.swift
//  Kitty Kat Weather
//
//  Created by Adam Moreno on 1/17/20.
//  Copyright © 2020 Adam Moreno. All rights reserved.
//

import Foundation

protocol LocationProtocol {
    var latitude: Double { get set }
    var longitude: Double { get set }
}

struct Location: LocationProtocol, Codable {
    var latitude: Double
    
    var longitude: Double
}
