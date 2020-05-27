//
//  CustomComboBoxView.swift
//  TestSpatialite
//
//  Created by Gaurav on 30/12/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation
import UIKit

class CustomInputTextView: UIView, UITextViewDelegate {
    
    private var labelTitle:UILabel! = nil
    var txtField:CustomTextView!
    var delegateAppForm:FormFieldsVC?
    var delegateApp:LoginViewController?
//    var previewDelegateApp:PreviewViewController?
//    var verificationDelegateApp:VerificationDetailViewController?

    let labelHeight = 25
    
    func initDesign(pName:String,pTag:Int,pPlaceHolder:String) {
        
        labelTitle = UILabel(frame: CGRect(x: 0, y: 0, width: Int(frame.size.width), height: labelHeight))
        labelTitle.textColor = labelTextColor
        labelTitle.font = UIFont(name: APP_FONT_NAME, size: LABEL_FONT_SIZE)
        labelTitle.text = pName
        labelTitle.textAlignment = .left
        self.addSubview(labelTitle)
        
        self.txtField = CustomTextView(frame: CGRect(x: 0, y: 25, width: Int(frame.size.width), height: 100))
        self.txtField.delegate = self 
        self.txtField.tag = pTag
        self.txtField.returnKeyType = .done
//        self.txtField. placeholder = pPlaceHolder
        self.addSubview(self.txtField)
        
    }
    
    //MARK: UITextViewDelegate 
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
      
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if let delegate = self.delegateApp {
//            delegate.textViewDidBeginEditing_VC(textView)
        }
    }
}
