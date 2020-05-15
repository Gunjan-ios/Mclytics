//
//  ViewController.swift
//  Mclytics
//
//  Created by Gunjan Raval on 11/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit

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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadHeaderView()
        
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
      scrlView.addSubview(btnFillBlank)
        
         yposition += Y_PADDING + TOP_HEADER_HEIGHT

        btnEditSave = ListButton (frame: CGRect (x: X_PADDING, y: yposition , width: SCREEN_WIDTH - X_PADDING*2, height: TOP_HEADER_HEIGHT))
        btnEditSave.setTitle("Edit Saved Form", for: .normal)
        btnEditSave.setImage(UIImage (named: "Edit-Saved-Form"), for: .normal)
        scrlView.addSubview(btnEditSave)

         yposition += Y_PADDING + TOP_HEADER_HEIGHT


        btnSendFinalized = ListButton (frame: CGRect (x: X_PADDING, y: yposition , width: SCREEN_WIDTH - X_PADDING*2, height: TOP_HEADER_HEIGHT))
        btnSendFinalized.setTitle("Send Finalized Form", for: .normal)
        btnSendFinalized.setImage(UIImage (named: "Send-Finalized-Form"), for: .normal)

        scrlView.addSubview(btnSendFinalized)

         yposition += Y_PADDING + TOP_HEADER_HEIGHT


        btnGetBlank = ListButton (frame: CGRect (x: X_PADDING, y: yposition , width: SCREEN_WIDTH - X_PADDING*2, height: TOP_HEADER_HEIGHT))
        btnGetBlank.setTitle("Get Blank Form", for: .normal)
        btnGetBlank.setImage(UIImage (named: "Get-Blank-Form"), for: .normal)

        scrlView.addSubview(btnGetBlank)

         yposition += Y_PADDING + TOP_HEADER_HEIGHT

        btnDeleteSaved = ListButton (frame: CGRect (x: X_PADDING, y: yposition , width: SCREEN_WIDTH - X_PADDING*2, height: TOP_HEADER_HEIGHT))
        btnDeleteSaved.setTitle("Delete Saved Form", for: .normal)
        btnDeleteSaved.setImage(UIImage (named: "Delete-Saved-Form"), for: .normal)

        scrlView.addSubview(btnDeleteSaved)

         yposition += Y_PADDING + TOP_HEADER_HEIGHT

        self.view.addSubview(scrlView)

//        scrlView.contentSize = CGSize (width: SCREEN_WIDTH, height: yposition)

    }
    

}

