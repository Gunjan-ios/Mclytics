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
    var delegateApp:FormFieldsVC?

    var isMarginMoneyCallback = false
    var newHeigt : CGFloat = 70
    let labelHeight = 25
    let radioBtnHeight = 35
    var idString = ""
    
    func initDesign(pName:String,pTag:Int,pOptions:[OptionsModal], str_id :String) {
        idString = str_id
        labelTitle = PaddingLabel(frame: CGRect(x: 0, y: 0, width: Int(frame.size.width), height: labelHeight))
        labelTitle.textColor = colorSubHeading_76
        labelTitle.font = UIFont(name: APP_FONT_NAME, size: 17)
        labelTitle.text = pName
        labelTitle.textAlignment = .left
        self.addSubview(labelTitle)
        
        let labelVIew = UIView(frame: CGRect(x: 0, y: labelHeight , width: Int(frame.size.width), height: 1))
        labelVIew.backgroundColor = colorDividerBG_f4
        self.addSubview(labelVIew)
        
        var otherButtons : [DLRadioButton] = [];
        
        let firstRadioButton = self.createRadioButton(frame: CGRect(x: 8, y: labelHeight + 1 , width: SCREEN_WIDTH, height: radioBtnHeight), title: pOptions[0].label, color: UIColor.black, isSelected: pOptions[0].selected, view: self);
        print(firstRadioButton.frame)
        firstRadioButton.tag = pTag
//        firstRadioButton.isSelected = true
        
        self.isMarginMoneyCallback = false
        
        var index = 0
        var x_Spacing = labelHeight
        
        for name in pOptions {
            if index == 0 {
                index+=1
                continue
            }
            
            x_Spacing += radioBtnHeight
            
            let frame = CGRect(x: 8, y: x_Spacing, width: SCREEN_WIDTH, height: radioBtnHeight);
            print(frame)
            let radioButton = createRadioButton(frame: frame, title: name.label, color: UIColor.black, isSelected: name.selected,view: self);
            otherButtons.append(radioButton);
        }
        
        firstRadioButton.otherButtons = otherButtons;
        print( firstRadioButton.otherButtons.count + 1)
        let size = radioBtnHeight*(firstRadioButton.otherButtons.count+1)
        newHeigt = CGFloat(labelHeight + size)
    }
    
    func resetHeight()  -> CGRect {
        return  CGRect (x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: newHeigt)
    }
    
    private func createRadioButton(frame : CGRect, title : String, color : UIColor, isSelected  : Bool, view:UIView) -> DLRadioButton {
        
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 14);
        radioButton.setTitle(title, for: []);
        radioButton.setTitleColor(color, for: []);
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.icon = UIImage(named: "deselectedCheckbox")!
        radioButton.iconSelected = UIImage(named: "selectedCheckboxBlue")!
        if isSelected {
            radioButton.isSelected = true
        } else {
            radioButton.isSelected = false
        }
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(self.logSelectedButton(radioButton:)), for: UIControl.Event.touchUpInside);
        radioButton.isMultipleSelectionEnabled = true
        view.addSubview(radioButton);
        
        return radioButton;
    }
    
    //MARK:- Others
    @objc private func logSelectedButton(radioButton : DLRadioButton) {
        
        if (radioButton.isMultipleSelectionEnabled) {
            var count = radioButton.selectedButtons().count
            var selectedTitles = [String]()
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
                selectedTitles.append(button.titleLabel!.text!)
                count -= 1
                if count == 0 {
                    if let delegate = delegateApp {
                        delegate.checkboxSelected(selectedTitles, str_id: idString)
                    }
                }
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

