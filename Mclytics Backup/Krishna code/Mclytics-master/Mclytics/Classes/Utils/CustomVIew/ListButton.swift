//
//  CustomButton.swift
//  TestSpatialite
//
//  Created by Gaurav on 09/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import UIKit

class ListButton : UIButton {
        override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentHorizontalAlignment = .left
//        self.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 60.0, bottom: 0.0, right: 0.0)
//        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 60.0, bottom: 0.0, right: 0.0)
        self.imageEdgeInsets = UIEdgeInsets.zero
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        setTitleColor(.black, for: .normal)
//        titleLabel?.font = UIFont(name:APP_FONT_NAME_BOLD, size: NAV_HEADER_FONT_SIZE)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: NAV_HEADER_FONT_SIZE)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

class ListSettingButton : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentHorizontalAlignment = .left
        self.setTitleColor(.lightGray, for: .normal)
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.semanticContentAttribute = UIApplication.shared
        .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.bounds.width  - CGFloat( NAV_HEADER_HEIGHT-Y_PADDING), bottom: 0, right: CGFloat(Y_PADDING))
        self.titleEdgeInsets = UIEdgeInsets.zero
        setTitleColor(.black, for: .normal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
