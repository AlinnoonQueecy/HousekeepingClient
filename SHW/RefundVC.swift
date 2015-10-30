////
////  RefundVC.swift
////  SHW
////
////  Created by Zhang on 15/9/18.
////  Copyright (c) 2015年 star. All rights reserved.
////
//
//import UIKit
//
//class RefundVC: UIViewController,UIAlertViewDelegate,UITextViewDelegate,UIScrollViewDelegate,NSURLConnectionDataDelegate{
//
//    //声明导航条
//    var navigationBar : UINavigationBar?
//    //接收上个界面传递的数据
//    var Data:Finishinfo!
//    //BUtton
//    var tijiao = UIButton()
//    var buttonC = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
//     var CBY = CGFloat()
//     var height = CGFloat()
//     var width = CGFloat()
//    var Y = CGFloat()
//      var scrollView = UIScrollView()
//    
//    var money:String!
//    var reason:String!
//     var SumField = UITextField()
//     var ReasonField = UITextView()
//    //退款信息
//    var refundData:RefundInfo!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        width = self.view.frame.width
//         height = self.view.frame.height
//
//        //实例化导航条
//        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.width, 64))
//        self.view.addSubview(navigationBar!)
//        println("创建导航条详情")
//        onMakeNavitem()
//        
//        //1、创建手势实例，并连接方法UITapGestureRecognizer,点击手势
//        var recognizer =  UITapGestureRecognizer(target:self, action:"touchScrollView:")
//        println("touchScrollView")
//        
//        //设置手势点击数,点1下
//        recognizer.numberOfTapsRequired = 1
//        
//        //recognizer.numberOfTouchesRequired = 1
//        
//        scrollView.addGestureRecognizer(recognizer)
//        NSNotificationCenter.defaultCenter().addObserver(self,selector:Selector("keyboardWillShow:"),name:UIKeyboardWillShowNotification,object:nil)
//        NSNotificationCenter.defaultCenter().addObserver(self,selector:Selector("keyboardWillHide:"),name:UIKeyboardWillHideNotification,object:nil)
//        
//        
//        //添加scrollview
//        scrollView.delegate = self
//        //        var scrollView = UIScrollView()
//        //scrollView.bounds = self.view.bounds
//        scrollView.frame = CGRectMake(0, 64,width,height)
//        scrollView.contentSize=CGSizeMake(width,height*5)
//        //scrollView.contentInset = UIEdgeInsetsMake(-64,0,0, 0)
//        //不可翻页
//        scrollView.pagingEnabled = false
//        //不显示横向滑竿
//        scrollView.showsHorizontalScrollIndicator = false
//        //不显示纵向滑竿
//        scrollView.showsVerticalScrollIndicator = false
//        //设置不可下拉
//        scrollView.bounces = false
//        scrollView.scrollsToTop = false
//        self.view.addSubview(scrollView)
//        
//        
//        
//        Y = CGFloat(5)
//        var OrderNO = UILabel(frame: CGRectMake(8, Y , width, 25))
//        OrderNO.text = "订单编号:"
//        OrderNO.textColor = UIColor.blackColor()
//        OrderNO.font = UIFont.systemFontOfSize(15)
//        scrollView.addSubview(OrderNO)
//        
//        var orderN = UILabel(frame: CGRectMake(8, Y+30 , width, 25))
//        orderN.text = "\(Data.orderNo)"
//        orderN.textColor = UIColor.blackColor()
//        orderN.font = UIFont.systemFontOfSize(15)
//        scrollView.addSubview(orderN)
//        
//        var Sum = UILabel(frame: CGRectMake(8, Y+60 ,80, 25))
//        Sum.text = "退款金额:"
//        Sum.textColor = UIColor.blackColor()
//        Sum.font = UIFont.systemFontOfSize(15)
//        scrollView.addSubview(Sum)
//        
//        
//        SumField = UITextField(frame: CGRectMake(80, Y+60,200, 25))
//        SumField.font = UIFont.systemFontOfSize(16)
//        SumField.borderStyle = UITextBorderStyle.RoundedRect
//        SumField.becomeFirstResponder()
//        SumField.textColor = UIColor.grayColor()
//        SumField.textAlignment = NSTextAlignment.Right
//        SumField.keyboardType = UIKeyboardType.DecimalPad
//        SumField.placeholder = "输入金额小于\(Data.servicePrice)"
//        scrollView.addSubview(SumField)
//        money = SumField.text
//        
//        var Yuan = UILabel(frame: CGRectMake(290, Y+60 , 20, 25))
//        Yuan.text = "元"
//        Yuan.textColor = UIColor.orangeColor()
//        Yuan.font = UIFont.systemFontOfSize(16)
//        scrollView.addSubview(Yuan)
//       
//
//        var Reason = UILabel(frame: CGRectMake(8, Y+95 , width, 25))
//        Reason.text = "申请理由:"
//        Reason.textColor = UIColor.blackColor()
//        Reason.font = UIFont.systemFontOfSize(15)
//        scrollView.addSubview(Reason)
//
//         ReasonField = UITextView(frame: CGRectMake(8, Y+125,width-16, 100))
//        ReasonField.delegate = self
//        //添加滚动区域
//       ReasonField.contentInset = UIEdgeInsetsMake(-6,0 , 0, 0)
//        //字体
//        ReasonField.font = UIFont.systemFontOfSize(16)
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
////        ReasonField.becomeFirstResponder()
//        //使文本框失去焦点，并收回键盘
//        ReasonField.resignFirstResponder()
//        //键盘形式
//        ReasonField.keyboardType = UIKeyboardType.Twitter
//       scrollView.addSubview(ReasonField)
//        reason = ReasonField.text
//        //提交按钮
//        
//        tijiao = UIButton(frame: CGRectMake(width/2-125,Y+250, 250, 30))
//        tijiao.setTitle("确认提交", forState: UIControlState.Normal)
//        tijiao.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        tijiao.backgroundColor = UIColor.orangeColor()
//        tijiao.layer.cornerRadius = 5
//        tijiao.addTarget(self , action: Selector("tapped9:"), forControlEvents: UIControlEvents.TouchUpInside)
//        scrollView.addSubview(tijiao)
//        
//        scrollView.contentSize = CGSizeMake(width,Y+300+253)
//        
//        
//        
//        
//    }
//         func tapped9(Button9:UIButton){
//            var n = SumField.text
//            var m = (n as NSString).floatValue
//            if  m  > Data.servicePrice {
//                
//                var alert =  UIAlertView(title: "", message: "输入金额不应大于付款金额", delegate: self, cancelButtonTitle: "确定")
//                alert.show()
//            }else{
//            
//            
//        //调退款
//        
////        refundData = getRefund(Data.orderNo, Data.customerID, Data.contactPhone, Data.facilitatorID, ReasonField.text, SumField.text) 
//            
//            
//        var serviceresponse:String = QureyRefund(Data.orderNo, Data.customerID, Data.contactPhone, Data.facilitatorID, ReasonField.text, SumField.text)
//                
//        if serviceresponse == "Success"{
//            var alert1 =  UIAlertView(title: "", message: "申请成功,请耐心等待!", delegate: self, cancelButtonTitle: "确定")
//            alert1.tag = 1
//            alert1.show()
//            
//            
//            
//        } else if serviceresponse == "Failed"{
//            
//            var alert2 =  UIAlertView(title: "", message: "请求失败,请重试!", delegate: self, cancelButtonTitle: "确定")
//            alert2.tag = 2
//            alert2.show()
//            
//        }
//            }
//        
//    }
////    //UIAlert触发函数
//    
//    func  alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
//        if (alertView.tag == 1) {
//            println("成功")
//            
//            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let vc = sb.instantiateViewControllerWithIdentifier("finish") as! UIViewController
//            self.presentViewController(vc, animated: true, completion: nil)
////
//        }else{
//            println("失败")
//            //        self.performSegueWithIdentifier("back", sender: self)
//           
//        }
//    }
//
//    
//    
//    
//    
//    
//    
//    
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
//        navigationItem.title = "退款信息"
//        //设置导航栏左边按钮
//        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
//        navigationBar?.pushNavigationItem(navigationItem, animated: true)
//        
//        
//        return navigationItem
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    
//    
//    
//    
//    
//    /*
//    // MARK: - Navigation
//    
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    // Get the new view controller using segue.destinationViewController.
//    // Pass the selected object to the new view controller.
//    }
//    */
//    func touchScrollView(sender: UITapGestureRecognizer){
//        println("取消键盘2")
//        //        self.view.resignFirstResponder()
//        scrollView.endEditing(true)
//        //        self.view.endEditing(true)
//    }
//    func keyboardWillShow(sender:NSNotification){
//        scrollView.contentSize = CGSizeMake(width,Y+300+253)
//        
//    }
//    func keyboardWillHide(sender:NSNotification){
//        scrollView.contentSize = CGSizeMake(width,Y+300)
//        
//    }
//    
//
//    
//}
//
