//
//  RoundedView.swift
//  ParklandFuelpricecollector
//
//  Created by Gunjan on 10/10/18.
//  Copyright © 2018 Parkland. All rights reserved.
//

import UIKit

class RoundedView: UIView {

    override func awakeFromNib() {
        layer.cornerRadius = frame.size.height/2
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
    
}
class ThemeColorButton: UIButton {
    
    override func awakeFromNib() {
//        layer.cornerRadius = frame.size.height/2
//        layer.borderColor = UIColor.black.cgColor
//        layer.borderWidth = 1
        setTitleColor(THEME_COLOR, for: .normal)
    }
    
}

