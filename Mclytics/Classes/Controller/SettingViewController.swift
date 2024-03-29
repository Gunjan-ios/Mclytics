//
//  SettingViewController.swift
//  Mclytics
//
//  Created by Gunjan Raval on 13/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit

class SettingViewController: ParentClass {
    
    fileprivate var headerview:UIView!
    fileprivate var buttonBack: UIButton!
    fileprivate var buttonMenu: UIButton!
    fileprivate var yPosition: Int!
    
    fileprivate var scrlView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadHeaderView()
        // Do any additional setup after loading the view.
    }
    
 
    func loadHeaderView() {
        
        headerview = UIView(frame: CGRect(x: 0, y:( STATUS_BAR_HEIGHT + Int(ParentClass.sharedInstance.iPhone_X_Top_Padding)), width: Int(UIScreen.main.bounds.width), height: NAV_HEADER_HEIGHT));
        headerview.backgroundColor = colorPrimary
        self.view.addSubview(headerview)
        
        self.buttonBack = UIButton(frame: CGRect(x: X_PADDING, y: 0, width:NAV_HEADER_HEIGHT , height: NAV_HEADER_HEIGHT))
        self.buttonBack.setImage(UIImage (named: "back"), for: .normal)
        self.buttonBack.contentHorizontalAlignment = .center
        self.buttonBack.backgroundColor = UIColor.clear
        self.buttonBack.addTarget(self, action: #selector(goToBack), for: .touchUpInside)

        headerview.addSubview(self.buttonBack)
        
        self.buttonMenu = UIButton(frame: CGRect(x: X_PADDING*2 + Int(buttonBack.frame.width) , y: 0, width: SCREEN_WIDTH - NAV_HEADER_HEIGHT , height: NAV_HEADER_HEIGHT))
        self.buttonMenu.setTitle("General Setting", for: .normal)
        self.buttonMenu.contentHorizontalAlignment = .left
        self.buttonMenu.backgroundColor = .clear
        headerview.addSubview(self.buttonMenu)
        
        yPosition = Int(headerview.frame.maxY) + Y_PADDING
        
        self.initScroll()
    }
    @objc func goToBack()  {
        self.navigationController?.popViewController(animated: true)
    }

    func initScroll()  {
        scrlView = UIScrollView (frame: CGRect (x: 0, y: yPosition, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - yPosition))
        scrlView.backgroundColor = .clear
        self.view .addSubview(scrlView)

        var ypositionView : Int! = Y_PADDING
        
        var yInternal : Int! = 0
        var lblWidth : Int! = 0
        
        let  srView = UIView (frame: CGRect (x: X_PADDING, y: ypositionView, width: SCREEN_WIDTH - X_PADDING*2, height: 200))
        srView.layer.cornerRadius = radius
        srView.layer.borderWidth = 2
        srView.layer.borderColor = colorDividerBG_f4.cgColor
        scrlView .addSubview(srView)
        
        lblWidth  = Int(srView.bounds.width) - Y_PADDING

        let srTitle = UILabel (frame: CGRect (x: Y_PADDING, y: 0, width: lblWidth, height: LABEL_HEIGHT))
        srTitle.text = "AUTO SEND/RECEIVE"

        srTitle.font = UIFont .boldSystemFont(ofSize: BUTTON_FONT_SIZE)
        srView.addSubview(srTitle)
        
        yInternal += Int(srTitle.bounds.height)
        
        let sView =  self.addSeparateVIew(Y: yInternal, Width: Int(srView.bounds.width))
        srView.addSubview(sView)
        
        let srbtnWifi = ListSettingButton (frame: CGRect (x: Y_PADDING, y: yInternal, width: lblWidth , height: TOP_HEADER_HEIGHT))
        let strText : NSString = "Auto send with Wi-Fi\nAuto send when Wi-Fi is available"
        Utils.mulitplelinebutton(strText: strText, btn: srbtnWifi)
        srbtnWifi.setImage(UIImage (named: "deselectedCheckbox"), for: .normal)
        srbtnWifi.setImage(UIImage (named: "selectedCheckboxBlue"), for: .selected)
        srbtnWifi.tag = 1001
        srbtnWifi.addTarget(self, action: #selector(onbuttonPressed(sender:)), for: .touchUpInside)
        srView.addSubview(srbtnWifi)
    
        yInternal += Int(srbtnWifi.bounds.height)
        
        let sView1 =  self.addSeparateVIew(Y: yInternal, Width: Int(srView.bounds.width))
        srView.addSubview(sView1)
        
        
        let srbtnNet = ListSettingButton (frame: CGRect (x: Y_PADDING, y: yInternal, width: lblWidth , height: TOP_HEADER_HEIGHT))
        let strNet : NSString = "Auto send with Network\nAuto send when Network is available"
        Utils.mulitplelinebutton(strText: strNet, btn: srbtnNet)
        srbtnNet.setImage(UIImage (named: "deselectedCheckbox"), for: .normal)
        srbtnNet.setImage(UIImage (named: "selectedCheckboxBlue"), for: .selected)

        srbtnNet.tag = 1002
        srbtnNet.addTarget(self, action: #selector(onbuttonPressed(sender:)), for: .touchUpInside)

        srView.addSubview(srbtnNet)
        
        
        yInternal += Int(srbtnNet.bounds.height)
        
        let sView3 =  self.addSeparateVIew(Y: yInternal, Width: Int(srView.bounds.width))
        srView.addSubview(sView3)
        
        let srbtnStatus = ListSettingButton (frame: CGRect (x: Y_PADDING, y: yInternal, width: lblWidth , height: TOP_HEADER_HEIGHT))
        let strStatus : NSString = "Display send/receive status\nShow form send/receive status on main menu"
        Utils.mulitplelinebutton(strText: strStatus, btn: srbtnStatus)
        srbtnStatus.setImage(UIImage (named: "deselectedCheckbox"), for: .normal)
        srbtnStatus.setImage(UIImage (named: "selectedCheckboxBlue"), for: .selected)
        srbtnStatus.addTarget(self, action: #selector(onbuttonPressed(sender:)), for: .touchUpInside)
        srbtnStatus.tag = 1003
        srView.addSubview(srbtnStatus)
        
        yInternal += Int(srbtnNet.bounds.height)

        srView.frame = CGRect (x: X_PADDING, y: ypositionView, width: SCREEN_WIDTH - X_PADDING*2, height: yInternal)
        
        ypositionView += yInternal + X_PADDING

        yInternal = 0

        let  esfView = UIView (frame: CGRect (x: X_PADDING, y: ypositionView, width: SCREEN_WIDTH - X_PADDING*2, height: 100))
        esfView.layer.cornerRadius = radius
        esfView.layer.borderWidth = 2
        esfView.layer.borderColor = colorDividerBG_f4.cgColor
        scrlView .addSubview(esfView)
        
        lblWidth  = Int(srView.bounds.width) - Y_PADDING
        
        let esfTitle = UILabel (frame: CGRect (x: Y_PADDING, y: 0, width: lblWidth, height: LABEL_HEIGHT))
        esfTitle.text = "EDIT SAVED FORM"
        //        srTitle.backgroundColor = colorDividerBG_f4
        esfTitle.font = UIFont .boldSystemFont(ofSize: BUTTON_FONT_SIZE)
        esfView.addSubview(esfTitle)
        
        yInternal += Int(esfTitle.bounds.height)
        
        let eView =  self.addSeparateVIew(Y: yInternal, Width: Int(esfView.bounds.width))
        esfView.addSubview(eView)
        
        let esfbtnResume = ListSettingButton (frame: CGRect (x: Y_PADDING, y: yInternal, width: lblWidth , height: TOP_HEADER_HEIGHT))
        let strResume : NSString = "Resume\nAllow resume form where left off"
        Utils.mulitplelinebutton(strText: strResume, btn: esfbtnResume)
        esfbtnResume.setImage(UIImage (named: "deselectedCheckbox"), for: .normal)
        esfbtnResume.setImage(UIImage (named: "selectedCheckboxBlue"), for: .selected)

        esfbtnResume.addTarget(self, action: #selector(onbuttonPressed(sender:)), for: .touchUpInside)
        esfbtnResume.tag = 1004


        esfView.addSubview(esfbtnResume)
        
        yInternal += Int(esfbtnResume.bounds.height)

       esfView.frame = CGRect (x: X_PADDING, y: ypositionView, width: SCREEN_WIDTH - X_PADDING*2, height: yInternal)
        
        ypositionView += yInternal + X_PADDING
        
        yInternal = 0
        
        let  uiView = UIView (frame: CGRect (x: X_PADDING, y: ypositionView, width: SCREEN_WIDTH - X_PADDING*2, height: 100))
        uiView.layer.cornerRadius = radius
        uiView.layer.borderWidth = 2
        uiView.layer.borderColor = colorDividerBG_f4.cgColor
        scrlView .addSubview(uiView)
        
        lblWidth  = Int(srView.bounds.width) - Y_PADDING
        
        let uiTitle = UILabel (frame: CGRect (x: Y_PADDING, y: 0, width: lblWidth, height: LABEL_HEIGHT))
        uiTitle.text = "USER INTERFACE"
        //        srTitle.backgroundColor = colorDividerBG_f4
        uiTitle.font = UIFont .boldSystemFont(ofSize: BUTTON_FONT_SIZE)
        uiView.addSubview(uiTitle)
        
        yInternal += Int(esfTitle.bounds.height)
        
        let uView =  self.addSeparateVIew(Y: yInternal, Width: Int(uiView.bounds.width))
        uiView.addSubview(uView)
        
        let uibtnfiled = ListSettingButton (frame: CGRect (x: Y_PADDING, y: yInternal, width: lblWidth , height: TOP_HEADER_HEIGHT))
        let strfield : NSString = "Form Fields\nShow one by one?"
        Utils.mulitplelinebutton(strText: strfield, btn: uibtnfiled)
        uibtnfiled.setImage(UIImage (named: "deselectedCheckbox"), for: .normal)
        uibtnfiled.setImage(UIImage (named: "selectedCheckboxBlue"), for: .selected)
        uibtnfiled.addTarget(self, action: #selector(onbuttonPressed(sender:)), for: .touchUpInside)
        uibtnfiled.tag = 1005
        uiView.addSubview(uibtnfiled)
        
        yInternal += Int(esfbtnResume.bounds.height)
        
        uiView.frame = CGRect (x: X_PADDING, y: ypositionView, width: SCREEN_WIDTH - X_PADDING*2, height: yInternal)
        
        ypositionView += yInternal + X_PADDING

        scrlView.contentSize = CGSize (width: SCREEN_WIDTH, height: ypositionView)
        
        if ParentClass.sharedInstance.getDataForKey(strKey: AUTO_WIFI) as? Bool == true{
            srbtnWifi.isSelected = true
        }
        if ParentClass.sharedInstance.getDataForKey(strKey: AUTO_NETWORK)  as? Bool == true{
            srbtnNet.isSelected = true
        }
        if ParentClass.sharedInstance.getDataForKey(strKey: DISPLAY_STATUS) as? Bool == true{
            srbtnStatus.isSelected = true
        }
        if ParentClass.sharedInstance.getDataForKey(strKey: RESUME) as? Bool == true{
            esfbtnResume.isSelected = true
        }
        if ParentClass.sharedInstance.getDataForKey(strKey: USER_INTERFACE) as? Bool == true{
            uibtnfiled.isSelected = true
        }
    }
    

    
    @objc func onbuttonPressed(sender : UIButton){
        
        
        switch sender.tag {
        case 1001:
            if sender.isSelected{
                sender.isSelected = false
                ParentClass.sharedInstance.setData(strData: false, strKey: AUTO_WIFI)
            }else{
                sender.isSelected = true
                ParentClass.sharedInstance.setData(strData: true, strKey: AUTO_WIFI)
            }
            break
        case 1002:
            if sender.isSelected{
                sender.isSelected = false
                ParentClass.sharedInstance.setData(strData: false, strKey: AUTO_NETWORK)
            }else{
                sender.isSelected = true
                ParentClass.sharedInstance.setData(strData: true, strKey: AUTO_NETWORK)
            }
            break
        case 1003:
            if sender.isSelected{
                sender.isSelected = false
                ParentClass.sharedInstance.setData(strData: false, strKey: DISPLAY_STATUS)
            }else{
                sender.isSelected = true
                ParentClass.sharedInstance.setData(strData: true, strKey: DISPLAY_STATUS)
            }
            break
        case 1004:
            if sender.isSelected{
                sender.isSelected = false
                ParentClass.sharedInstance.setData(strData: false, strKey: RESUME)
            }else{
                sender.isSelected = true
                ParentClass.sharedInstance.setData(strData: true, strKey: RESUME)
            }
            break
        case 1005:
            if sender.isSelected{
                sender.isSelected = false
                ParentClass.sharedInstance.setData(strData: false, strKey: USER_INTERFACE)
            }else{
                sender.isSelected = true
                ParentClass.sharedInstance.setData(strData: true, strKey: USER_INTERFACE)
            }
            break
        default:
            break
        }
    }
    
    func addSeparateVIew(Y: Int ,Width:Int) -> UIView {
        let cView = UIView (frame: CGRect (x: 0, y: Y, width:Width, height: X_PADDING_SUBHEADER))
        cView.backgroundColor = colorDividerBG_f4
        return cView
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
