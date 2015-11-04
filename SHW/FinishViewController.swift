//
//  ViewController.swift/Users/zhang/Desktop/ Learn IOS/SHW/SHW/FinishTVCell.swift
//  未完成订单
//
//  Created by appl on 15/6/14.
//  Copyright (c) 2015年 appl. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController,UIAlertViewDelegate{

 
    var pageHeight = 1300
    var detailData:Finishinfo!
    var OrderData:Finishinfo!
    var EvaluationButton = UIButton()
     var Complete = UIButton()
    @IBOutlet weak var scrollView: UIScrollView!
//    var alert = UIAlertView()
    //声明导航条
    var navigationBar : UINavigationBar?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("qqqqqqqqqqqqqqqqqqqq")
        let width = self.view.frame.width-16
         print("宽度:\(width)")
        
        //实例化导航条
        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.width, 64))
        navigationBar?.barTintColor = UIColor.orangeColor()
        navigationBar?.translucent = false
        navigationBar?.barStyle = UIBarStyle.Default
        let navigationTitleAttribute: NSDictionary = NSDictionary(objectsAndKeys: UIColor.whiteColor(), NSForegroundColorAttributeName)
        navigationBar?.titleTextAttributes =  navigationTitleAttribute as [NSObject: AnyObject]
        self.view.addSubview(navigationBar!)
        print("创建导航条详情")
        onMakeNavitem()
        
            //detailItem = getOrderData(detailData.id)
           OrderData =  getOrderData(detailData.orderNo)
            //var scrollView = UIScrollView()
            scrollView.bounds = self.view.bounds
            scrollView.frame = CGRectMake(0, 64, self.view.frame.width, self.view.frame.height)
            
            scrollView.contentSize=CGSizeMake(self.view.frame.width,self.view.frame.height*5)
//            scrollView.contentInset = UIEdgeInsetsMake(-64,0,0, 0)
            scrollView.pagingEnabled = false
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            //设置不可下拉
            scrollView.bounces = false
            scrollView.scrollsToTop = false
            //self.view.addSubview(scrollView)
            //Label设置
            print("wwwwwwwwwwww")
            let  detail:Finishinfo = self.OrderData!
            let orderNo = UILabel(frame: CGRectMake(8, 5, width, 20))
            orderNo.text = "订单编号:\(detail.orderNo)"
            orderNo.textColor = UIColor.blackColor()
            orderNo.font = UIFont.systemFontOfSize(15)
            //orderNo.backgroundColor = UIColor.redColor()
            scrollView.addSubview(orderNo)
        
        
            let orderStatus = UILabel(frame: CGRectMake(8, 20+5, width, 20))
            orderStatus.text = "订单状态:\(detail.orderStatus)"
            orderStatus.textColor = UIColor.orangeColor()
            orderStatus.font = UIFont.systemFontOfSize(15)
            scrollView.addSubview(orderStatus)
        
            let button8C = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
            let lable1 = UILabel(frame: CGRectMake(0, 45,width+16, 7))
            lable1.backgroundColor = button8C
            scrollView.addSubview(lable1)
                
            let customerID = UILabel(frame: CGRectMake(8,20*2+15 , width, 20))
            customerID.text = "客户账号:\(detail.customerID)"
            customerID.textColor = UIColor.blackColor()
            customerID.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(customerID)
            
//            let levelImg = UIImageView(frame: CGRectMake(75, 41, 80, 16))
//            levelImg.image = imageForRank(Detail1.levelImg)
//            scrollView.addSubview(levelImg)
            
            let customerName = UILabel(frame: CGRectMake(8, 20*3+15, width, 20))
            customerName.text = "客户姓名:\(detail.customerName)"
            customerName.textColor = UIColor.blackColor()
            customerName.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(customerName)
            
//            let scoreImg = UIImageView(frame: CGRectMake(75, 60, 80, 16))
//            scoreImg.image = imageForRank(Detail2.scoreImg)
//            scrollView.addSubview(scoreImg)
            
        
//            var facilitatorID = UILabel(frame: CGRectMake(8, 95, width , 20))
//            facilitatorID.text = "商家账号:\(detail.facilitatorID)"
//            facilitatorID.textColor = UIColor.blackColor()
//            facilitatorID.font = UIFont.systemFontOfSize(14)
//            scrollView.addSubview(facilitatorID )
//
//            var facilitatorName = UILabel(frame: CGRectMake(8, 115, width, 20))
//            facilitatorName.text = "商家名称:\(detail.facilitatorName)"
//            facilitatorName.textColor = UIColor.blackColor()
//            facilitatorName.font = UIFont.systemFontOfSize(14)
//            scrollView.addSubview(facilitatorName )
        
            let servantName = UILabel(frame: CGRectMake(8, 20*4+15, width, 20))
            servantName.text = "服务人员:\(detail.servantName)"
            servantName.textColor = UIColor.blackColor()
            servantName.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(servantName)

            let servantID = UILabel(frame: CGRectMake(8, 20*5+15, width, 20))
            servantID.text = "人员工号:\(detail.servantID)"
            servantID.textColor = UIColor.blackColor()
            servantID.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(servantID)
        
             let lable2 = UILabel(frame: CGRectMake(0, 20*6+15,width+16, 7))
             lable2.backgroundColor = button8C
             scrollView.addSubview(lable2)

            let serviceType = UILabel(frame: CGRectMake(8, 20*6+25, width, 20))
            serviceType.text = "服务类型:\(detail.serviceType)"
            serviceType.textColor = UIColor.blackColor()
            serviceType.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(serviceType)

            let serviceContent = UILabel(frame: CGRectMake(8, 20*7+25, width, 40))
            serviceContent.text = "服务内容:\(detail.serviceContent)"
            serviceContent.numberOfLines = 0
////            serviceContent.lineBreakMode = .ByTruncatingMiddle//折行方式
//            serviceContent.adjustsFontSizeToFitWidth = true //字体适应label大小
//            serviceContent.baselineAdjustment = UIBaselineAdjustment.AlignCenters\\文本基线位置
            serviceContent.baselineAdjustment = .None
            serviceContent.textColor = UIColor.blackColor()
            serviceContent.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(serviceContent)

        let contactPhone = UILabel(frame: CGRectMake(8, 20*9+25, width, 20))
        contactPhone.text = "联系电话:\(detail.contactPhone)"
        contactPhone.textColor = UIColor.blackColor()
        contactPhone.font = UIFont.systemFontOfSize(14)
        contactPhone.numberOfLines = 0
        contactPhone.baselineAdjustment = .AlignBaselines
        scrollView.addSubview(contactPhone)
        let contactAddress = UILabel(frame: CGRectMake(8, 20*10+25, width, 40))
        contactAddress.text = "联系地址:\(detail.contactAddress)"
        contactAddress.textColor = UIColor.blackColor()
        contactAddress.font = UIFont.systemFontOfSize(14)
        contactAddress.numberOfLines = 0
        contactAddress.baselineAdjustment = .AlignBaselines
        scrollView.addSubview(contactAddress)
   

           let lable3 = UILabel(frame: CGRectMake(0, 20*12+25,width+16, 7))
           lable3.backgroundColor = button8C
           //lable3.backgroundColor = UIColor.whiteColor()
           scrollView.addSubview(lable3)
        
            let orderTime = UILabel(frame: CGRectMake(8,20*12+35, width, 20))
            orderTime.text = "订单时间:\(detail.orderTime)"
            orderTime.textColor = UIColor.blackColor()
            orderTime.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(orderTime)
            
            let confirmTime = UILabel(frame: CGRectMake(8, 20*13+35, width, 20))
            confirmTime.text = "确认时间:\(detail.confirmTime)"
            confirmTime.textColor = UIColor.blackColor()
            confirmTime.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(confirmTime)
       
        
            let commentTime = UILabel(frame: CGRectMake(8, 20*14+35, width, 20))
            commentTime.text = "评价时间:\(detail.commentTime)"
            commentTime.textColor = UIColor.blackColor()
            commentTime.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(commentTime)
        
        let H = CGFloat(20*15+35)
        let lable4 = UILabel(frame: CGRectMake(0, H,width+16, 7))
        lable4.backgroundColor = button8C
        scrollView.addSubview(lable4)
        
        
            let payTime = UILabel(frame:CGRectMake(8, H+10 ,width,20))
              payTime.text = "付款时间:\(detail.payTime)"
              payTime.textColor = UIColor.blackColor()
              payTime.font = UIFont.systemFontOfSize(14)
        //            startTime.numberOfLines = 0
              scrollView.addSubview(payTime)

            let servicePrice = UILabel(frame: CGRectMake(8, H+30, width, 20))
            servicePrice.text = "服务费用:\(detail.servicePrice)元"
            servicePrice.textColor = UIColor.orangeColor()
            servicePrice.font = UIFont.systemFontOfSize(15)
            scrollView.addSubview(servicePrice)

            let paidAmount = UILabel(frame: CGRectMake(8, H+50, width, 20))
            paidAmount.text = "已付金额:\(detail.paidAmount)元"
            paidAmount.textColor = UIColor.orangeColor()
            paidAmount.font = UIFont.systemFontOfSize(15)
            scrollView.addSubview(paidAmount)
        
        let payType = UILabel(frame: CGRectMake(8, H+70, width, 40))
        payType.text = "付款类型:\(detail.payType)"
        payType.textColor = UIColor.blackColor()
        payType.font = UIFont.systemFontOfSize(14)
        payType.numberOfLines = 0
        payType.baselineAdjustment = .AlignBaselines
        scrollView.addSubview(payType)

        
        let lable5 = UILabel(frame: CGRectMake(0, H+70,width+16, 7))
        lable5.backgroundColor = button8C
        scrollView.addSubview(lable5)

        

            let remarks = UILabel(frame: CGRectMake(8, H+100, width, 60))
            remarks.text = "备注:\(detail.remarks)"
            remarks.textColor = UIColor.blackColor()
            remarks.font = UIFont.systemFontOfSize(14)
            remarks.numberOfLines = 0
            scrollView.addSubview(remarks)
        
        
        var  X = self.view.frame.width/2

        let	confirmButton = UIButton(frame: CGRectMake((X - 100)/2, 530, 100, 30))
        confirmButton.setTitle("接受该人员", forState: UIControlState.Normal)
        confirmButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        confirmButton.backgroundColor = UIColor.orangeColor()
        confirmButton.layer.cornerRadius = 5
        confirmButton.showsTouchWhenHighlighted = true
        
        let	rejectButton = UIButton(frame: CGRectMake((X - 100)/2 + X, 530, 100, 30))
        rejectButton.setTitle("拒绝该人员", forState: UIControlState.Normal)
        rejectButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        rejectButton.backgroundColor = UIColor.orangeColor()
        rejectButton.layer.cornerRadius = 5
        rejectButton.showsTouchWhenHighlighted = true

        if detail.orderStatus == "待确认"{
            confirmButton.hidden = false
            confirmButton.enabled = true
            rejectButton.hidden = false
            rejectButton.enabled = true
        }else {
            confirmButton.enabled = false
            confirmButton.hidden = true
            rejectButton.enabled = false
            rejectButton.hidden = true
        }
        confirmButton.addTarget(self, action: "Confirm:", forControlEvents: UIControlEvents.TouchUpInside)
        scrollView.addSubview(confirmButton)
        rejectButton.addTarget(self, action: "Reject:", forControlEvents: UIControlEvents.TouchUpInside)
        scrollView.addSubview(rejectButton)

        
        
        let payButton = UIButton(frame: CGRectMake((self.view.frame.width-250)/2, 530, 250, 30))
        payButton.setTitle("立即支付", forState: UIControlState.Normal)
        payButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        payButton.backgroundColor = UIColor.orangeColor()
        payButton.layer.cornerRadius = 5
        payButton.showsTouchWhenHighlighted = true
        if detail.orderStatus == "待付款"{
            payButton.hidden = false
            payButton.enabled = true
        }else {
            payButton.enabled = false
            payButton.hidden = true
        }
        payButton.addTarget(self, action: "Pay:", forControlEvents: UIControlEvents.TouchUpInside)
        scrollView.addSubview(payButton)

        
        

        EvaluationButton = UIButton(frame: CGRectMake((self.view.frame.width-250)/2, 530, 250, 30))
        EvaluationButton.setTitle("评价订单", forState: UIControlState.Normal)
        EvaluationButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        EvaluationButton.backgroundColor = UIColor.orangeColor()
        EvaluationButton.layer.cornerRadius = 5
        EvaluationButton.showsTouchWhenHighlighted = true
 
        
       
        
        if detail.orderStatus == "服务完成" && OrderData.commentTime == ""{
            
     
                EvaluationButton.hidden = false
                EvaluationButton.enabled = true
            
          
 
        }else {
             EvaluationButton.hidden = true
             EvaluationButton.enabled = false
 
        }
        EvaluationButton.addTarget(self, action: "Evaluation:", forControlEvents: UIControlEvents.TouchUpInside)
        scrollView.addSubview(EvaluationButton)
        
        
        Complete = UIButton(frame: CGRectMake((self.view.frame.width-250)/2, 530, 250, 30))
        Complete.setTitle("确认完成", forState: UIControlState.Normal)
        Complete.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        Complete.backgroundColor = UIColor.orangeColor()
        Complete.layer.cornerRadius = 5
        Complete.showsTouchWhenHighlighted = true
        if detail.orderStatus == "服务中"{
            Complete.hidden = false
            Complete.enabled = true
        }else {
            Complete.enabled = false
            Complete.hidden = true
        }
        Complete.addTarget(self, action: "Complete:", forControlEvents: UIControlEvents.TouchUpInside)
        scrollView.addSubview(Complete)

//        refundButton.setTitle("申请退款", forState: UIControlState.Normal)
//        refundButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        refundButton.backgroundColor = UIColor.orangeColor()
//        refundButton.layer.cornerRadius = 5
//        refundButton.showsTouchWhenHighlighted = true
        
        
//        var alterRefund = UIButton(frame: CGRectMake((self.view.frame.width-250)/2, 530, 250, 30))
//        alterRefund.setTitle("修改退款", forState: UIControlState.Normal)
//        alterRefund.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        alterRefund.backgroundColor = UIColor.orangeColor()
//        alterRefund.layer.cornerRadius = 5
//        alterRefund.showsTouchWhenHighlighted = true
        
//        if  detail.orderStatus == "申请退款"{
//            alterRefund.hidden = false
//            alterRefund.enabled = true
//          }else {
//            alterRefund.hidden = true
//            alterRefund.enabled = false
//           }
//        var CheckRefund = UIButton(frame: CGRectMake((self.view.frame.width-250)/2, 530, 250, 30))
//        CheckRefund.setTitle("查看退款详情", forState: UIControlState.Normal)
//        CheckRefund.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        CheckRefund.backgroundColor = UIColor.orangeColor()
//        CheckRefund.layer.cornerRadius = 5
//        CheckRefund.showsTouchWhenHighlighted = true
//        
//        
//        if  detail.orderStatus == "退款中" || detail.orderStatus == "已退款"{
//            CheckRefund.hidden = false
//            CheckRefund.enabled = true
//        }else {
//            CheckRefund.hidden = true
//            CheckRefund.enabled = false
//        }
//
//        
        
        
        
//        refundButton.addTarget(self, action: "refund:", forControlEvents: UIControlEvents.TouchUpInside)
//        alterRefund.addTarget(self, action: "ralterRefund:", forControlEvents: UIControlEvents.TouchUpInside)
//        CheckRefund.addTarget(self, action: "CheckRefund:", forControlEvents: UIControlEvents.TouchUpInside)

       // scrollView.addSubview(refundButton)
//        scrollView.addSubview(alterRefund)
//
//         scrollView.addSubview(CheckRefund)
    
         scrollView.contentSize=CGSizeMake(self.view.frame.width,570+64)
        

        
    }
    func Confirm(confirmButton:UIButton){
        let response = confirmServant (OrderData.orderNo)
        if response == "Success"{
            
            let alert =  UIAlertView(title: "", message: "已接受", delegate: self, cancelButtonTitle: "确定")
            
            alert.tag = 1
            alert.show()
            
        }else {
            let alert =  UIAlertView(title: "", message: "接受失败，请重试!", delegate: self, cancelButtonTitle: "确定")
            
            alert.show()
        }
        
    }
    func Reject(rejectButton:UIButton){
        let response = RefuseServant(OrderData.orderNo)
        if response == "Success"{
            
            let alert =  UIAlertView(title: "", message: "已拒绝", delegate: self, cancelButtonTitle: "确定")
            
            alert.tag = 1
            alert.show()
            
        }else {
            let alert =  UIAlertView(title: "", message: "拒绝失败，请重试!", delegate: self, cancelButtonTitle: "确定")
            
            alert.show()
        }
        
    }

    //支付函数
    func Pay(payButton:UIButton){
        self.performSegueWithIdentifier("toPay", sender: self)
    }

    //评价函数
    func Evaluation(EvaluationButton:UIButton){
        self.performSegueWithIdentifier("toEvaluate", sender: self)
    }
    //确认完成的函数
    func Complete(Complete:UIButton){
        let response = vetifyFinish(OrderData.orderNo)
        if response == "Success"{
          
            let alert =  UIAlertView(title: "", message: "确认成功", delegate: self, cancelButtonTitle: "确定")
 
            alert.tag = 1
            alert.show()
            
        }else {
            let alert =  UIAlertView(title: "", message: "确认失败，请重试!", delegate: self, cancelButtonTitle: "确定")
          
            alert.show()
        }
        
    }

//    //退款函数
//    func refund(refundButton:UIButton){
//        self.performSegueWithIdentifier("toRefund", sender: self)
//    }
//    //修改退款
//    func ralterRefund(alterRefund:UIButton){
//        self.performSegueWithIdentifier("alterRefund", sender: self)
//    }
//  //查看退款详情
//    func CheckRefund(alterRefund:UIButton){
//        self.performSegueWithIdentifier("toDetail", sender: self)
//    }
    
    
    
    override func viewDidLayoutSubviews() {
        scrollView.frame = CGRectMake(0, 64, self.view.frame.width, self.view.frame.height)
        }
    
    //导航条详情
    func reply (){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func  alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if (alertView.tag == 1) {
            print("成功")
            Complete.hidden = true
            Complete.enabled = false
            //        let sb = UIStoryboard(name: "Main", bundle: nil)
            //        let vc = sb.instantiateViewControllerWithIdentifier("finish") as! UIViewController
            //        self.presentViewController(vc, animated: true, completion: nil)
        }
        //        else{
        //            println("失败")
        ////        self.performSegueWithIdentifier("back", sender: self)
        //        self.dismissViewControllerAnimated(true, completion: nil)
        //        }
    }

    func onMakeNavitem() -> UINavigationItem{
        print("创建导航条step1")
        //创建一个导航项
        let navigationItem = UINavigationItem()
        //创建左边按钮
        let leftButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "reply")
        //var leftButton =  UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Bordered, target: self, action: "reply")
        //导航栏的标题
        navigationItem.title = "订单详情"
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        
        navigationBar?.pushNavigationItem(navigationItem, animated: true)
        
        
        return navigationItem
    }
    
    
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier! == "toPay" {
            let controller = segue.destinationViewController as! PayVC
            let  object = detailData
            controller.PayData = object
            
        }else if segue.identifier! == "toEvaluate" {
            let controller = segue.destinationViewController as! EvaluateVC
            let  object = detailData
            controller.EvaluateData = object
            
        }
           // else if segue.identifier! == "toRefund" {
//            let controller = segue.destinationViewController as! RefundVC
//            var  object = detailItem
//            controller.Data = object
//
//        }else if segue.identifier! == "alterRefund" {
//            let controller = segue.destinationViewController as! AlterRefund
//            var  object = detailItem
//            controller.Data = object
//            
//        }else if segue.identifier! == "toDetail" {
//            let controller = segue.destinationViewController as! RefundDetailVC
//            var  object = detailItem
//            controller.Data = object
//            
//        }



    }

    override func  viewWillAppear(animated: Bool) {
    
        OrderData =  getOrderData(detailData.orderNo)
        
        if OrderData.orderStatus == "服务完成" && OrderData.commentTime == ""{
            
            
            EvaluationButton.hidden = false
            EvaluationButton.enabled = true
            
            
            
        }else {
            EvaluationButton.hidden = true
            EvaluationButton.enabled = false
            
        }

        
    }
    
 
}