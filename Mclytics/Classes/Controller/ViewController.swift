//
//  ViewController.swift
//  Mclytics
//
//  Created by Gunjan Raval on 11/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: ParentClass,UITextFieldDelegate {
    
    fileprivate var headerview:UIView!
    fileprivate var buttonBack: UIButton!
    fileprivate var buttonMenu: UIButton!
    fileprivate var buttonImport: UIButton!
    fileprivate var buttonSync: UIButton!
    fileprivate var yPosition: Int!
    
    fileprivate var lblTitle: UILabel!
    fileprivate var lblSubTitle: UILabel!
    
    fileprivate var scrlView: UIScrollView!
    fileprivate var btnFillBlank: ListButton!
    fileprivate var btnEditSave: ListButton!
    fileprivate var btnSendFinalized: ListButton!
    fileprivate var btnGetBlank: ListButton!
    fileprivate var btnDeleteSaved: ListButton!
    
    //contorllers
    var settingVC : SettingViewController?
    var loginVC : LoginViewController?
    var getBalnkForm : GetBlankFormViewController?
    var getFillForm : FillFormViewController?
    var editForm : EditFormViewController?
    var deleteVC:DeleteViewController?
    var sendFinalizedVC:SendFinalizedFormViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let listArray = ParentClass.sharedInstance.getDataForKey(strKey: FILL_BLANK_ARRAY) as? Data {
//            if let decodedArray = NSKeyedUnarchiver.unarchiveObject(with: listArray) as? [MainFormModal] {
//                saveListArray = decodedArray
//            }
//        }
        saveListArray = ParentClass.sharedInstance.getDataJSON(key: FILL_BLANK_ARRAY)

        print(ParentClass.sharedInstance.getDataForKey(strKey:TOKEN_KEY))

        self.loadHeaderView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let str = ParentClass.sharedInstance.getDataForKey(strKey: EDIT_BLANK_ARRAY) as? String
//
//        if str != "" && str != nil{
//            editListArray1 = Utils.jsonObject(jsonString: str!).array!
//            btnEditSave.setTitle("Edit Saved Form (\(editListArray1.count))", for: .normal)
//        }
        
        if let listArray = ParentClass.sharedInstance.getDataForKey(strKey: EDIT_BLANK_ARRAY) as? Data {
            if let decodedArray = NSKeyedUnarchiver.unarchiveObject(with: listArray) as? [MainFormModal] {
                editListArray = decodedArray
                btnEditSave.setTitle("Edit Saved Form (\(editListArray.count))", for: .normal)
            }
        }
        
        if let listArray1 = ParentClass.sharedInstance.getDataForKey(strKey: FINALIZED_ARRAY) as? Data {
            if let decodedArray1 = NSKeyedUnarchiver.unarchiveObject(with: listArray1) as? [MainFormModal] {
                finalizedListArray = decodedArray1
                btnSendFinalized.setTitle("Send Finalized Form (\(finalizedListArray.count))", for: .normal)
            }
        }
        if ParentClass.sharedInstance.getDataForKey(strKey: DISPLAY_STATUS) as? Bool == true{
            self.buttonImport.isHidden = false
            self.buttonSync.isHidden = false
        }else{
            self.buttonImport.isHidden = true
            self.buttonSync.isHidden = true
        }



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
        
        self.buttonSync = UIButton(frame: CGRect(x: (SCREEN_WIDTH - NAV_HEADER_HEIGHT*2 - X_PADDING*2), y: 0, width: NAV_HEADER_HEIGHT, height: NAV_HEADER_HEIGHT))
        self.buttonSync.setImage(UIImage (named: "sync"), for: .normal)
        self.buttonSync.contentHorizontalAlignment = .right
        self.buttonSync.backgroundColor = .clear
        self.buttonSync.isHidden = true
        self.buttonSync.addTarget(self, action: #selector(onSyncPressed), for: .touchUpInside)
        headerview.addSubview(self.buttonSync)
        
        self.buttonImport = UIButton(frame: CGRect(x: (SCREEN_WIDTH - NAV_HEADER_HEIGHT*3 - X_PADDING*3), y: 0, width: NAV_HEADER_HEIGHT, height: NAV_HEADER_HEIGHT))
        self.buttonImport.setImage(UIImage (named: "import"), for: .normal)
        self.buttonImport.contentHorizontalAlignment = .right
        self.buttonImport.backgroundColor = .clear
        self.buttonImport.isHidden = true
        self.buttonImport.addTarget(self, action: #selector(goToSetting), for: .touchUpInside)
        headerview.addSubview(self.buttonImport)
        
        yPosition = Int(headerview.frame.maxY) + Y_PADDING
        
        
        if ParentClass.sharedInstance.getDataForKey(strKey: DISPLAY_STATUS) as? Bool == true{
            self.buttonImport.isHidden = false
            self.buttonSync.isHidden = false

        }
        
        self.initDesign()
    }
    
    @objc func onSyncPressed()  {
        finalizedListArray = ParentClass.sharedInstance.getDataJSON(key: FINALIZED_ARRAY)
        var count = finalizedListArray.count
        
        if count > 0{
            for obj in finalizedListArray{
                DispatchQueue.main.async {
                    WebServicesManager.formSubmit(formData: obj.param , fromId: obj.id, andCompletion: { (isSuccess, response) in
                        if isSuccess {
                            if let strMsg = response["message"] as? String {
                                if strMsg != ""{
                                    count -= 1
                                    if count == 0 {
                                        super.showAlert(message: CS.Common.pushdata, type: .error, navBar: false)
                                    }
                                    return
                                }
                            }
                        } else {
                            super.showAlert(message: CS.Common.wrongMsg, type: .error, navBar: false)
                        }
                    }) { (error) in
                        super.showAlert(message: CS.Common.wrongMsg, type: .error, navBar: false)
                    }
                }
            }
        }else{
            super.showAlert(message: CS.Common.blankSyncMsg, type: .error, navBar: false)
        }

      }
    
    @objc func goToSetting()  {
        
        DispatchQueue.main.async(execute: {
            let alert = Utils.getAlertController(title: "", message: "Options", style: .actionSheet)
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
            

            if let popoverPresentationController = alert.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
                popoverPresentationController.sourceRect = self.buttonMenu.frame
                self.present(alert, animated: true, completion: nil)
            }else{
                self.present(alert, animated: true, completion: nil)

            }
            
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
        btnEditSave.setTitle("Edit Saved Form (\(saveListArray.count))", for: .normal)
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

        scrlView.contentSize = CGSize (width: SCREEN_WIDTH, height: yposition + 100)

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

