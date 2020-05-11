//
//  Strings.swift
//  Matchfit
//
//  Created by Gunjan Raval on 23/08/18.
//  Copyright © 2018 Gunjan. All rights reserved.
//
//

import Foundation

class Strings {
    
    struct EndPoints {
      static let Login = "Login"
    }
    
    struct Common {
        static let waiting = "Please wait.."
        static let defaultFailedMessage = "Failed. Please try again."
        static let cameramessage = "Can't aceess camera in this device."
        static let Getdata = "Getting Data Successfully"
        static let pushdata = "Data saved."
        static let Connected = "Internet connected."
        static let NoData = "Data not Found."
        static let Internet = "Check your internet connection."
        static let FetchData = "Fetching data..."
    }
    struct Login {
        static let invalidName = "Please enter a valid name."
        static let invalidEmail = "Please enter a valid Email."
        static let invalidpasswrod = "Please enter a valid password."
        static let invalidConfirmpasswrod = "Please enter a valid Confirmpassword."
        static let ConfrimPasswrod = "Do not match password."
        static let invalidcredentials = "Please enter a valid login credentials."
        static let Terms = "Please Select Term & Condition."
        
    }
    struct Location {
        static let locationDisabled = "Location services are disabled."
        static let locationDenied = "Access to location service is disabled."
    }
    
    

}

