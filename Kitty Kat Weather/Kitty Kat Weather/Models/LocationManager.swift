//
//  LocationManager.swift
//  Kitty Kat Weather
//
//  Created by Adam Moreno on 1/17/20.
//  Copyright © 2020 Adam Moreno. All rights reserved.
//

import Foundation
import os

final class LocationManager {
    private var location: Location!
    
    static let instance = LocationManager()
    
    private init() { }
    
    
    func fetchDarkSky(completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
//        var baseURL = URL(fileURLWithPath: baseURLString)
//        baseURL.appendPathComponent("/SomePath")
//
//        let composeURL = URL(fileURLWithPath: "/SomePath", relativeTo: baseURL)
    
        let headers = [
            "x-rapidapi-host": "dark-sky.p.rapidapi.com",
            "x-rapidapi-key": "5ac8907903msh1ab7417a94dbbb5p145a30jsnc9d0cba6ab99"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://dark-sky.p.rapidapi.com/42.2640448,-88.2673802?lang=en&units=auto")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let vaildData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
//                let json = try JSONSerialization.jsonObject(with: vaildData, options: [])
//                completion(.success(json))
                let weather = try JSONDecoder().decode(WeatherResponse.self, from: vaildData)
                completion(.success(weather))
            } catch let serialization {
                completion(.failure(serialization))
            }
            
        }.resume()
    }
}
