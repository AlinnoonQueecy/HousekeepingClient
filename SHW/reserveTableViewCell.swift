//
//  reserveTableViewCell.swift
//  我的预定
//
//  Created by appl on 15/6/16.
//  Copyright (c) 2015年 appl. All rights reserved.
//

import UIKit

class reserveTableViewCell: UITableViewCell {

    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var orderNo: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var serviceType: UILabel!
    @IBOutlet weak var servantName: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var cancel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
