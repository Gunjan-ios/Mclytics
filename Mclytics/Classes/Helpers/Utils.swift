//
//  Utils.swift
//  iBeacon
//
//  Created by Gunjan on 02/09/19.
//  Copyright © 2019 Gunjan. All rights reserved.
//

import UIKit
import JQProgressHUD
import Foundation
import SwiftyJSON

class Utils: NSObject {

    static func getAlertController(title : String, message : String ,style: UIAlertController.Style) ->  UIAlertController {
        
        let alertVc = UIAlertController.init(title: title, message: message, preferredStyle: style)
        alertVc.view.tintColor = colorPrimary
        let attrs = [kCTFontAttributeName as NSAttributedString.Key:UIFont.boldSystemFont(ofSize: 18.0),kCTForegroundColorAttributeName as NSAttributedString.Key:colorPrimary]
        let hogen = NSMutableAttributedString.init(string: title, attributes: attrs)
        alertVc.setValue(hogen,forKey: "attributedTitle")
        let attrsM  = [kCTFontAttributeName as NSAttributedString.Key:UIFont.systemFont(ofSize: 15.0) ,kCTForegroundColorAttributeName as NSAttributedString.Key:UIColor.black]
        let hogenMessage = NSMutableAttributedString.init(string: message, attributes: attrsM)
        alertVc.setValue(hogenMessage,forKey: "attributedMessage")
        return alertVc
    }
    
    static func mulitplelinebutton(strText :NSString , btn :UIButton){
        
        
        let fulltext : String = strText as String
        //getting the range to separate the button title strings
        let newlineRange: NSRange = strText.range(of: "\n")
        
        //getting both substrings
        var substring1 = ""
        var substring2 = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = strText.substring(to: newlineRange.location)
            substring2 = strText.substring(from: newlineRange.location)
        }
        
        //assigning diffrent fonts to both substrings
        let font1: UIFont = UIFont .boldSystemFont(ofSize:SMALL_BUTTON_FONT_SIZE)
        let attributes1: [NSAttributedString.Key: Any] = [
            .font: font1,
            .foregroundColor: colorSubHeading_76
        ]
        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)
        
        
        let font2: UIFont = UIFont .systemFont(ofSize:  SUB_LABEL_DESC_FONT_SIZE)
        let attributes2: [NSAttributedString.Key: Any] = [
            .font: font2,
            .foregroundColor: colorSubSubHeading_94
        ]
        
        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)
        
        attrString1.append(attrString2)

        //assigning the resultant attributed strings to the button
        btn.setAttributedTitle(attrString1, for: [])
    
    }
    static func showLoading(title : String)  {
        JQProgressHUDTool.jq_showCustomHUD( msg: title)
    }
    static func hideLoading()  {
        JQProgressHUDTool.jq_hideHUD()
    }
    static func stringFromJson(object: [[String : Any]]) -> String{
        let newjson = JSON(object)
        let sjod = newjson.rawString()
        return sjod!
//        let jsonData = try? JSONSerialization.data(withJSONObject: object, options: [])
//        let jsonString = String(data: jsonData!, encoding: .utf8)
//        return jsonString!
    }
    static func jsonObject(jsonString : String) -> [[String : Any]] {
        let jsonData = jsonString.data(using: .utf8)
        let dictionary = try? JSONSerialization.jsonObject(with: jsonData!, options:  [])
        return dictionary as! [[String : Any]]
    }
}

