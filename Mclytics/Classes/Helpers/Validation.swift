//
//  Validation.swift
//  Matchfit
//
//  Created by Gunjan Raval on 23/08/18.
//  Copyright © 2018 Gunjan. All rights reserved.
//
//

import Foundation

class Validation {
    
    private func validatePattern(pattern: String, value: String) -> Bool {
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with: value)
    }
    
    func isValidEmail(email: String) -> Bool {
        return self.validatePattern(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", value: email)
    }
    
    func isValidPhone(phone: String) -> Bool {
        return self.validatePattern(pattern: "+[0-9]{10}", value: phone)
    }
    
    func isValidGender(gender: String) -> Bool {
        
        if let _ = Gender(rawValue: gender) {
            return true
        } else {
            return false
        }
    }
    
    func isValidName(name: String) -> Bool {

        return self.validatePattern(pattern: "^[0-9a-zA-Z\\_]{1,18}$", value: name)
    }
    
    func isValidPassword(Password: String) -> Bool {
        
         return self.validatePattern(pattern: "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{4,15}", value: Password)
    }
    
    
    
    
}
