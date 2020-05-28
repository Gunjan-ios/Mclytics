//
//  CustomLabel.swift
//  Mclytics
//
//  Created by Gunjan Raval on 27/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textAlignment = .left
        // title color
        self.textColor = grayTextColor
        // font
        self.font = UIFont (name: APP_FONT_NAME, size: SUB_HEADER_LABEL_FONT_SIZE)
        self.layer.cornerRadius = 5.0
        self.layer.borderColor =  UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
//        self.textContainerInset = UIEdgeInsetsMake(10, 0, 10, 0);

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
