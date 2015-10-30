////
////  RefundDetailVC.swift
////  SHW
////
////  Created by Zhang on 15/9/18.
////  Copyright (c) 2015年 star. All rights reserved.
////
//
//import UIKit
//
//class RefundDetailVC: UIViewController {
//    
//    //声明导航条
//    var navigationBar : UINavigationBar?
//    //接收上个界面传递的数据
//    var Data:Finishinfo!
//    //退款信息
//    var refundData:RefundInfo!
//    var height = CGFloat()
//    var width = CGFloat()
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        width = self.view.frame.width
//        height = self.view.frame.height
//        
//        //实例化导航条
//        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.width, 64))
//        self.view.addSubview(navigationBar!)
//        println("创建导航条详情")
//        onMakeNavitem()
//        
//         refundData = RefundOrderDetail(Data.orderNo)
//        
//        
//        var h = CGFloat(70)
//        var orderNo = UILabel(frame: CGRectMake(8, h, width, 20))
//        orderNo.text = "订单编号:\(refundData.orderNo)"
//        orderNo.textColor = UIColor.blackColor()
//        orderNo.font = UIFont.systemFontOfSize(15)
//        //orderNo.backgroundColor = UIColor.redColor()
//        self.view.addSubview(orderNo)
//        
//        
//        var orderStatus = UILabel(frame: CGRectMake(8, h+25, width, 20))
//        orderStatus.text = "申请时间:\(refundData.applyTime)"
//        orderStatus.textColor = UIColor.orangeColor()
//        orderStatus.font = UIFont.systemFontOfSize(15)
//        self.view.addSubview(orderStatus)
//        
//        
//        
//        var customerID = UILabel(frame: CGRectMake(8,h+50 , width, 20))
//        customerID.text = "退款时间:\(refundData.refundDate)"
//        customerID.textColor = UIColor.blackColor()
//        customerID.font = UIFont.systemFontOfSize(15)
//        self.view.addSubview(customerID)
//        
// 
//        
//        var customerName = UILabel(frame: CGRectMake(8, h+75, width, 20))
//        customerName.text = "退款金额:\(refundData.money)元"
//        customerName.textColor = UIColor.blackColor()
//        customerName.font = UIFont.systemFontOfSize(15)
//        self.view.addSubview(customerName)
// 
//        
//        var Reason = UILabel(frame: CGRectMake(8, h+100 , width, 25))
//        Reason.text = "申请理由:"
//        Reason.textColor = UIColor.blackColor()
//        Reason.font = UIFont.systemFontOfSize(15)
//        self.view.addSubview(Reason)
//        
//        var ReasonField = UITextView(frame: CGRectMake(8, h+130,width-16, 100))
//        //添加滚动区域
//        ReasonField.contentInset = UIEdgeInsetsMake(-6,0 , 0, 0)
//        //字体
//        ReasonField.font = UIFont.systemFontOfSize(16)
//        ReasonField.textColor = UIColor.grayColor()
//        ReasonField.text = "\(refundData.reason)"
//        ReasonField.editable = false
//        //边框粗细
//        ReasonField.layer.borderWidth = 1
//        //边框颜色
//        ReasonField.layer.borderColor = UIColor.grayColor().CGColor
//        //圆角
//        ReasonField.layer.cornerRadius = 5
//        //是否可以滚动
//        ReasonField.scrollEnabled = true
//        //自适应高度
//        ReasonField.autoresizingMask = UIViewAutoresizing.FlexibleHeight
//        //使文本框在界面打开时就获取焦点，并弹出输入键盘
//        //        ReasonField.becomeFirstResponder()
//        //使文本框失去焦点，并收回键盘
//        ReasonField.resignFirstResponder()
//        //键盘形式
//        ReasonField.keyboardType = UIKeyboardType.Twitter
//        self.view.addSubview(ReasonField)
//        
//        
//        
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
//        navigationItem.title = "退款详情"
//        //设置导航栏左边按钮
//        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
//        navigationBar?.pushNavigationItem(navigationItem, animated: true)
//        
//        
//        return navigationItem
//    }
//    
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
