//
//  PendingKhadiStoresListTableViewController.swift
//  TestSpatialite
//
//  Created by Gaurav on 06/02/20.
//  Copyright © 2020 Gaurav. All rights reserved.
//

import UIKit
import SwiftyJSON

class DeleteListTableViewController: ParentClass,UITableViewDelegate,UITableViewDataSource {
    
//    var inspctionForm:InspectionFormViewController!
    var arrayStoreLists:[[String:Any]]! = [[String:Any]]()
    var arrayDeleteLists:[[String:Any]]! = [[String:Any]]()
    var countDeleteList = 0
    var vcDelegate:DeleteViewController!
    var arrAddressChanged:[String]?
    var arrNotTraceble:[String]?

    var type:String!
    var tblList:UITableView!
    var buttonDELETE : CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let str =   ParentClass.sharedInstance.getDataForKey(strKey: FILL_BLANK_ARRAY) as? String
        if str != "" && str != nil{
            arrayStoreLists = Utils.jsonObject(jsonString: str!)
            self.initTableview()
        }else{
            let lblSubTitle = UILabel (frame: CGRect (x: X_PADDING, y: 0, width: SCREEN_WIDTH - X_PADDING*2, height: SCREEN_HEIGHT))
            //            lblSubTitle.center = CGPoint (x: self.view.center.x, y: lblSubTitle.center.y)
            lblSubTitle.text =  CS.Common.NoData
            lblSubTitle.numberOfLines = 0
            lblSubTitle.lineBreakMode = .byWordWrapping
            lblSubTitle.textAlignment = .center
            lblSubTitle.font = UIFont (name: APP_FONT_NAME_BOLD, size: SUB_LABEL_DESC_FONT_SIZE)
            lblSubTitle.textColor = .black
            self.view.addSubview(lblSubTitle)
        }
    }
    func initTableview()  {
        // layer list
        var ypostion = 0
        if IS_IPHONE_X_XR_XMAX{
            ypostion  = 70 + STATUS_BAR_HEIGHT + Int(ParentClass.sharedInstance.iPhone_X_Top_Padding)
        }else{
            ypostion  = 100 + STATUS_BAR_HEIGHT + Int(ParentClass.sharedInstance.iPhone_X_Top_Padding)
        }
        
        self.tblList = UITableView (frame: CGRect(x: 0, y:  ypostion , width: SCREEN_WIDTH, height: SCREEN_HEIGHT - CUSTOM_BUTTON_HEIGHT - ypostion - X_PADDING*2), style: .plain)
        self.tblList.delegate = self
        self.tblList.dataSource = self
        self.tblList.tag = 8888
        self.tblList.register(FormListCell.self, forCellReuseIdentifier: "FormListCell")
        self.tblList.separatorStyle = .singleLine
        self.tblList.separatorInset = UIEdgeInsets (top: 0, left: 0, bottom: 0, right: 0)
        self.tblList.showsVerticalScrollIndicator = false
        self.tblList.backgroundColor = .clear
        self.tblList.estimatedRowHeight = UITableView.automaticDimension
        self.tblList.rowHeight = TABLEVIEW_CELL_HEIGHT
        self.tblList.showsVerticalScrollIndicator = false
        self.view .addSubview(self.tblList)
        self.tblList.tableFooterView = UIView()
        //save button
        buttonDELETE = CustomButton(frame: CGRect(x: X_PADDING, y: SCREEN_HEIGHT -  CUSTOM_BUTTON_HEIGHT - X_PADDING, width: SCREEN_WIDTH - (X_PADDING*2), height: CUSTOM_BUTTON_HEIGHT))
        buttonDELETE.setTitle("DELETE", for: .normal)
        buttonDELETE.addTarget(self, action: #selector(onDeletePressed), for: .touchUpInside)
        buttonDELETE.setTitleColor(.darkGray, for: .disabled)
        buttonDELETE.backgroundColor = UIColor.lightGray
        buttonDELETE.isEnabled = false
        self.view.addSubview(buttonDELETE)
    }
    
    @objc func onDeletePressed(){

        for temp in self.arrayDeleteLists{
            let tempSlug2 =  temp["index"] as? Int
            let index = self.arrayStoreLists.firstIndex(where: { dictionary in
                guard let value = dictionary["index"] as? Int
                    else { return false }
                return value == tempSlug2
            })
            if let index = index {
                arrayStoreLists.remove(at: index)
            }
        }
        let str = Utils.stringFromJson(object: arrayStoreLists)
        print(str)
        ParentClass.sharedInstance.setData(strData: str, strKey: FILL_BLANK_ARRAY)
        
         tblList.reloadData()
        self.arrayDeleteLists =  [[String:Any]]()
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.arrNotTraceble = ParentClass.sharedInstance.getDataForKey(strKey: STORE_NOT_TRACEBLE_ARRAY) as? [String]
    }
    
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TABLEVIEW_CELL_HEIGHT
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.arrayStoreLists.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FormListCell.self)) as! FormListCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        cell.lblFieldName.text =  self.arrayStoreLists[indexPath.row]["name"] as? String
        cell.lblSubFieldName.text = "sulg: \( self.arrayStoreLists[indexPath.row]["slug"] ?? "")"
        let strDate = ParentClass.sharedInstance.dateConvert(date: ( self.arrayStoreLists[indexPath.row]["created_at"] as? Double)!)
        cell.lblSubFieldDate.text = "Added on \(strDate)"
        cell.btncheckbox.tag = indexPath.row
        cell.btncheckbox.isSelected = false
        cell.btncheckbox.addTarget(self, action: #selector(onCheckListPressed(sender:)), for: .touchUpInside)
        return cell
       
    
    }
    @objc func onCheckListPressed(sender:UIButton)  {
        if sender.isSelected {
            if ((self.arrayDeleteLists.count) != 0){
                let tempSlug2 =  self.arrayStoreLists[sender.tag]["index"] as? Int
                let index = self.arrayDeleteLists.firstIndex(where: { dictionary in
                    guard let value = dictionary["index"] as? Int
                        else { return false }
                    return value == tempSlug2
                })
                if let index = index {
                    arrayDeleteLists.remove(at: index)
                }
                sender.isSelected = false
            }
        }else{
            let temp = arrayStoreLists[sender.tag]
            arrayDeleteLists.append(temp)
            sender.isSelected = true
        }
   
        if self.arrayDeleteLists.count >= 1{
            buttonDELETE.isEnabled = true
            buttonDELETE.backgroundColor = colorPrimary
        }else{
            buttonDELETE.setTitleColor(.darkGray, for: .disabled)
            buttonDELETE.backgroundColor = UIColor.lightGray
            buttonDELETE.isEnabled = false
        }
        
    }
    
}
