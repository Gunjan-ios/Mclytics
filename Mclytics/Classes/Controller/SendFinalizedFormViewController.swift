//
//  SendFinalizedFormViewController.swift
//  Mclytics
//
//  Created by Gunjan Raval on 22/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit
import SwiftyJSON

class SendFinalizedFormViewController: ParentClass,UITableViewDelegate,UITableViewDataSource  {
    fileprivate var headerview:UIView!
    fileprivate var buttonBack: UIButton!
    fileprivate var buttonMenu: UIButton!
    fileprivate var yPosition: Int!
    var lblTitle: String!
    
    fileprivate var tblList: UITableView!
    private var currentPage = 1
    private var totalPage = 1

    var selectedArray = [MainFormModal]()

    fileprivate var buttonSave: CustomButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let listArray = ParentClass.sharedInstance.getDataForKey(strKey: FINALIZED_ARRAY) as? Data {
//            if let decodedArray = NSKeyedUnarchiver.unarchiveObject(with: listArray) as? [MainFormModal] {
//                finalizedListArray = decodedArray
//            }
//        }
        finalizedListArray = ParentClass.sharedInstance.getDataJSON(key: FINALIZED_ARRAY)

        
        loadHeaderView()

        if finalizedListArray.count > 0 {
            self.initTableview()
            
            buttonSave = CustomButton(frame: CGRect(x: X_PADDING , y: SCREEN_HEIGHT -  CUSTOM_BUTTON_HEIGHT - X_PADDING, width: SCREEN_WIDTH - (X_PADDING*2), height: CUSTOM_BUTTON_HEIGHT))
            buttonSave.setTitle("SUBMIT SELECTED", for: .normal)
            buttonSave.setTitleColor(.darkGray, for: .disabled)
            buttonSave.backgroundColor = UIColor.lightGray
            buttonSave.isEnabled = false
            buttonSave.addTarget(self, action: #selector(onSelectedPressed), for: .touchUpInside)
            buttonSave.tag = 99990
            self.view.addSubview(buttonSave)
            
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
        return  finalizedListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FormListCell.self)) as! FormListCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        let formObject = finalizedListArray[indexPath.row]
        
        let dataFoundInselectedArr =  selectedArray.filter { $0.slug == formObject.slug}
        
        if(dataFoundInselectedArr.count > 0){
            cell.btncheckbox.isSelected = true
        }else{
            cell.btncheckbox.isSelected = false
        }
        
        cell.lblFieldName.text = formObject.name
        cell.lblSubFieldName.text = "sulg: \(formObject.slug)"
        let strDate = ParentClass.sharedInstance.dateConvert(date: formObject.created_at)
        cell.lblSubFieldDate.text = "Added on \(strDate)"
        cell.btncheckbox.addTarget(self, action: #selector(onCheckListPressed(sender:)), for: .touchUpInside)

//        cell.btncheckbox.isHidden = true
//        cell.btnValidation.isHidden = false

        return cell
    }
    
    @objc func onCheckListPressed(sender:UIButton)  {
        
        if sender.isSelected {
            if ((selectedArray.count) != 0){
                let tempSlug2 =  self.finalizedListArray[sender.tag].index
                if let object = selectedArray.filter({ $0.index == tempSlug2 }).first {
                    print("found")
                    let index = selectedArray.firstIndex(of: object)
                    selectedArray.remove(at: index!)
                } else {
                    print("not found")
                }
                sender.isSelected = false
            }
        }else{
            let temp = finalizedListArray[sender.tag]
            print(selectedArray.count)
            selectedArray.append(temp)
            sender.isSelected = true
        }
        
        if selectedArray.count >= 1{
            buttonSave.isEnabled = true
            buttonSave.backgroundColor = colorPrimary
        }else{
            buttonSave.setTitleColor(.darkGray, for: .disabled)
            buttonSave.backgroundColor = UIColor.lightGray
            buttonSave.isEnabled = false
        }
    }
     func onDeletePressed(){
        
        for temp in selectedArray {
            let tempSlug2 = temp.index
            if let object = finalizedListArray.filter({ $0.index == tempSlug2 }).first {
                print("found")
                let index = finalizedListArray.firstIndex(of: object)
                finalizedListArray.remove(at: index!)
                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: finalizedListArray)
                ParentClass.sharedInstance.setData(strData: encodedData, strKey: FINALIZED_ARRAY)
            }
        }
        tblList.reloadData()
        selectedArray.removeAll()
        buttonSave.setTitleColor(.darkGray, for: .disabled)
        buttonSave.backgroundColor = UIColor.lightGray
        buttonSave.isEnabled = false
    }
    
    @objc func onSelectedPressed()  {
        var count = selectedArray.count
        for obj in selectedArray{
            DispatchQueue.main.async {
                WebServicesManager.formSubmit(formData: obj.param , fromId: obj.id, andCompletion: { (isSuccess, response) in
                    if isSuccess {
                        if let strMsg = response["message"] as? String {
                            if strMsg != ""{
                                count -= 1
                                if count == 0 {
                                    self.onDeletePressed()
                                    super.showAlert(message: CS.Common.pushdata, type: .error, navBar: false)
                                }
//                                super.showAlert(message: strMsg.htmlToString, type: .error, navBar: false)
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
     }
}
