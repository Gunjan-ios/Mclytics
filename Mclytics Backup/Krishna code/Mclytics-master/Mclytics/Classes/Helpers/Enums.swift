//
//  Enums.swift
//  Matchfit
//
//  Created by Gunjan Raval on 23/08/18.
//  Copyright © 2018 Gunjan. All rights reserved.
//
//

import Foundation

enum UserDataKey: String {
    
    case userId, firstName, lastName, email, address, dob, gender, role, phone, loginSkipped
    
    enum Authorization: String {
        case accessToken, uId
    }
}
enum LocationManagerResponse: String {
    case success, denied = "Please turn on location services for Headcount", disabled = "Please enable location services"
}

enum AppEnvironment {
    
    case dev, epicapps, beta, live
}


enum LocationType {
    case denver, current, cudenver
}


enum AlertType {
    case error, success,issue
}


enum Gender: String {
    case male, female
}









