////
////  reserveViewController.swift
////  我的预定
////
////  Created by appl on 15/6/16.
////  Copyright (c) 2015年 appl. All rights reserved.
////
//import UIKit
//
//class reserveViewController: UIViewController,UIAlertViewDelegate {
//    
//    
//   //var detailItem:Finishinfo?
//    //从上个界面传递的数据
//    var detailItem:DeclaresInfo?
//    var pageHeight = 1300
//    
//    @IBOutlet weak var scrollView: UIScrollView!
//    //声明导航条
//    var navigationBar : UINavigationBar?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//      
//        var width = self.view.frame.width-16
//        println("宽度:\(width)")
//        //实例化导航条
//        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.width, 64))
//        self.view.addSubview(navigationBar!)
//        println("创建导航条详情")
//        onMakeNavitem()
//      
//        
//        scrollView.bounds = self.view.bounds
//        scrollView.frame = CGRectMake(0, 64, self.view.frame.width, self.view.frame.height)
//        
//        scrollView.contentSize=CGSizeMake(self.view.frame.width,self.view.frame.height*5)
//        //scrollView.contentInset = UIEdgeInsetsMake(-64,0,0, 0)
//        scrollView.pagingEnabled = false
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.showsVerticalScrollIndicator = false
//        //设置不可下拉
//        scrollView.bounces = false
//        scrollView.scrollsToTop = false
//        //self.view.addSubview(scrollView)
//        //Label设置
//        println(detailItem)
//         //var  detail:Finishinfo = self.detailItem!
//        var detail:DeclaresInfo = self.detailItem!
//        var orderNo = UILabel(frame: CGRectMake(8, 5, width, 20))
//        orderNo.text = "订单编号:\(detail.orderNo)"
//        orderNo.textColor = UIColor.blackColor()
//        orderNo.font = UIFont.systemFontOfSize(15)
//        //orderNo.backgroundColor = UIColor.redColor()
//        scrollView.addSubview(orderNo)
//        //取消订单
////        var  CancelButton = UIButton(frame: CGRectMake(width-70, 5,60, 25))
////        CancelButton.setTitle("取消订单", forState: UIControlState.Normal)
////        CancelButton.titleLabel?.font = UIFont.systemFontOfSize(13)
////        CancelButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
////        CancelButton.backgroundColor = UIColor.orangeColor()
////        CancelButton.layer.cornerRadius = 5
////        CancelButton.showsTouchWhenHighlighted = true
////        if detail.orderStatus == "已预约"{
////            CancelButton.hidden = false
////        }else {
////            CancelButton.hidden = true
////        }
////        
////        CancelButton.addTarget(self, action: "Cancel:", forControlEvents: UIControlEvents.TouchUpInside)
////        scrollView.addSubview(CancelButton)
//
//        var orderStatus = UILabel(frame: CGRectMake(8, 25, width, 20))
//        orderStatus.text = "订单状态:\(detail.orderStatus)"
//        orderStatus.textColor = UIColor.orangeColor()
//        orderStatus.font = UIFont.systemFontOfSize(15)
//        scrollView.addSubview(orderStatus)
//        
////        var button8C = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
////        var lable1 = UILabel(frame: CGRectMake(0, 45,width+16, 7))
////        lable1.backgroundColor = button8C
////        scrollView.addSubview(lable1)
//        
//        var customerID = UILabel(frame: CGRectMake(8,55 , width, 20))
//        customerID.text = "客户账号:\(detail.customerID)"
//        customerID.textColor = UIColor.blackColor()
//        customerID.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(customerID)
//        
//        //            let levelImg = UIImageView(frame: CGRectMake(75, 41, 80, 16))
//        //            levelImg.image = imageForRank(Detail1.levelImg)
//        //            scrollView.addSubview(levelImg)
//        
//        var customerName = UILabel(frame: CGRectMake(8, 75, width, 20))
//        customerName.text = "客户姓名:\(detail.customerName)"
//        customerName.textColor = UIColor.blackColor()
//        customerName.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(customerName)
//        
//        //            let scoreImg = UIImageView(frame: CGRectMake(75, 60, 80, 16))
//        //            scoreImg.image = imageForRank(Detail2.scoreImg)
//        //            scrollView.addSubview(scoreImg)
//        
//        
//        var facilitatorID = UILabel(frame: CGRectMake(8, 95, width , 20))
//        facilitatorID.text = "商家账号:\(detail.facilitatorID)"
//        facilitatorID.textColor = UIColor.blackColor()
//        facilitatorID.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(facilitatorID )
//        
//        var facilitatorName = UILabel(frame: CGRectMake(8, 115, width, 20))
//        facilitatorName.text = "商家名称:\(detail.facilitatorName)"
//        facilitatorName.textColor = UIColor.blackColor()
//        facilitatorName.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(facilitatorName )
//        
//        var servantName = UILabel(frame: CGRectMake(8, 135, width, 20))
//        servantName.text = "服务人员:\(detail.servantName)"
//        servantName.textColor = UIColor.blackColor()
//        servantName.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(servantName)
//        
//        var servantID = UILabel(frame: CGRectMake(8, 155, width, 20))
//        servantID.text = "人员工号:\(detail.servantID)"
//        servantID.textColor = UIColor.blackColor()
//        servantID.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(servantID)
//        
//        var lable2 = UILabel(frame: CGRectMake(0, 175,width+16, 7))
//        lable2.backgroundColor = button8C
//        scrollView.addSubview(lable2)
//        
//        var serviceType = UILabel(frame: CGRectMake(8, 185, width, 20))
//        serviceType.text = "服务类型:\(detail.serviceType)"
//        serviceType.textColor = UIColor.blackColor()
//        serviceType.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(serviceType)
//        
//        var serviceContent = UILabel(frame: CGRectMake(8, 205, width, 40))
//        serviceContent.text = "服务内容:\(detail.serviceContent)"
//        serviceContent.numberOfLines = 0
//        ////            serviceContent.lineBreakMode = .ByTruncatingMiddle//折行方式
//        //            serviceContent.adjustsFontSizeToFitWidth = true //字体适应label大小
//        //            serviceContent.baselineAdjustment = UIBaselineAdjustment.AlignCenters\\文本基线位置
//        serviceContent.baselineAdjustment = .None
//        serviceContent.textColor = UIColor.blackColor()
//        serviceContent.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(serviceContent)
//        
//        
//        var itemName = UILabel(frame: CGRectMake(8, 245, width, 20))
//        itemName.text = "项目名称:\(detail.itemName)"
//        itemName.textColor = UIColor.blackColor()
//        itemName.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(itemName)
//        
//        var itemID = UILabel(frame: CGRectMake(8, 265, width, 20))
//        itemID.text = "项目ID:\(detail.itemID)"
//        itemID.textColor = UIColor.blackColor()
//        itemID.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(itemID)
//        
//        var lable3 = UILabel(frame: CGRectMake(0, 285,width+16, 7))
//        lable3.backgroundColor = button8C
//        scrollView.addSubview(lable3)
//        
//        var orderTime = UILabel(frame: CGRectMake(8,295, width, 20))
//        orderTime.text = "订单时间:\(detail.orderTime)"
//        orderTime.textColor = UIColor.blackColor()
//        orderTime.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(orderTime)
//        
//        var confirmTime = UILabel(frame: CGRectMake(8, 315, width, 20))
//        confirmTime.text = "确定时间:\(detail.confirmTime)"
//        confirmTime.textColor = UIColor.blackColor()
//        confirmTime.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(confirmTime)
//        //            var introheight = CGFloat(200)
//        let startTime = UILabel(frame:CGRectMake(8, 335,width,20))
//        startTime.text = "起始时间:\(detail.startTime)"
//        startTime.textColor = UIColor.blackColor()
//        startTime.font = UIFont.systemFontOfSize(14)
//        //            startTime.numberOfLines = 0
//        scrollView.addSubview(startTime)
//        
//        var overTime = UILabel(frame: CGRectMake(8, 355, width, 20))
//        overTime.text = "结束时间:\(detail.overTime)"
//        overTime.textColor = UIColor.blackColor()
//        overTime.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(overTime)
//        
//        
//        var lable4 = UILabel(frame: CGRectMake(0, 375,width+16, 7))
//        lable4.backgroundColor = button8C
//        scrollView.addSubview(lable4)
//        
//        var servicePrice = UILabel(frame: CGRectMake(8, 385, width, 20))
//        if  detail.servicePrice != 0 {
//        servicePrice.text = "服务费用:\(detail.servicePrice)元"
//        }else{
//            servicePrice.text = "服务费用:待确定"
//            
//        }
//        servicePrice.textColor = UIColor.orangeColor()
//        servicePrice.font = UIFont.systemFontOfSize(15)
//        scrollView.addSubview(servicePrice)
//        
//        var paidAmount = UILabel(frame: CGRectMake(8, 405, width, 20))
//        paidAmount.text = "已付金额:\(detail.paidAmount)元"
//        paidAmount.textColor = UIColor.orangeColor()
//        paidAmount.font = UIFont.systemFontOfSize(15)
//        scrollView.addSubview(paidAmount)
//        
//        var lable5 = UILabel(frame: CGRectMake(0, 425,width+16, 7))
//        lable5.backgroundColor = button8C
//        scrollView.addSubview(lable5)
//        
//        var customerEvaluate = UILabel(frame: CGRectMake(8, 435, width, 40))
//        customerEvaluate.text = "订单评价:\(detail.customerEvaluate)"
//        customerEvaluate.textColor = UIColor.blackColor()
//        customerEvaluate.font = UIFont.systemFontOfSize(14)
//        customerEvaluate.numberOfLines = 0
//        customerEvaluate.baselineAdjustment = .AlignBaselines
//        scrollView.addSubview(customerEvaluate)
//        
//        var remarks = UILabel(frame: CGRectMake(8, 475, width, 40))
//        remarks.text = "备注:\(detail.remarks)"
//        remarks.textColor = UIColor.blackColor()
//        remarks.font = UIFont.systemFontOfSize(14)
//        remarks.numberOfLines = 0
//        scrollView.addSubview(remarks)
//        
//        var payButton = UIButton(frame: CGRectMake((self.view.frame.width-250)/2, 530, 250, 30))
//        payButton.setTitle("立即支付", forState: UIControlState.Normal)
//        payButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        payButton.backgroundColor = UIColor.orangeColor()
//        payButton.layer.cornerRadius = 5
//        payButton.showsTouchWhenHighlighted = true
//        if detail.orderStatus == "待付款"{
//            payButton.hidden = false
//        }else {
//            payButton.hidden = true
//        }
//        payButton.addTarget(self, action: "Pay:", forControlEvents: UIControlEvents.TouchUpInside)
//        scrollView.addSubview(payButton)
//        // configureView()
//        scrollView.contentSize=CGSizeMake(self.view.frame.width,570+64)
//        
//        
//        
//    }
//    //支付函数
//    func Pay(payButton:UIButton){
//        self.performSegueWithIdentifier("toPay", sender: self)
//    }
//    //取消预约
//    /*func Cancel(CancelButton:UIButton){
//        
//        var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileServiceOrderAction?operation=_cancelOrder")
//        
//        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
//        
//        request.HTTPMethod = "POST"
//        var id:Int = detailItem!.id
//        var param:String = "{\"id\":\"\(id)\"}"
//        println(param)
//        var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
//        request.HTTPBody = data;
//        var response:NSURLResponse?
//        var error:NSError?
//        var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
//        if (error != nil)
//        {
//            println(error?.code)
//            println(error?.description)
//        }
//        else
//        {
//            var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
//            println("jsonString")
//            println(jsonString)
//            
//        }
//        
//        let dict:AnyObject? = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
//        var dic = dict as! NSDictionary
//        let serverResponse = dic.objectForKey("serverResponse") as? String
//        
//        if serverResponse == "Success"{
//            //self.performSegueWithIdentifier("LoginTo", sender: self)
//            let alert =  UIAlertView(title: "取消成功", message: "", delegate: self, cancelButtonTitle: "确定")
//            alert.show()
//         //self.dismissViewControllerAnimated(true, completion: nil)
//            
//        }
//        
//        if serverResponse == "Failed"{
//            
//            let alert =  UIAlertView(title: "取消失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
//            alert.show()
//        }
//        
//
////        self.dismissViewControllerAnimated(true, completion: nil)
//        
//        
//    }
//    func  alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
//          self.dismissViewControllerAnimated(true, completion: nil)
//    }*/
//    override func viewDidLayoutSubviews() {
//        scrollView.frame = CGRectMake(0, 64, self.view.frame.width, self.view.frame.height)
//    }
//    
//    //导航条详情
//    func reply (){
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func onMakeNavitem() -> UINavigationItem{
//        println("创建导航条step1")
//        //创建一个导航项
//        var navigationItem = UINavigationItem()
//        //创建左边按钮
//        var leftButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "reply")
//        //var leftButton =  UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Bordered, target: self, action: "reply")
//        //导航栏的标题
//        navigationItem.title = "订单详情"
//        //设置导航栏左边按钮
//        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
//        
//        navigationBar?.pushNavigationItem(navigationItem, animated: true)
//        
//        
//        return navigationItem
//    }
//    
//
//    
//    
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier! == "toPay" {
//            let controller = segue.destinationViewController as! PayVC
//            var  object = detailItem
//            controller.PayData = object
//         
//            
//            
//            
//        }
//    }
// 
//}
