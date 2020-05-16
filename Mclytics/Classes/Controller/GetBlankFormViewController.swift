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
    
    var listArry : [JSON]? = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHeaderView()
        apiGetBlankFromData()
        // Do any additional setup after loading the view.
    }
    
    func apiGetBlankFromData() {
    

           WebServicesManager.getForm(page: 1,  onCompletion: { (responce) in
            var strToken: String = ""
            var strMsg: String = ""
            
            strToken = responce!["token"].stringValue
            strMsg = responce!["message"].stringValue
            self.listArry =  responce!["response"].array
            if self.listArry!.count > 0 {
                self.tblList.reloadData()
            }
            if strMsg != ""{
                super.showAlert(message: strMsg, type: .error, navBar: false)
                return
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
//        self.buttonBack.addTarget(self, action: #selector(goToBack), for: .touchUpInside)
        
        headerview.addSubview(self.buttonBack)
        
        self.buttonMenu = UIButton(frame: CGRect(x: X_PADDING*2 + Int(buttonBack.frame.width) , y: 0, width: SCREEN_WIDTH - NAV_HEADER_HEIGHT , height: NAV_HEADER_HEIGHT))
        self.buttonMenu.setTitle(lblTitle, for: .normal)
        self.buttonMenu.contentHorizontalAlignment = .left
        self.buttonMenu.backgroundColor = .clear
        headerview.addSubview(self.buttonMenu)
        
        yPosition = Int(headerview.frame.maxY) + Y_PADDING
        
        self.initTableview()
    }
    
    func initTableview()  {
        // layer list
        self.tblList = UITableView (frame: CGRect(x: 0, y: yPosition, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - yPosition), style: .plain)
        self.tblList.delegate = self
        self.tblList.dataSource = self
        self.tblList.tag = 9999
        self.tblList.register(GetBlankFormCell.self, forCellReuseIdentifier: "GetBlankFormCell")
        self.tblList.separatorStyle = .singleLine
        self.tblList.separatorInset = UIEdgeInsets (top: 0, left: 0, bottom: 0, right: 0)
        self.tblList.showsVerticalScrollIndicator = false
        self.tblList.backgroundColor = .clear
        self.tblList.rowHeight = UITableView.automaticDimension
        self.tblList.estimatedRowHeight = 44
        self.view .addSubview(self.tblList)
//        self.externalLayerTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   self.listArry!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // external layers
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GetBlankFormCell.self)) as! GetBlankFormCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
    
        cell.lblFieldName.text = listArry![indexPath.row]["name"].stringValue
        cell.lblSubFieldName.text = "sulg: \(listArry![indexPath.row]["slug"].stringValue)"

        return cell
    }
    
    
    
}
