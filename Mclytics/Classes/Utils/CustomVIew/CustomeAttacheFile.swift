//
//  CustomeAttacheFile.swift
//  Mclytics
//
//  Created by Krishna  on 23/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit

//class CustomeAttacheFile: UIButton {
//
//    private var shadowLayer: CAShapeLayer!
//
//    override init(frame: CGRect) {
//            super.init(frame: frame)
//
//        backgroundColor = .white
////        self.contentHorizontalAlignment = .center
//            setTitleColor(UIColor.black, for: .normal)
//
//            // corner
//            layer.cornerRadius = 5
//            self.layer.borderWidth = 1
//            self.layer.borderColor = buttonBorderColor.cgColor
//
//            // title color
//
//            // font
//            titleLabel?.font = UIFont(name:APP_FONT_NAME_BOLD, size: BUTTON_FONT_SIZE)
//
//    //         shadow
//            if shadowLayer == nil {
//                shadowLayer = CAShapeLayer()
//                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
//                shadowLayer.fillColor = UIColor.white.cgColor
//
//                shadowLayer.shadowColor = UIColor.darkGray.cgColor
//                shadowLayer.shadowPath = shadowLayer.path
//                shadowLayer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//                shadowLayer.shadowOpacity = 0.8
//                shadowLayer.shadowRadius = 2
//            }
//
//
//        //
//        let imageSize = self.imageView!.frame.size
//        let titleSize = self.titleLabel!.frame.size
//        let totalHeight = imageSize.height + titleSize.height + 6
//
//        self.imageEdgeInsets = UIEdgeInsets(
//            top: 6,
//            left: 8,
//            bottom: 8,
//            right: -8
//        )
//
//        self.titleEdgeInsets = UIEdgeInsets(
//            top: self.frame.size.height - 20,
//            left: 0,
//            bottom: 4,
//            right: 0
//        )
//
//
//        }
//
//        required init?(coder aDecoder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//
//
//}

class CustomeAttacheFile: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        // corner
        layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = buttonBorderColor.cgColor
        
        setTitleColor(UIColor.black, for: .normal)
//        self.titleLabel?.font = UIFont(16)
//        self.titleLabel?.font = UIFont(name:APP_FONT_NAME_BOLD, size: BUTTON_FONT_SIZE)

        let kTextTopPadding:CGFloat = 3.0;

        var titleLabelFrame = self.titleLabel!.frame;


        let labelSize = titleLabel!.sizeThatFits(CGSize(width: self.contentRect(forBounds: self.bounds).width, height: CGFloat.greatestFiniteMagnitude))

        var imageFrame = self.imageView!.frame;

        let fitBoxSize = CGSize(width: max(imageFrame.size.width, labelSize.width), height: labelSize.height + kTextTopPadding + imageFrame.size.height)

        let fitBoxRect = self.bounds.insetBy(dx: (self.bounds.size.width - fitBoxSize.width)/2, dy: (self.bounds.size.height - fitBoxSize.height)/2);

        imageFrame.origin.y = fitBoxRect.origin.y;
        imageFrame.origin.x = fitBoxRect.midX - (imageFrame.size.width/2);
        self.imageView!.frame = imageFrame;

        // Adjust the label size to fit the text, and move it below the image

        titleLabelFrame.size.width = labelSize.width;
        titleLabelFrame.size.height = labelSize.height;
        titleLabelFrame.origin.x = (self.frame.size.width / 2) - (labelSize.width / 2);
        titleLabelFrame.origin.y = self.frame.size.height - 26//fitBoxRect.origin.y + imageFrame.size.height + kTextTopPadding;
        self.titleLabel!.frame = titleLabelFrame;
        self.titleLabel!.textAlignment = .center
    }

}


