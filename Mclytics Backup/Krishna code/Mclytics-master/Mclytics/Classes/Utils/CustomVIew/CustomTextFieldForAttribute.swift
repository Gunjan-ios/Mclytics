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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imgIcon.contentMode = .center
        self.addSubview(imgIcon)
        
        self.layer.cornerRadius = 5;
        self.layer.borderColor = boxBorderColor
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.white
        
        self.font = UIFont(name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
        self.textColor = UIColor.black

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
