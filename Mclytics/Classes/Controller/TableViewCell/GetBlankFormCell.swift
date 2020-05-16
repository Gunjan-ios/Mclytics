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
        btn.setImage(UIImage(named: "roundCheckBoxOutlineBlank24Px1"), for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.isUserInteractionEnabled = false
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
        
        return label
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.white
        
        self.lblFieldName.frame = CGRect(x: X_PADDING, y: 3, width: SCREEN_WIDTH - X_PADDING , height: 22)
        self.lblSubFieldName.frame = CGRect(x: X_PADDING, y:22, width: SCREEN_WIDTH - X_PADDING, height: 22)
//        addSubview(btncheckbox)
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
