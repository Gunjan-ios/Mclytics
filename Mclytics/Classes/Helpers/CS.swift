//
//  Strings.swift
//  Matchfit
//
//  Created by Gunjan Raval on 23/08/18.
//  Copyright © 2018 Gunjan. All rights reserved.
//
//

import Foundation

class CS {
    
    struct EndPoints {
      static let Login = "Login"
    }
    
    struct Params {
        static let email = "email"
        static let password = "password"
        static let page = "page"
    }
    struct validtionForm {
        
        // data type
      static  let ERROR_HEADING = "heading"
      static let ERROR_PARAGRAPH = "paragraph"
       static  let ERROR_TEXT = "Please enter text "
       static  let ERROR_EMAIL = "email"
       static  let ERROR_PHONE = "phone"
       static  let ERROR_TEXTAREA = "textarea"
       static  let ERROR_CHECKBOX = "checkbox"
       static  let ERROR_RADIO = "radio"
       static  let ERROR_SIDEBYSIDE = "sidebyside"
       static  let ERROR_RATING = "rating"
       static  let ERROR_DATE = "date"
       static  let ERROR_SELECTLIST = "selectlist"
       static  let ERROR_IMAGE = "image"
       static  let ERROR_VIDEO = "video"
       static  let ERROR_FILE = "file"
       static  let ERROR_SIGNATURE = "signature"
       static  let ERROR_RANKINGSCALE = "rankingscale"
       static  let ERROR_MATRIX = "matrix"
       static  let ERROR_CARRYFORWARD = "carryforward"
       static  let ERROR_VIDEO_CAP = "video_cap"
       static  let ERROR_AUDIO = "audio"
       static  let ERROR_GEOLOCATION = "geolocation"
       static  let ERROR_RECAPTCHA = "recaptcha"
       static  let ERROR_ROSTERGROUP = "rostergroup"
        

    }
    
    struct Common {
        static let waiting = "Loading..."
        static let defaultFailedMessage = "Failed. Please try again."
        static let cameramessage = "Can't aceess camera in this device."
        static let Getdata = "Getting Data Successfully"
        static let pushdata = "Data saved."
        static let Connected = "Internet connected."
        static let NoData = "Nothing availbable to display. \n\nTry getting and filling out a blank form."
        static let Internet = "Check your internet connection."
        static let FetchData = "Fetching data..."
        static let wrongMsg = "Something went wrong. Please try again."
        static let validationMsg = "Please check all required fields."
        static let singleValidationMsg = "Field is required"
        static let carryForwardMsg = "CarryForward is not supported"
        static let RoasterMsg = "Roaster Group is not supported"

        

       

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

