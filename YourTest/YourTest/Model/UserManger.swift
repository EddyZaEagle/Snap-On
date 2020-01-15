//
//  UserManger.swift
//  YourTest
//
//  Created by Adam Moreno on 1/13/20.
//  Copyright © 2020 Adam Moreno. All rights reserved.
//

import Foundation

final class UserManager {
    private var user = User()
    static let instance = UserManager()
    
    private init(){}
    
    public func userName(name: String) {
        if (name.count > 3) {
            user.setName(name: name)
        }
        else { print("user name is too short") }
    }
    
    public func userEmail(email: String) {
        if (email.count > 3) {
            user.setEmail(email: email)
        }
        else { print("user email is too short") }
    }
    
    public func getUserName() -> String {
        let name = user.getName()
        
        if (name.isEmpty) { return "user name is Empty" }
        
        return name
    }
    
    public func getUserEmail() -> String {
        let email = user.getEmail()
        
        if (email.isEmpty) { return "user email is Empty" }
        
        return email
    }
    
    public func doKatieTask(link: String) -> Int {
        guard let myValue = user.hasFailed else {
            return -1
        }
        
        if (myValue) { return 1}
        
        return 0
    }
}
