//
//  CustomeAttacheFile.swift
//  Mclytics
//
//  Created by Krishna  on 23/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit
import CoreFoundation

class CustomeAttacheFile: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        // corner
        layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = buttonBorderColor.cgColor
        
        setTitleColor(UIColor.darkGray, for: .normal)

        let kTextTopPadding:CGFloat = 3.0;

        var titleLabelFrame = self.titleLabel!.frame;


        let labelSize = titleLabel!.sizeThatFits(CGSize(width: self.contentRect(forBounds: self.bounds).width, height: CGFloat.greatestFiniteMagnitude))

        var imageFrame = self.imageView!.frame;

        let fitBoxSize = CGSize(width: max(imageFrame.size.width, labelSize.width), height: labelSize.height + kTextTopPadding + imageFrame.size.height)
//
        let fitBoxRect = self.bounds.insetBy(dx: (self.bounds.size.width - fitBoxSize.width)/2, dy: (self.bounds.size.height - fitBoxSize.height)/2);

        imageFrame.origin.y = fitBoxRect.origin.y;
//        imageFrame.origin.x = fitBoxRect.midX - (imageFrame.size.width/2);
//        self.imageView!.frame = imageFrame;
        self.imageView?.frame = CGRect (x: 0, y: Int(imageFrame.origin.y), width: Int(self.frame.height/2), height:  Int(self.frame.height/2))

        self.imageView?.center = CGPoint (x: self.frame.width/2, y: (self.imageView?.center.y)!)
        
        // Adjust the label size to fit the text, and move it below the image

        titleLabelFrame.size.width = labelSize.width;
        titleLabelFrame.size.height = labelSize.height;
        titleLabelFrame.origin.x = (self.frame.size.width / 2) - (labelSize.width / 2);
        titleLabelFrame.origin.y = self.frame.size.height - 26//fitBoxRect.origin.y + imageFrame.size.height + kTextTopPadding;
        self.titleLabel!.frame = titleLabelFrame;
        self.titleLabel!.textAlignment = .center
        self.titleLabel!.font = UIFont .boldSystemFont(ofSize: 15)

    }

}


