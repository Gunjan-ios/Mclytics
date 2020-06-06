//
//  FormFieldsVC.swift
//  Mclytics
//
//  Created by Krishna  on 21/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit
import SwiftyJSON

class FormFieldsVC: ParentClass ,UITableViewDelegate,UITableViewDataSource {
    
    
    var lblTitle: String!
    @IBOutlet weak var tblList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        initTableview()
        
        
    }
    
    
    
    @objc func goToBack()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initTableview()  {
        tblList.backgroundColor = .clear
        tblList.estimatedRowHeight = UITableView.automaticDimension
//        tblList.register(SimpleLabelCell.self, forCellReuseIdentifier: "SimpleLabelCell")
        tblList.register(UINib(nibName: "SimpleLabelCell", bundle: nil), forCellReuseIdentifier: "SimpleLabelCell")

        tblList.rowHeight = TABLEVIEW_CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3//self.flistArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SimpleLabelCell.self)) as! SimpleLabelCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        cell.lbl.text = "Krishna"
        return cell
    }
    
}
