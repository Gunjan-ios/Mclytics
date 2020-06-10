//
//  CustomTextField.swift
//  TestSpatialite
//
//  Created by Gaurav on 07/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation
import UIKit

class CustomTextView : UITextView {
    
    let padding: CGFloat = 10
    var boxBorderColor = UIColor.lightGray.cgColor
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
//        self.layer.cornerRadius = 5;
//        self.layer.borderColor = boxBorderColor
//        self.layer.borderWidth = 1
//        self.backgroundColor = UIColor.white
//
        let rectShape = CAShapeLayer()
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [ .bottomLeft , .bottomRight], cornerRadii: CGSize(width: radius, height: radius)).cgPath
        rectShape.strokeColor = colorDividerBG_f4.cgColor
        rectShape.fillColor = UIColor.clear.cgColor
        rectShape.lineWidth = borderWidth
        rectShape.frame = self.bounds
        self.layer.mask =   rectShape
        self.layer.addSublayer(rectShape)

        self.font = UIFont(name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
        self.textColor = .darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        self.layer.cornerRadius = 5;
//        self.layer.borderColor = boxBorderColor
//        self.layer.borderWidth = 1
//        self.backgroundColor = UIColor.white
//    
//        self.font = UIFont(name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
//        self.textColor = UIColor.black
//        
//    }
    
    
}

class InsideTextView : UITextView {
    
    let padding: CGFloat = 10
    var boxBorderColor = UIColor.lightGray.cgColor
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.layer.cornerRadius = radius
        self.layer.borderColor = colorDividerBG_f4.cgColor
        self.layer.borderWidth = borderWidth
        self.backgroundColor = UIColor.white
        self.font = UIFont(name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
        self.textColor = colorSubSubHeading_94
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
