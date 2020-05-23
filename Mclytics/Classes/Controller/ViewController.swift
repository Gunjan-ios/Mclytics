//
//  ViewController.swift
//  Mclytics
//
//  Created by Gunjan Raval on 11/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: ParentClass {
    
    fileprivate var headerview:UIView!
    fileprivate var buttonBack: UIButton!
    fileprivate var buttonMenu: UIButton!
    fileprivate var yPosition: Int!
    
    fileprivate var lblTitle: UILabel!
    fileprivate var lblSubTitle: UILabel!
    
    fileprivate var scrlView: UIScrollView!
    fileprivate var btnFillBlank: ListButton!
    fileprivate var btnEditSave: ListButton!
    fileprivate var btnSendFinalized: ListButton!
    fileprivate var btnGetBlank: ListButton!
    fileprivate var btnDeleteSaved: ListButton!
    
    var settingVC : SettingViewController?
    var loginVC : LoginViewController?

    var getBalnkForm : GetBlankFormViewController?
    var getFillForm : FillFormViewController?
    var editForm : EditFormViewController?
    var deleteVC:DeleteViewController?
    var sendFinalizedVC:SendFinalizedFormViewController?



    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadHeaderView()

        //display data sample
        
//        let txtField = CustomTextFieldForAttribute(frame: CGRect(x: 0, y: label_height, width: SCREEN_WIDTH - (x_padding*2), height: controls_height))
//        txtField.delegate = self as UITextFieldDelegate
//        txtField.tag = Int(pLayerField.id!)!
//        txtField.returnKeyType = .done
//
//        let buttonAddImage = CustomButtonImageOrDocument(frame: CGRect(x: 0, y: label_height, width: 170, height: CUSTOM_BUTTON_HEIGHT))
//        buttonAddImage.setTitle(" Add Image", for: .normal)
//        buttonAddImage.contentHorizontalAlignment = .left
//        buttonAddImage.tag = Int(pLayerField.id!)!
//        buttonAddImage.imgIcon.image = UIImage(named: DATATYPE_IMAGE_ICON)
//        buttonAddImage.addTarget(self, action: #selector(btnAddImagePressed(sender:)), for: .touchUpInside)
//        smallView.addSubview(buttonAddImage)

//        let genderView = GenderView(frame:  CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
//        genderView.initDesign(pName: "Gender", pTag: 6, pOptions: ["Male","Female","Other"])
//        self.appFormScrollView.addSubview(genderView)
        
        // Do any additional setup after loading the view.
    }
    func loadHeaderView() {
        
        headerview = UIView(frame: CGRect(x: 0, y:( STATUS_BAR_HEIGHT + Int(ParentClass.sharedInstance.iPhone_X_Top_Padding)), width: Int(UIScreen.main.bounds.width), height: NAV_HEADER_HEIGHT));
        headerview.backgroundColor = colorPrimary
        self.view.addSubview(headerview)
        
        self.buttonBack = UIButton(frame: CGRect(x: X_PADDING, y: 0, width: SCREEN_WIDTH, height: NAV_HEADER_HEIGHT))
        self.buttonBack.setTitle("Main Menu", for: .normal)
        self.buttonBack.setTitleColor(.white, for: .normal)
        self.buttonBack.titleLabel?.font = UIFont .boldSystemFont(ofSize:NAV_HEADER_FONT_SIZE )
        self.buttonBack.contentHorizontalAlignment = .left
        self.buttonBack.backgroundColor = UIColor.clear
        headerview.addSubview(self.buttonBack)
        
        self.buttonMenu = UIButton(frame: CGRect(x: (SCREEN_WIDTH - NAV_HEADER_HEIGHT - X_PADDING), y: 0, width: NAV_HEADER_HEIGHT, height: NAV_HEADER_HEIGHT))
//        self.buttonMenu.setTitle("M", for: .normal)
        self.buttonMenu.setImage(UIImage (named: "Menu"), for: .normal)
        self.buttonMenu.contentHorizontalAlignment = .right
        self.buttonMenu.backgroundColor = .clear
        self.buttonMenu.addTarget(self, action: #selector(goToSetting), for: .touchUpInside)
        headerview.addSubview(self.buttonMenu)
        
        yPosition = Int(headerview.frame.maxY) + Y_PADDING
        
        self.initDesign()
    }
    
    @objc func goToSetting()  {
        
        DispatchQueue.main.async(execute: {
            let alert = Utils.getAlertController(title: "", message: "choose option", style: .actionSheet)
            alert.addAction((UIAlertAction(title: "Setting", style: .default, handler: {(action) -> Void in
                self.settingVC = SettingViewController()
                self.navigationController?.pushViewController(self.settingVC!, animated: true)
            })))
            
            alert.addAction((UIAlertAction(title: "Logout", style: .default, handler: {(action) -> Void in
                ParentClass.sharedInstance.setData(strData: false, strKey: REMEMBER_ME_KEY)
                ParentClass.sharedInstance.setData(strData: "", strKey: FILL_BLANK_ARRAY)

                self.loginVC = LoginViewController()
                self.navigationController?.pushViewController(self.loginVC!, animated: true)
                
            })))
            alert.addAction((UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) -> Void in
                
            })))
            
            self.present(alert, animated: true, completion: nil)
        })
        
    }
    
    func initDesign(){
        
        lblTitle = UILabel (frame: CGRect (x: 0, y: yPosition, width: SCREEN_WIDTH, height: CUSTOM_BUTTON_HEIGHT))
        lblTitle.text = "Mclytics v1.0"
        lblTitle.textColor = colorPrimary
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.boldSystemFont(ofSize: HEADER_LABEL_FONT_SIZE)
       self.view.addSubview(lblTitle)
        
        yPosition += CUSTOM_BUTTON_HEIGHT
        
        lblSubTitle = UILabel (frame: CGRect (x: 0, y: yPosition, width: SCREEN_WIDTH, height: CUSTOM_TEXTFIELD_HEIGHT))
        lblSubTitle.text = "Secure, high-quality data-collection"
        lblSubTitle.textAlignment = .center
        lblSubTitle.font = UIFont (name: APP_FONT_NAME_BOLD, size: SUB_LABEL_DESC_FONT_SIZE)
        lblSubTitle.textColor = colorSubHeading_76
        self.view.addSubview(lblSubTitle)
        
        yPosition += CUSTOM_TEXTFIELD_HEIGHT + X_PADDING
        
        self.initScroll()
    }
    
   
    func initScroll(){
        
        scrlView = UIScrollView (frame: CGRect (x: 0, y: yPosition, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - yPosition))
        scrlView.backgroundColor = .clear
        
        var yposition : Int! = Y_PADDING

        btnFillBlank = ListButton (frame: CGRect (x: X_PADDING, y: yposition , width: SCREEN_WIDTH - X_PADDING*2, height: TOP_HEADER_HEIGHT))
        print(btnFillBlank.frame)
        btnFillBlank.setTitle("Fill Blank Form", for: .normal)
        btnFillBlank.setImage(UIImage (named: "Fill-Black-Form"), for: .normal)
        btnFillBlank.tag = TAG1
        btnFillBlank.addTarget(self, action: #selector(onButtonPrssed(sender:)), for: .touchUpInside)
        scrlView.addSubview(btnFillBlank)
        
         yposition += Y_PADDING + TOP_HEADER_HEIGHT

        btnEditSave = ListButton (frame: CGRect (x: X_PADDING, y: yposition , width: SCREEN_WIDTH - X_PADDING*2, height: TOP_HEADER_HEIGHT))
        btnEditSave.setTitle("Edit Saved Form", for: .normal)
        btnEditSave.setImage(UIImage (named: "Edit-Saved-Form"), for: .normal)
        btnEditSave.tag = TAG2
        btnEditSave.addTarget(self, action: #selector(onButtonPrssed(sender:)), for: .touchUpInside)
        scrlView.addSubview(btnEditSave)

         yposition += Y_PADDING + TOP_HEADER_HEIGHT

        btnSendFinalized = ListButton (frame: CGRect (x: X_PADDING, y: yposition , width: SCREEN_WIDTH - X_PADDING*2, height: TOP_HEADER_HEIGHT))
        btnSendFinalized.setTitle("Send Finalized Form", for: .normal)
        btnSendFinalized.tag = TAG3
        btnSendFinalized.setImage(UIImage (named: "Send-Finalized-Form"), for: .normal)
        btnSendFinalized.addTarget(self, action: #selector(onButtonPrssed(sender:)), for: .touchUpInside)
        scrlView.addSubview(btnSendFinalized)

         yposition += Y_PADDING + TOP_HEADER_HEIGHT


        btnGetBlank = ListButton (frame: CGRect (x: X_PADDING, y: yposition , width: SCREEN_WIDTH - X_PADDING*2, height: TOP_HEADER_HEIGHT))
        btnGetBlank.setTitle("Get Blank Form", for: .normal)
        btnGetBlank.setImage(UIImage (named: "Get-Blank-Form"), for: .normal)
        btnGetBlank.tag = TAG4
        btnGetBlank.addTarget(self, action: #selector(onButtonPrssed(sender:)), for: .touchUpInside)
        scrlView.addSubview(btnGetBlank)

         yposition += Y_PADDING + TOP_HEADER_HEIGHT

        btnDeleteSaved = ListButton (frame: CGRect (x: X_PADDING, y: yposition , width: SCREEN_WIDTH - X_PADDING*2, height: TOP_HEADER_HEIGHT))
        btnDeleteSaved.setTitle("Delete Saved Form", for: .normal)
        btnDeleteSaved.tag = TAG5
        btnDeleteSaved.addTarget(self, action: #selector(onButtonPrssed(sender:)), for: .touchUpInside)
        btnDeleteSaved.setImage(UIImage (named: "Delete-Saved-Form"), for: .normal)
        scrlView.addSubview(btnDeleteSaved)

         yposition += Y_PADDING + TOP_HEADER_HEIGHT

        self.view.addSubview(scrlView)

//        scrlView.contentSize = CGSize (width: SCREEN_WIDTH, height: yposition)

    }
    
    
    @objc func onButtonPrssed(sender : UIButton)  {
        
        switch sender.tag {
        case 1:
            self.getFillForm = FillFormViewController()
            self.getFillForm?.lblTitle = sender.currentTitle
            self.navigationController?.pushViewController(self.getFillForm!, animated: true)
            break
        case 2:
            self.editForm = EditFormViewController()
            self.editForm?.lblTitle = sender.currentTitle
            self.navigationController?.pushViewController(self.editForm!, animated: true)
            break
        case 3:
            self.sendFinalizedVC = SendFinalizedFormViewController()
            self.sendFinalizedVC?.lblTitle = sender.currentTitle
            self.navigationController?.pushViewController(self.sendFinalizedVC!, animated: true)
            break
        case 4:
            self.getBalnkForm = GetBlankFormViewController()
            self.getBalnkForm?.lblTitle = sender.currentTitle
            self.navigationController?.pushViewController(self.getBalnkForm!, animated: true)
            break
        case 5:
            self.deleteVC = DeleteViewController()
            self.deleteVC?.lblTitle = sender.currentTitle
            self.navigationController?.pushViewController(self.deleteVC!, animated: true)
            break
        default:
            break
        }
        
        
        
        
    }
    

}

