//
//  DetailVC.swift
//  SHW
//
//  Created by Zhang on 15/6/11.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    
     var facilitatorName: UILabel!
      var facilitatorID: UILabel!
     var level: UILabel!
     var levelImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scrollView: UIScrollView = UIScrollView(frame : CGRectMake(0, 0, 300, 400))
        //设置背景
      scrollView.backgroundColor = UIColor.grayColor()
        //添加到视图上
        self.view.addSubview(scrollView)
        //创建3个视图，添加到Scrollview上
        let view1:UIView = UIView(frame:CGRectMake(0, 0, 300, 400))
        view1.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(view1)
        
        let view2:UIView = UIView(frame:CGRectMake(300, 0, 300, 400))
        view1.backgroundColor = UIColor.redColor()
        scrollView.addSubview(view2)
        
        let view3:UIView = UIView(frame:CGRectMake(600, 0, 300, 400))
        view1.backgroundColor = UIColor.blueColor()
        scrollView.addSubview(view3)
        //设置scrollview的容器大小
        scrollView.contentSize = CGSizeMake(300*3, 400)
        //设置滚动风格
        scrollView.indicatorStyle = UIScrollViewIndicatorStyle.White
        //设置水平滚动条是否可见
        scrollView.showsHorizontalScrollIndicator = false
        //设置垂直方向滚动条是否可见
        scrollView.showsVerticalScrollIndicator = true  
        //设置成翻页滚动
//        scrollView.pagingEnabled = true
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
