//
//  CustomTextField.swift
//  TestSpatialite
//
//  Created by Gaurav on 07/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import UIKit

class CustomTextFieldForAttribute: UITextField {
    
    var imgIcon:UIImageView!
    let padding: CGFloat = 10
    var boxBorderColor = UIColor.lightGray.cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgIcon = UIImageView(frame: CGRect(x: self.bounds.size.width - 44, y: 7, width: 24, height: 24))
        
        self.imgIcon.contentMode = .center
        self.addSubview(imgIcon)
        
//        self.layer.cornerRadius = radius
//        self.layer.borderColor = boxBorderColor
//        self.layer.borderWidth = borderWidth
        
        let rectShape = CAShapeLayer()
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [ .bottomLeft , .bottomRight], cornerRadii: CGSize(width: radius, height: radius)).cgPath
        rectShape.strokeColor = colorDividerBG_f4.cgColor
        rectShape.fillColor = UIColor.clear.cgColor
        rectShape.lineWidth = borderWidth
        rectShape.frame = self.bounds
        self.layer.mask =   rectShape
        self.layer.addSublayer(rectShape)
        
        
        
        
        self.backgroundColor = UIColor.white
        
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
class RankingTextFieldForAttribute: UITextField {
    
    var imgIcon:UIImageView!
    let padding: CGFloat = 10
    var boxBorderColor = UIColor.lightGray.cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgIcon = UIImageView(frame: CGRect(x: self.bounds.size.width - 44, y: 7, width: 24, height: 24))
        
        self.imgIcon.contentMode = .center
        self.addSubview(imgIcon)
        
                self.layer.cornerRadius = radius
                self.layer.borderColor = colorDividerBG_f4.cgColor
                self.layer.borderWidth = borderWidth
        
//        let rectShape = CAShapeLayer()
//        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [ .bottomLeft , .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
//        rectShape.strokeColor = UIColor.lightGray.cgColor
//        rectShape.fillColor = UIColor.clear.cgColor
//        rectShape.lineWidth = 1
//        rectShape.frame = self.bounds
//        self.layer.mask =   rectShape
//        self.layer.addSublayer(rectShape)
        
        self.backgroundColor = UIColor.white
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
