//
//  GetBlankFormViewController.swift
//  Mclytics
//
//  Created by Gunjan Raval on 16/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit
import SwiftyJSON


class GetBlankFormViewController: ParentClass,UITableViewDelegate,UITableViewDataSource {

    fileprivate var headerview:UIView!
    fileprivate var buttonBack: UIButton!
    fileprivate var buttonMenu: UIButton!
    fileprivate var yPosition: Int!
    var lblTitle: String!
    
    fileprivate var tblList: UITableView!
    private var currentPage = 1
    private var totalPage = 1
    var count = 0

    var listArry : [[String : Any]] = [[String:Any]]()
    
    fileprivate var buttonSave: CustomButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHeaderView()
        apiGetBlankFromData(page: currentPage)
        // Do any additional setup after loading the view.
    }
    
 func apiGetBlankFromData(page : Int) {
    WebServicesManager.getForm(page: page,  onCompletion: { (responce) in
        
        var strMsg: String = ""
        strMsg = responce!["message"].stringValue
        
        if strMsg != ""{
            super.showAlert(message: strMsg, type: .error, navBar: false)
            return
        }
        let tempAray = responce!["response"].arrayObject
        self.totalPage  =  responce!["_meta"]["pageCount"].intValue
        print(self.totalPage)
        
        for tampAry1 in tempAray!{
            var tamp : [String : Any] = [String:Any]()
            tamp = tampAry1 as! [String : Any]
            tamp["index"] = self.count
            self.listArry.append(tamp)
            self.count += 1
        }
        self.currentPage += 1
        if self.listArry.count > 0 {
                self.tblList.reloadData()
            }
        
        }) { (error) in
            print(error as Any)
            super.showAlert(message: CS.Common.wrongMsg, type: .error, navBar: false)
            
        }
        
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
        self.buttonMenu.setTitle(lblTitle, for: .normal)
        self.buttonMenu.contentHorizontalAlignment = .left
        self.buttonMenu.backgroundColor = .clear
        headerview.addSubview(self.buttonMenu)
        
        yPosition = Int(headerview.frame.maxY) + Y_PADDING
        
        //save button
        let buttonREFRESH = CustomButton(frame: CGRect(x: X_PADDING, y: SCREEN_HEIGHT -  CUSTOM_BUTTON_HEIGHT - X_PADDING, width: SCREEN_WIDTH/2 - (X_PADDING*2), height: CUSTOM_BUTTON_HEIGHT))
        buttonREFRESH.setTitle("REFRESH", for: .normal)
        buttonREFRESH.addTarget(self, action: #selector(onRefreshPressed), for: .touchUpInside)
        self.view.addSubview(buttonREFRESH)
        
        //save button
        buttonSave = CustomButton(frame: CGRect(x: SCREEN_WIDTH - SCREEN_WIDTH/2 + X_PADDING , y: SCREEN_HEIGHT -  CUSTOM_BUTTON_HEIGHT - X_PADDING, width: SCREEN_WIDTH/2 - (X_PADDING*2), height: CUSTOM_BUTTON_HEIGHT))
        buttonSave.setTitle("GET SELECTED", for: .normal)
        buttonSave.setTitleColor(.darkGray, for: .disabled)
        buttonSave.backgroundColor = UIColor.lightGray
        buttonSave.isEnabled = false
        buttonSave.addTarget(self, action: #selector(getSelected), for: .touchUpInside)
//        buttonSave.tag = 9999
        self.view.addSubview(buttonSave)
        
        self.initTableview()
    }
    @objc func onRefreshPressed()  {
        currentPage = 1
        apiGetBlankFromData(page: 1)
    }

    @objc func getSelected(){
       print(ParentClass.sharedInstance.saveListArray.count)
        
        let str = Utils.stringFromJson(object: ParentClass.sharedInstance.saveListArray)
        print(str)
        ParentClass.sharedInstance.setData(strData: str, strKey: FILL_BLANK_ARRAY)
        goToBack()
    }
    @objc func goToBack()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initTableview()  {
        // layer list
        self.tblList = UITableView (frame: CGRect(x: 0, y: yPosition, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - yPosition - CUSTOM_BUTTON_HEIGHT - X_PADDING*2), style: .plain)
        self.tblList.delegate = self
        self.tblList.dataSource = self
        self.tblList.tag = 9999
        self.tblList.register(GetBlankFormCell.self, forCellReuseIdentifier: "GetBlankFormCell")
        self.tblList.separatorStyle = .singleLine
        self.tblList.separatorInset = UIEdgeInsets (top: 0, left: 0, bottom: 0, right: 0)
        self.tblList.showsVerticalScrollIndicator = false
        self.tblList.backgroundColor = .clear
        self.tblList.estimatedRowHeight = UITableView.automaticDimension
        self.tblList.rowHeight = SIDE_PANEL_LABEL_CELL_HEIGHT
        self.view .addSubview(self.tblList)
//        self.externalLayerTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   self.listArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GetBlankFormCell.self)) as! GetBlankFormCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear

        cell.lblFieldName.text = self.listArry[indexPath.row]["name"] as? String
        let strslg = self.listArry[indexPath.row]["slug"] as? String
        cell.lblSubFieldName.text = "sulg: \(strslg ?? "")"
        cell.btncheckbox.tag = indexPath.row
        cell.btncheckbox.addTarget(self, action: #selector(onCheckListPressed(sender:)), for: .touchUpInside)
        return cell
    }

    @objc func onCheckListPressed(sender:UIButton)  {
        print(sender.tag)
        let tempSlug =  self.listArry[sender.tag]["index"] as? Int
        if sender.isSelected {
            if ((ParentClass.sharedInstance.saveListArray.count) != 0){
                ParentClass.sharedInstance.saveListArray.remove(at: tempSlug!)
                sender.isSelected = false
            }
        }else{
            var temp = listArry[sender.tag]
            print(temp["slug"] as? String)
            ParentClass.sharedInstance.saveListArray.append(temp)
            sender.isSelected = true
        }
        print(ParentClass.sharedInstance.saveListArray.count)
      
//        if sender.isSelected {
//            if ((ParentClass.sharedInstance.saveListArray.count) != 0){
//                var array1 : [[String:Any]] = [[String:Any]]()
//                for  temp1 in ParentClass.sharedInstance.saveListArray{
//                let strSlug = temp1["slug"] as? String
//                    if strSlug != tempSlug{
//                        array1.append(temp1)
//                    }
//                }
//                ParentClass.sharedInstance.saveListArray = array1
//                print(ParentClass.sharedInstance.saveListArray as Any)
//                sender.isSelected = false
//               }
//            }else{
//            var temp = listArry[sender.tag]
//            print(temp["slug"] as? String)
//            ParentClass.sharedInstance.saveListArray.append(temp)
//            sender.isSelected = true
//        }
    
        if ParentClass.sharedInstance.saveListArray.count >= 1{
            buttonSave.isEnabled = true
            buttonSave.backgroundColor = colorPrimary
        }else{
            buttonSave.setTitleColor(.darkGray, for: .disabled)
            buttonSave.backgroundColor = UIColor.lightGray
            buttonSave.isEnabled = false
        }

    }
 
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = self.listArry.count - 1
        if indexPath.row == lastItem {
            print("IndexRow\(indexPath.row)")
            if currentPage <= totalPage {
                print(currentPage)
                //Get data from Server
                apiGetBlankFromData(page: currentPage)
            }
            else{
                super.showAlert(message: "No more Data.", type: .error, navBar: false)
                }
        }
    }
}
