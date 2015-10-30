//
//  MyCollection.swift
//  生活网
//
//  Created by Zhang on 15/5/17.
//  Copyright (c) 2015年 Zhang. All rights reserved.
//

import Foundation
import UIKit

class Collection:NSObject{
    var first:String
    var cate:String
    var cost:String
    var staff:String
    var detail:String
    
    
    init(first:String, cate:String,cost:String,staff:String ,detail:String  ) {
        self.first = first
        self.cate = cate
        self.cost  = cost
        self.staff  = staff
        self.detail  = detail
        super.init()
    }
}