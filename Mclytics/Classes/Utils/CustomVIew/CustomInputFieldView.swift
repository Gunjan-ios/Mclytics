//
//  CustomComboBoxView.swift
//  TestSpatialite
//
//  Created by Gaurav on 30/12/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import UIKit

class CustomInputFieldView: UIView, UITextFieldDelegate {
    
    private var labelTitle:UILabel! = nil
    var txtField:CustomTextField!
    var delegateAppForm:FormFieldsVC?
    var delegateApp:LoginViewController?
//    var verificationDelegateApp:VerificationDetailViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let labelHeight = 25
    
    func initDesign(pName:String,pTag:Int,pPlaceHolder:String) {
        
        labelTitle = PaddingLabel(frame: CGRect(x: 0, y: 0, width: Int(frame.size.width), height: labelHeight))
        labelTitle.textColor = labelTextColor
        labelTitle.font = UIFont(name: APP_FONT_NAME, size: LABEL_FONT_SIZE)
        labelTitle.text = pName
        labelTitle.drawText(in: labelTitle.frame)
        let rectShape = CAShapeLayer()
        rectShape.path = UIBezierPath(roundedRect: labelTitle.bounds, byRoundingCorners: [ .topRight , .topLeft], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        rectShape.strokeColor = UIColor.lightGray.cgColor
        rectShape.fillColor = UIColor.clear.cgColor
        rectShape.lineWidth = 1
        rectShape.frame = labelTitle.bounds
        labelTitle.layer.mask =   rectShape
        labelTitle.layer.addSublayer(rectShape)

//        labelTitle.layer.borderColor = UIColor.lightGray.cgColor
//        labelTitle.layer.borderWidth = 1
        
        
        
        
        labelTitle.textAlignment = .left
        labelTitle.backgroundColor = .clear
        self.addSubview(labelTitle)
        
        self.txtField = CustomTextField(frame: CGRect(x: 0, y: 25, width: Int(frame.size.width), height: 45))
        self.txtField.delegate = self
        self.txtField.tag = pTag
        self.txtField.returnKeyType = .done
        self.txtField.placeholder = pPlaceHolder
        self.addSubview(self.txtField)
        
    }

    
    //MARK: textfield delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let delegate = self.delegateApp {
//            delegate.getTextfield(textField)
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == TAG13 || textField.tag == TAG14 || textField.tag == TAG15 || textField.tag == TAG16 || textField.tag == TAG17{
        let maxLength = 2
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
        }
//        else if textField.tag == TAG20{
//            let maxLength = Int(SingletonViewControllerClassSwift.shared.mm_rel_amt!)!
//            let currentString: NSString = textField.text! as NSString
//            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
//            let currInt = Int(newString as String)!
//            if maxLength >= currInt{
//                return true
//            }else{
//                return false
//            }
//        }
        return true
        
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        if let delegate = self.delegateApp {
//            delegate.getTextfield(textField)
////            delegate.textFieldDidEndEditing?(textField)
//        }
//
//    }
}
