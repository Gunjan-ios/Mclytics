//
//  EditFormViewController.swift
//  Mclytics
//
//  Created by Gunjan Raval on 21/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit
import SwiftyJSON
class EditFormViewController: ParentClass,UITableViewDelegate,UITableViewDataSource {
    fileprivate var headerview:UIView!
    fileprivate var buttonBack: UIButton!
    fileprivate var buttonMenu: UIButton!
    fileprivate var yPosition: Int!
    var lblTitle: String!
    
    fileprivate var tblList: UITableView!
    private var currentPage = 1
    private var totalPage = 1
    
//    var elistArray : [[String:Any]] = [[String:Any]]()
    var elistArray : JSON = JSON()

    fileprivate var buttonSave: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHeaderView()
        let str =   ParentClass.sharedInstance.getDataForKey(strKey: FILL_BLANK_ARRAY) as? String
        
        if str != "" && str != nil{
            elistArray = Utils.jsonObject(jsonString: str!)
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
        self.buttonMenu.setTitle(lblTitle, for: .normal)
        self.buttonMenu.contentHorizontalAlignment = .left
        self.buttonMenu.backgroundColor = .clear
        headerview.addSubview(self.buttonMenu)
        
        yPosition = Int(headerview.frame.maxY) + Y_PADDING
        
        //        //save button
        //        let buttonREFRESH = CustomButton(frame: CGRect(x: X_PADDING, y: SCREEN_HEIGHT -  CUSTOM_BUTTON_HEIGHT - X_PADDING, width: SCREEN_WIDTH/2 - (X_PADDING*2), height: CUSTOM_BUTTON_HEIGHT))
        //        buttonREFRESH.setTitle("REFRESH", for: .normal)
        //        buttonREFRESH.addTarget(self, action: #selector(onRefreshPressed), for: .touchUpInside)
        //        self.view.addSubview(buttonREFRESH)
        //
        //        //save button
        //        buttonSave = CustomButton(frame: CGRect(x: SCREEN_WIDTH - SCREEN_WIDTH/2 + X_PADDING , y: SCREEN_HEIGHT -  CUSTOM_BUTTON_HEIGHT - X_PADDING, width: SCREEN_WIDTH/2 - (X_PADDING*2), height: CUSTOM_BUTTON_HEIGHT))
        //        buttonSave.setTitle("GET SELECTED", for: .normal)
        //        buttonSave.setTitleColor(.darkGray, for: .disabled)
        //        buttonSave.backgroundColor = UIColor.lightGray
        //        buttonSave.isEnabled = false
        //        //        buttonSave.addTarget(self, action: #selector(btnSavePressed), for: .touchUpInside)
        //        //        buttonSave.tag = 9999
        //        self.view.addSubview(buttonSave)
        //
    }
    @objc func onRefreshPressed()  {
        currentPage = 1
        //        apiGetBlankFromData(page: 1)
    }
    
    @objc func goToBack()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initTableview()  {
        // layer list
        self.tblList = UITableView (frame: CGRect(x: 0, y: yPosition, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - yPosition - CUSTOM_BUTTON_HEIGHT - X_PADDING*2), style: .plain)
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
        self.view .addSubview(self.tblList)
        //        self.externalLayerTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   self.elistArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FormListCell.self)) as! FormListCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
//        print(elistArray[indexPath.row]["name"] as? String)
//        print(elistArray[indexPath.row]["slug"] as? String)
        
        cell.lblFieldName.text = elistArray[indexPath.row]["name"].stringValue
        cell.lblSubFieldName.text = "sulg: \(elistArray[indexPath.row]["slug"].stringValue)"
        let strDate = ParentClass.sharedInstance.dateConvert(date: elistArray[indexPath.row]["created_at"].doubleValue)
        cell.lblSubFieldDate.text = "Added on \(strDate)"
        cell.btncheckbox.isHidden = true
        
        //        cell.btncheckbox.tag = indexPath.row
        //        cell.btncheckbox.addTarget(self, action: #selector(onCheckListPressed(sender:)), for: .touchUpInside)
        return cell
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
