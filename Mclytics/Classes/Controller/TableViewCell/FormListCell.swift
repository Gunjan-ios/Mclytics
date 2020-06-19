//
//  FormListCell.swift
//  Mclytics
//
//  Created by Gunjan Raval on 19/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit

class FormListCell: UITableViewCell {
    
    var btncheckbox : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "deselectedCheckbox"), for: .normal)
        btn.setImage(UIImage(named: "selectedCheckboxBlue"), for: .selected)
        btn.contentHorizontalAlignment = .center
        return btn
    }()
    
    var btnValidation : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "selectedCheckboxBlue"), for: .normal)
//        btn.setImage(UIImage(named: "selectedCheckboxBlue"), for: .selected)
        btn.contentHorizontalAlignment = .center
        btn.setTitle("Validated", for: .normal)
        btn.setTitleColor(blueTextColor, for: .normal)
        return btn
    }()

    var lblFieldName : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
//        label.backgroundColor = UIColor.gray
        return label
    }()
    
    var lblSubFieldName : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.sizeToFit()
//                label.backgroundColor = UIColor.red
        return label
    }()
    
    var lblSubFieldDate : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = colorPrimary
        label.sizeToFit()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.white
        
        self.btncheckbox.frame = CGRect (x: SCREEN_WIDTH - Int(TABLEVIEW_CELL_HEIGHT) - 10 , y: 0, width:Int(TABLEVIEW_CELL_HEIGHT) , height: Int(TABLEVIEW_CELL_HEIGHT))
        self.lblFieldName.frame = CGRect(x: X_PADDING, y: 0, width: SCREEN_WIDTH - X_PADDING , height: Int(TABLEVIEW_CELL_HEIGHT/3))
        self.lblSubFieldName.frame = CGRect(x: X_PADDING, y:Int(TABLEVIEW_CELL_HEIGHT/3 - 3) , width: SCREEN_WIDTH - X_PADDING, height: Int(TABLEVIEW_CELL_HEIGHT/3))
        self.lblSubFieldDate.frame = CGRect(x: X_PADDING, y:Int(TABLEVIEW_CELL_HEIGHT/3)*2 - 6 , width: SCREEN_WIDTH - X_PADDING - 120, height: Int(TABLEVIEW_CELL_HEIGHT/3))
        self.btnValidation.frame = CGRect (x: SCREEN_WIDTH - 120 - 10 , y: Int(TABLEVIEW_CELL_HEIGHT) - 25 , width: 120, height: 25)
        self.btnValidation.isHidden = true
        addSubview(btncheckbox)
        addSubview(lblFieldName)
        addSubview(lblSubFieldName)
        addSubview(lblSubFieldDate)
        addSubview(btnValidation)


        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
