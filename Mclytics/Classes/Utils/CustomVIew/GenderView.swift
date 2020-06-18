//
//  GenderView.swift
//  TestSpatialite
//
//  Created by Gaurav on 31/12/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation
import UIKit
import DLRadioButton

class GenderView : UIView {

    private var labelTitle:UILabel! = nil
    private var btnMale:UIButton!
    private var btnFeMale:UIButton!
    private var btnGender:UIButton!
    
    var newHeigt : CGFloat = 70
    let labelHeight = 25
    let radioBtnHeight = 35
    var delegateApp:FormFieldsVC?
    var idString = ""
    var btnTag = 0

    func initDesign(pName:String,pTag:Int,pOptions:[OptionsModal], str_id :String) {
        idString = str_id
        btnTag = pTag
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
      
        if pOptions.count <= 0{
            return;
        }
         let firstRadioButton = self.createRadioButton(frame: CGRect(x: 8, y: labelHeight + 1 , width: SCREEN_WIDTH, height: radioBtnHeight), title: pOptions[0].label, color: UIColor.black, isSelected: pOptions[0].selected, index: pOptions[0].index , view: self);
        
        print(firstRadioButton.frame)
        print(pOptions[0].selected)
        print(pOptions[0].index)
        firstRadioButton.tag = pTag
        
//        if pOptions[0].checked == true {
//            if let delegate = delegateApp {
//                if pTag == 1023{
//
//                }else{
//                    delegate.radioSelected(pOptions[0].label, str_id: idString)
//                }
//            }
//        }

        
        var index = 0
        var x_Spacing = labelHeight
        
        for name in pOptions {
            if index == 0 {
                index+=1
                continue
            }
            name.index = index
            x_Spacing += radioBtnHeight
            
            let frame = CGRect(x: 8, y: x_Spacing, width: SCREEN_WIDTH, height: radioBtnHeight);
            print(frame)
            print(index)

            let radioButton = createRadioButton(frame: frame, title: name.label, color: UIColor.black, isSelected: name.selected, index: name.index ,view: self);
            otherButtons.append(radioButton);
            index+=1

        }
        
        firstRadioButton.otherButtons = otherButtons;
        print( firstRadioButton.otherButtons.count + 1)
        let size = radioBtnHeight*(firstRadioButton.otherButtons.count+1)
        newHeigt = CGFloat(labelHeight + size)
        
    }
    func resetHeight()  -> CGRect {
        return  CGRect (x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: newHeigt)
    }
    private func createRadioButton(frame : CGRect, title : String, color : UIColor, isSelected  : Bool,index : Int,  view:UIView) -> DLRadioButton {

        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 14);
        radioButton.setTitle(title, for: []);
        radioButton.setTitleColor(color, for: []);
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.icon = UIImage(named: "radioBtnOff")!
        radioButton.iconSelected = UIImage(named: "radioBtnOn")!
        radioButton.tag = btnTag
        if isSelected {
            radioButton.isSelected = true
        } else {
            radioButton.isSelected = false
        }
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(self.logSelectedButton(radioButton:)), for: UIControl.Event.touchUpInside);
        view.addSubview(radioButton);

        return radioButton;
    }

    //MARK:- Others
    @objc private func logSelectedButton(radioButton : DLRadioButton) {

        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
            print(radioButton.tag)
            if let delegate = delegateApp {
                  delegate.radioSelected(radioButton.selected()!.titleLabel!.text!, str_id: idString, pTag: radioButton.tag)
//                delegate.checkboxSelected([radioButton.selected()!.titleLabel!.text!], str_id: idString)
            }
        }
    }
}


