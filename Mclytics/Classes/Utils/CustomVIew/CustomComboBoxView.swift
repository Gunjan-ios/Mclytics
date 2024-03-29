//
//  CustomComboBoxView.swift
//  TestSpatialite
//
//  Created by Gaurav on 30/12/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import UIKit

class CustomComboBoxView: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    private var labelTitle:UILabel! = nil
    private let pickerView = DropDownPickerView()
    var txtField:CustomTextFieldForAttribute!
    private var datePickerView:UIDatePicker? = nil
    var delegateAppForm : FormFieldsVC?
    var delegateApp:LoginViewController?
    var idString = ""
//    var PreviewdelegateApp:PreviewViewController?


    let labelHeight = 25
    let txtFieldHeight = 45

    func initDesign(pName:String,pTag:Int,pOptions:[String],pPlaceHolder:String,str_id :String) {
        idString = str_id
        labelTitle = PaddingLabel(frame: CGRect(x: 0, y: 0, width: Int(frame.size.width), height: labelHeight))
        labelTitle.textColor = colorSubHeading_76
        labelTitle.font = UIFont(name: APP_FONT_NAME, size: LABEL_FONT_SIZE)
        labelTitle.text = pName
        labelTitle.textAlignment = .left
        let rectShape = CAShapeLayer()
        rectShape.path = UIBezierPath(roundedRect: labelTitle.bounds, byRoundingCorners: [ .topRight , .topLeft], cornerRadii: CGSize(width: radius, height: radius)).cgPath
        rectShape.strokeColor = colorDividerBG_f4.cgColor
        rectShape.fillColor = UIColor.clear.cgColor
        rectShape.lineWidth = borderWidth
        rectShape.frame = labelTitle.bounds
        labelTitle.layer.mask =   rectShape
        labelTitle.layer.addSublayer(rectShape)

        self.addSubview(labelTitle)

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePressedForForDropDownTypePickerView(sender:)))
        doneButton.tag = 5000 + pTag
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true


        pickerView.tag = 5000 + pTag

        let dropDownOptions = pOptions
        print(pOptions)
        pickerView.pickerOptions = dropDownOptions
        pickerView.delegate = self as UIPickerViewDelegate
        self.txtField = CustomTextFieldForAttribute(frame: CGRect(x: 0, y: 25, width: Int(frame.size.width), height: txtFieldHeight))
        self.txtField.delegate = self
        self.txtField.tag = pTag
        self.txtField.returnKeyType = .done
        self.txtField.placeholder = pPlaceHolder
        self.txtField.inputView = pickerView
        self.txtField.inputAccessoryView = toolBar
        self.txtField.imgIcon.frame = CGRect(x: Int(frame.size.width) - 44, y: 0, width: txtFieldHeight, height: txtFieldHeight)
        self.txtField.imgIcon.image = UIImage(named: DATATYPE_DROPDOWN_ICON)
        self.addSubview(self.txtField)

        pickerView.currentTextField = txtField
    }

    //MARK:- Date Picker
    func setDatePicker() {

        self.pickerView.isHidden = true

        // for date picker
        self.datePickerView = UIDatePicker()
        self.datePickerView!.datePickerMode = UIDatePicker.Mode.date
        self.datePickerView!.maximumDate = Date()
        self.datePickerView!.addTarget(self, action: #selector(datePickerForDateValueChanged(sender:)), for: .valueChanged)
        self.txtField.inputView = self.datePickerView

        // for done button
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePressedForDateTypePickerView(sender:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.txtField.inputAccessoryView = toolBar

    }

    @objc private func datePickerForDateValueChanged(sender:UIDatePicker) {

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.txtField.text = dateFormatter.string(from: sender.date)
    }

    @objc func donePressedForDateTypePickerView(sender:UIBarButtonItem) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dtPicker = self.txtField.inputView as! UIDatePicker
        self.txtField.text = dateFormatter.string(from: dtPicker.date)
        self.txtField.resignFirstResponder()
    }



    //MARK:- Dropdown delegate
    @objc func donePressedForForDropDownTypePickerView(sender:UIBarButtonItem) {

            self.txtField.text = self.pickerView.pickerOptions[self.pickerView.selectedRow(inComponent: 0)]
            self.txtField.resignFirstResponder()
    }

    // MARK: UIPickerView Delegation
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let pickerView = pickerView as! DropDownPickerView
        return pickerView.pickerOptions.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let pickerView = pickerView as! DropDownPickerView
        return pickerView.pickerOptions[row]
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //  self.selectedIndexForPickerView = row
        let pickerView = pickerView as! DropDownPickerView
        pickerView.currentTextField.text = pickerView.pickerOptions[row]
    }

    //MARK: textfield delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if let delegate = self.delegateAppForm {
//            delegate.textFieldDidBeginEditing_VC(textField)
//        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let delegate = self.delegateAppForm {
            delegate.getTextfield(textField: textField, str_id: idString, selectedOption: 1000)
        }
    }

}
class RankingView: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    private var labelTitle:UILabel! = nil
    private let pickerView = DropDownPickerView()
    var txtField:RankingTextFieldForAttribute!
    private var datePickerView:UIDatePicker? = nil
    var delegateAppForm:FormFieldsVC?
    var delegateApp:LoginViewController?
    var idString = ""
    var selectedOption = 0
    //    var PreviewdelegateApp:PreviewViewController?
    
    
    let labelHeight = 25
    let txtFieldHeight = 35
    
    func initDesign(pName:String,pTag:Int,pOptions:[String],pPlaceHolder:String,str_id :String, textFieldIndex : Int) {
        idString = str_id
        selectedOption = textFieldIndex
        let label = PaddingLabel (frame: CGRect(x: 70 , y: 0, width: Int(frame.size.width) - 70 , height: txtFieldHeight))
        label.text = pName
        label.textColor = .gray
        self.addSubview(label)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePressedForForDropDownTypePickerView(sender:)))
        doneButton.tag = 5000 + pTag
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        pickerView.tag = 5000 + pTag
        
        let dropDownOptions = pOptions
        print(pOptions)
        pickerView.pickerOptions = dropDownOptions
        pickerView.delegate = self as UIPickerViewDelegate
        self.txtField = RankingTextFieldForAttribute(frame: CGRect(x: 0, y: 0, width: 70, height: txtFieldHeight))
        self.txtField.delegate = self

        self.txtField.tag = pTag
        self.txtField.returnKeyType = .done
        self.txtField.placeholder = pPlaceHolder
        self.txtField.inputView = pickerView
        self.txtField.inputAccessoryView = toolBar
        self.txtField.imgIcon.frame = CGRect(x: 70 - txtFieldHeight, y: 0, width: txtFieldHeight, height: txtFieldHeight)
        self.txtField.imgIcon.image = UIImage(named: DATATYPE_DROPDOWN_ICON)
        self.addSubview(self.txtField)
        
        pickerView.currentTextField = txtField
    }
    
    //MARK:- Date Picker
    func setDatePicker() {
        
        self.pickerView.isHidden = true
        
        // for date picker
        self.datePickerView = UIDatePicker()
        self.datePickerView!.datePickerMode = UIDatePicker.Mode.date
        self.datePickerView!.maximumDate = Date()
        self.datePickerView!.addTarget(self, action: #selector(datePickerForDateValueChanged(sender:)), for: .valueChanged)
        self.txtField.inputView = self.datePickerView
        
        // for done button
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePressedForDateTypePickerView(sender:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.txtField.inputAccessoryView = toolBar
        
    }
    
    @objc private func datePickerForDateValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.txtField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func donePressedForDateTypePickerView(sender:UIBarButtonItem) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dtPicker = self.txtField.inputView as! UIDatePicker
        self.txtField.text = dateFormatter.string(from: dtPicker.date)
        self.txtField.resignFirstResponder()
    }
    
    
    
    //MARK:- Dropdown delegate
    @objc func donePressedForForDropDownTypePickerView(sender:UIBarButtonItem) {
        
        self.txtField.text = self.pickerView.pickerOptions[self.pickerView.selectedRow(inComponent: 0)]
        self.txtField.resignFirstResponder()
    }
    
    // MARK: UIPickerView Delegation
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let pickerView = pickerView as! DropDownPickerView
        return pickerView.pickerOptions.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let pickerView = pickerView as! DropDownPickerView
        return pickerView.pickerOptions[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //  self.selectedIndexForPickerView = row
        let pickerView = pickerView as! DropDownPickerView
        pickerView.currentTextField.text = pickerView.pickerOptions[row]
    }
    
    //MARK: textfield delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        //        if let delegate = self.delegateAppForm {
        //            delegate.textFieldDidBeginEditing_VC(textField)
        //        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let delegate = self.delegateAppForm {
            delegate.getTextfield(textField: textField, str_id: idString, selectedOption: selectedOption)
        }
    }
    
}
