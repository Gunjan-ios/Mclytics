//
//  SimpleLabelCell.swift
//  Mclytics
//
//  Created by Krishna  on 21/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit

class SimpleLabelCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lbl.layer.cornerRadius = 4
        lbl.layer.borderWidth = 1
        lbl.layer.borderColor = colorDividerBG_f4.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
