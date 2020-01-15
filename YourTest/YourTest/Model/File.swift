//
//  File.swift
//  YourTest
//
//  Created by Adam Moreno on 1/13/20.
//  Copyright © 2020 Adam Moreno. All rights reserved.
//

import Foundation

public class User {
    private var name: String!
    private var userEmail: String!
    public var hasFailed: Bool?
    
    init() {
        name = ""
        userEmail = ""
        hasFailed = nil
    }
    
    deinit {
        // DO some work if needed
    }
    
    public func setName(name: String) { self.name = name }
    
    public func getName() -> String { return name }
    
    public func setEmail(email: String) { userEmail = email }
    
    public func getEmail() ->String { return userEmail }
    
    public static func sendEmailWithRestLing(email: String) {
        // your other code
        
        switch response.result {
        case .success(_):
            //your code
            hasFailed = false
            break
        case .failuare(_):
            // your code
            hasFailed = true
            break
        }
    }
}
