//
//  Weather.swift
//  Kitty Kat Weather
//
//  Created by Adam Moreno on 1/17/20.
//  Copyright © 2020 Adam Moreno. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var description: String
    var regions: [String]
}

struct WeatherResponse: Codable {
    let alerts: [Weather]
}
