//
//  GenderView.swift
//  TestSpatialite
//
//  Created by Gaurav on 31/12/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import UIKit
import DLRadioButton

class MarginSelectView : UIView {
    
    private var labelTitle:UILabel! = nil
    private var btnNo:UIButton!
    private var btnYes:UIButton!
    private var btnGender:UIButton!
//    var delegateApp:InspectionFormViewController?
//    var PreviewdelegateApp:PreviewViewController?
//    var verificationDelegateApp:VerificationDetailViewController?
    var isMarginMoneyCallback = false

    let labelHeight = 25
    let radioBtnHeight = 45
    
    func initDesign(pName:String,pTag:Int,pOptions:[String]) {
     
        labelTitle = UILabel(frame: CGRect(x: 0, y: 0, width: Int(frame.size.width), height: labelHeight))
        labelTitle.textColor = labelTextColor
        labelTitle.font = UIFont(name: APP_FONT_NAME, size: 17)
        labelTitle.text = pName
        labelTitle.textAlignment = .left
        self.addSubview(labelTitle)
        
        var otherButtons : [DLRadioButton] = [];
        let radioBtnWidth = pTag >= VerificationTAG22 ? 120 : 80
        
        let firstRadioButton = self.createRadioButton(frame: CGRect(x: 0, y:25, width: radioBtnWidth, height: radioBtnHeight), title: pOptions[0], color: UIColor.black, view: self);
        firstRadioButton.tag = pTag
//        firstRadioButton.isSelected = true
        
        self.isMarginMoneyCallback = false
        
        var index = 0
        var x_Spacing = 0
        
        for name in pOptions {
            if index == 0 {
                index+=1
                continue
            }
            
            x_Spacing += (radioBtnWidth + 10)
            
            let frame = CGRect(x: x_Spacing, y: 25, width: radioBtnWidth, height: radioBtnHeight);
            let radioButton = createRadioButton(frame: frame, title: name, color: UIColor.black,view: self);
            otherButtons.append(radioButton);
        }
        
        firstRadioButton.otherButtons = otherButtons;

    }
    
    private func createRadioButton(frame : CGRect, title : String, color : UIColor, view:UIView) -> DLRadioButton {
        
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 14);
        radioButton.setTitle(title, for: []);
        radioButton.setTitleColor(color, for: []);
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.icon = UIImage(named: "deselectedCheckbox")!
        radioButton.iconSelected = UIImage(named: "selectedCheckboxBlue")!
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(self.logSelectedButton(radioButton:)), for: UIControl.Event.touchUpInside);
        radioButton.isMultipleSelectionEnabled = true
        view.addSubview(radioButton);
        
        return radioButton;
    }
    
    //MARK:- Others
    @objc private func logSelectedButton(radioButton : DLRadioButton) {
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        }
        else {
            
//            if let delegate = verificationDelegateApp {
//                 print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
//                self.verificationDelegateApp?.verficationSelectedButton(radioButton: radioButton)
////                delegate
//            }
//            else{
//                delegateApp?.getMarginStatus(status: radioButton.selected()!.titleLabel!.text!)
//                            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
//
//            }
        }
    }
}

