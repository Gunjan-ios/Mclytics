//
//  CustomTextField.swift
//  TestSpatialite
//
//  Created by Gaurav on 07/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation
import UIKit

class InputTextField : UITextField {
    
    let padding: CGFloat = 10
    var boxBorderColor = UIColor.lightGray.cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        super.layoutSubviews()
        let border = CALayer()
        let lineWidth = CGFloat(0.3)
        border.borderColor = textFieldTextColor.cgColor
        border.frame = CGRect(x: 0, y: frame.size.height - lineWidth, width:  frame.size.width, height: frame.size.height)
        border.borderWidth = lineWidth
        layer.addSublayer(border)
        layer.masksToBounds = true
        
        font = UIFont(name: APP_FONT_NAME, size: TEXTFIELD_FONT_SIZE)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    //  Padding x
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        // let newCGRect = bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
    }
    
}
