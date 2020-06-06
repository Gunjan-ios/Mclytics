//
//  SimpleLabel.swift
//  Mclytics
//
//  Created by Krishna  on 21/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit


 class SimpleLabel: UILabel {
    
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
            self.commonInit()
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.commonInit()
        }
    
        func commonInit(){
            self.layer.cornerRadius = self.bounds.width/2
            self.clipsToBounds = true
            self.textColor = UIColor.white
            self.setProperties(borderWidth: 1.0, borderColor:UIColor.black)
        }
        func setProperties(borderWidth: Float, borderColor: UIColor) {
            self.layer.borderWidth = CGFloat(borderWidth)
            self.layer.borderColor = borderColor.cgColor
        }
}
