//
//  TableViewCell.swift
//  人员信息
//
//  Created by appl on 15/6/15.
//  Copyright (c) 2015年 appl. All rights reserved.
//

import UIKit

class workerTableViewCell: UITableViewCell {

    @IBOutlet weak var servantName: UILabel!
    @IBOutlet weak var servantStatus: UILabel!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var workYears: UILabel!
    @IBOutlet weak var servantScore: UILabel!
    @IBOutlet weak var Score: UIImageView!
    @IBOutlet weak var headPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
