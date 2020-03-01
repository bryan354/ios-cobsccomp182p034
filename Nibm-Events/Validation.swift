//
//  Validation.swift
//  Nibm-Events
//
//  Created by Bryan Charles on 2/28/20.
//  Copyright © 2020 Bryan Charles. All rights reserved.
//

import Foundation

class Validations{
    
    func validEmail(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,3}"
        return NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: email)
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validUsername(username: String) -> Bool {
        return username.count > 2 && username.count < 20
    }
}
