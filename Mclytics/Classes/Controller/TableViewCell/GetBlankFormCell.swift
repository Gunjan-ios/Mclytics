//
//  GetBlankFormCell.swift
//  Mclytics
//
//  Created by Gunjan Raval on 16/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit

class GetBlankFormCell: UITableViewCell {
    
    var btncheckbox : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "deselectedCheckbox"), for: .normal)
        btn.setImage(UIImage(named: "selectedCheckboxBlue"), for: .selected)
        btn.contentHorizontalAlignment = .center
        return btn
    }()
    
    var lblFieldName : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()
    
    var lblSubFieldName : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.sizeToFit()
//        label.backgroundColor = UIColor.red
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.white
        
        self.btncheckbox.frame = CGRect (x: SCREEN_WIDTH - Int(SIDE_PANEL_LABEL_CELL_HEIGHT) - 10 , y: 0, width:Int(SIDE_PANEL_LABEL_CELL_HEIGHT) , height: Int(SIDE_PANEL_LABEL_CELL_HEIGHT))
        self.lblFieldName.frame = CGRect(x: X_PADDING, y: 0, width: SCREEN_WIDTH - X_PADDING , height: Int(SIDE_PANEL_LABEL_CELL_HEIGHT/2))
        self.lblSubFieldName.frame = CGRect(x: X_PADDING, y:Int(SIDE_PANEL_LABEL_CELL_HEIGHT/2) - 3, width: SCREEN_WIDTH - X_PADDING, height: Int(SIDE_PANEL_LABEL_CELL_HEIGHT/2))
        
        addSubview(btncheckbox)
        addSubview(lblFieldName)
        addSubview(lblSubFieldName)


        
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
