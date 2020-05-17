//
//  CustomButton.swift
//  TestSpatialite
//
//  Created by Gaurav on 09/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import UIKit

class CustomButton : UIButton {
    
    private var shadowLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = colorPrimary
        self.contentHorizontalAlignment = .center
        setTitleColor(UIColor.white, for: .normal)
        
        // corner
        layer.cornerRadius = 5
//        self.layer.borderWidth = 1
//        self.layer.borderColor = buttonBorderColor.cgColor
        
        // title color
        
        // font
        titleLabel?.font = UIFont(name:APP_FONT_NAME_BOLD, size: BUTTON_FONT_SIZE)
        
//         shadow
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor

            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2
        }


       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
