//
//  CollectCell.swift
//  生活网
//
//  Created by Zhang on 15/5/17.
//  Copyright (c) 2015年 Zhang. All rights reserved.
//

import UIKit

class CollectCell: UITableViewCell {
    @IBOutlet weak var firstLabel:UILabel!
    @IBOutlet weak var cateLabel:UILabel!
    @IBOutlet weak var costLabel:UILabel!
    @IBOutlet weak var detailLabel:UILabel!
    @IBOutlet weak var staffLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
