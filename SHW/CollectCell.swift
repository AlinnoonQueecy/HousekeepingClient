//
//  CollectCell.swift
//  生活网
//
//  Created by Zhang on 15/5/17.
//  Copyright (c) 2015年 Zhang. All rights reserved.
//

import UIKit

class CollectCell: UITableViewCell {
   
    @IBOutlet weak var picture: UIImageView!
     
    @IBOutlet weak var facilitatorName: UILabel!
   
    @IBOutlet weak var itemName: UILabel!

    @IBOutlet weak var servicePay: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
