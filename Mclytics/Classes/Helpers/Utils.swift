//
//  Utils.swift
//  iBeacon
//
//  Created by Gunjan on 02/09/19.
//  Copyright © 2019 Gunjan. All rights reserved.
//

import UIKit

class Utils: NSObject {

  static func getAlertController(title : String, message : String) ->  UIAlertController {
        
        let alertVc = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alertVc.view.tintColor = THEME_COLOR
        let attrs = [kCTFontAttributeName as NSAttributedString.Key:UIFont.boldSystemFont(ofSize: 18.0),kCTForegroundColorAttributeName as NSAttributedString.Key:THEME_COLOR]
        let hogen = NSMutableAttributedString.init(string: title, attributes: attrs)
        alertVc.setValue(hogen,forKey: "attributedTitle")
        let attrsM  = [kCTFontAttributeName as NSAttributedString.Key:UIFont.systemFont(ofSize: 15.0) ,kCTForegroundColorAttributeName as NSAttributedString.Key:UIColor.black]
        let hogenMessage = NSMutableAttributedString.init(string: message, attributes: attrsM)
        alertVc.setValue(hogenMessage,forKey: "attributedMessage")
        return alertVc
    }
    
}

