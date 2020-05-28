//
//  CustomTextField.swift
//  TestSpatialite
//
//  Created by Gaurav on 07/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField : UITextField {
    
    let padding: CGFloat = 10
    var boxBorderColor = UIColor.lightGray.cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let rectShape = CAShapeLayer()
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [ .bottomRight , .bottomLeft], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        rectShape.strokeColor = UIColor.lightGray.cgColor
        rectShape.fillColor = UIColor.clear.cgColor
        rectShape.lineWidth = 1
        rectShape.frame = self.bounds
        self.layer.mask =   rectShape
        self.layer.addSublayer(rectShape)
        
        self.backgroundColor = UIColor.clear
        self.font = UIFont(name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
        self.textColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
