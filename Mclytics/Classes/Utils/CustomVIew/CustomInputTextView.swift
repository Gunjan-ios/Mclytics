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
    var idString = ""
//    var previewDelegateApp:PreviewViewController?
//    var verificationDelegateApp:VerificationDetailViewController?

    let labelHeight = 25
    
    func initDesign(pName:String,pTag:Int,pPlaceHolder:String,str_id :String) {
        idString = str_id
        labelTitle = PaddingLabel(frame: CGRect(x: 0, y: 0, width: Int(frame.size.width), height: labelHeight))
        labelTitle.textColor = colorSubHeading_76
        labelTitle.font = UIFont(name: APP_FONT_NAME, size: LABEL_FONT_SIZE)
        labelTitle.text = pName
        labelTitle.textAlignment = .left
        let rectShape = CAShapeLayer()
        rectShape.path = UIBezierPath(roundedRect: labelTitle.bounds, byRoundingCorners: [ .topRight , .topLeft], cornerRadii: CGSize(width:  radius, height:  radius)).cgPath
        rectShape.strokeColor = colorDividerBG_f4.cgColor
        rectShape.fillColor = UIColor.clear.cgColor
        rectShape.lineWidth = borderWidth
        rectShape.frame = labelTitle.bounds
        labelTitle.layer.mask =   rectShape
        labelTitle.layer.addSublayer(rectShape)
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
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let delegate = self.delegateAppForm {
            delegate.textViewDidBeginEditing_VC(textView, str_id: idString)
        }
    }
}
