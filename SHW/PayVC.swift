//
//  PayVC.swift
//  SHW
//
//  Created by Zhang on 15/8/5.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit
 

class PayVC: UIViewController {
    
    //声明导航条
    var navigationBar : UINavigationBar?
 
    //读取本地数据
    var customerid:String =  ""
    var loginPassword:String = ""
         //获取网络数据
    var myinfo:MyInfo!
    //控件
    var servantID :UILabel?
    var dizhi  = UITextField()
    var dianhua = UITextField()
    var beizhu = UITextField()
    //声明Button
    var yuyue:UIButton?
    //接收上个界面传递的订单编号
    //var PayData:reserveInfo!
      var PayData:Finishinfo!
    var payinfo:PayInfo!
    override func viewDidLoad() {
        super.viewDidLoad()
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        //初始化数据
        myinfo = QueryInfo(customerid) as MyInfo
        payinfo = PayInfo()
        let width = self.view.frame.width
        //var height = self.view.frame.height
        let labelW = self.view.frame.width - 20
        
//        var payinfo:PayInfo;
   //     AlipayMethod.pay(Payinfo)
        //实例化导航条
        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, 64))
        navigationBar?.barTintColor = UIColor.orangeColor()
        navigationBar?.translucent = false
        navigationBar?.barStyle = UIBarStyle.Default
        let navigationTitleAttribute: NSDictionary = NSDictionary(objectsAndKeys: UIColor.whiteColor(), NSForegroundColorAttributeName)
        navigationBar?.titleTextAttributes =  navigationTitleAttribute as [NSObject: AnyObject]
        self.view.addSubview(navigationBar!)
        print("创建导航条详情")
        onMakeNavitem()
        
//        //添加scrollview
//        var scrollView = UIScrollView()
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
        
        //订单信息
        let orderY = CGFloat(70)
        let order = UIButton(frame: CGRectMake(15, orderY, width-30, 30))
        order.setTitle("支付信息", forState: UIControlState.Normal)
        order.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        order.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        order.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
        order.titleLabel?.font = UIFont.systemFontOfSize(17)
        self.view.addSubview(order)
        
        let facilitatorID = UILabel(frame: CGRectMake(15, orderY+35, labelW, 25))
        facilitatorID.text = "订单编号:\(PayData!.orderNo)"
        facilitatorID.textColor = UIColor.blackColor()
        facilitatorID.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(facilitatorID)
        
        let servantName1 = UILabel(frame: CGRectMake(15, orderY+35+25, labelW, 25))
        servantName1.text = "支付金额:\(PayData.servicePrice)元"
        servantName1.textColor = UIColor.blackColor()
        servantName1.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(servantName1)
        
        //服务项目
        let itemName = UILabel(frame: CGRectMake(15, orderY+35+2*25, labelW, 25))
        itemName.text = "人员名称:\(PayData.servantName)"
        itemName.textColor = UIColor.blackColor()
        itemName.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(itemName)
        
        let customerInfoY  =  orderY+35+3*25+20
        let customerName = UILabel(frame: CGRectMake(15, customerInfoY, labelW, 25))
        customerName.text = "订单内容:\(PayData.serviceContent)"
        customerName.textColor = UIColor.blackColor()
        customerName.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(customerName)
        
        //预定按钮
       // var CBY = customerInfoY+115+30
         let CBY = self.view.frame.height-70
        yuyue = UIButton(frame:CGRectMake(width/2-125, CBY,250,30))
        yuyue! .setTitle("确认支付", forState:UIControlState.Normal)
        yuyue!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        yuyue!.titleLabel?.font = UIFont.systemFontOfSize(15)
        yuyue!.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        yuyue!.showsTouchWhenHighlighted = true
        yuyue?.layer.cornerRadius = 5
        yuyue!.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(yuyue!)
        yuyue!.addTarget(self , action:Selector("yuding:"), forControlEvents: UIControlEvents.TouchUpInside)
        
//        
//        scrollView.contentSize = CGSizeMake(width,64+CBY+30+253)
//        println(scrollView.bounds.height)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //支付的函数
    func yuding(yuyue:UIButton){
        
        let payid:String = PayData.orderNo as String
        let payname:String  = PayData.servantName as String
        let paycontent:String = PayData.serviceContent as String
        let payprice:Float = PayData.servicePrice as Float
        print("Payinfo\(payinfo.payID)")
         print(payid)
         payinfo.payID  =  payid
         payinfo.payName = payname
         payinfo.payBody = paycontent
         payinfo.payPrice = payprice
          print("Payinfo.payID\(payinfo.payID)")
         AlipayMethod.pay(payinfo)
//        let alert =  UIAlertView(title: "", message: "请刷新列表", delegate: self, cancelButtonTitle: "确定")
//        alert.show()
     }
    
    
    func  alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("reserve") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    

    
    
    func getres(){
        let url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileServiceOrderAction?operation =_queryOrderByid")
        
        
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
        
        request.HTTPMethod = "POST"
        
        let param:String = "{\"id\":\"\(PayData.id)\" }"
        print("param")
        print(param)
        
        let data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
        request.HTTPBody = data;
        var response:NSURLResponse?
        var error:NSError?
        var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        if (error != nil)
        {
            println(error?.code)
            println(error?.description)
        }
        else
        {
            var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
            println(jsonString)
            
        }
        
        let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
        //        var dic = dict as! NSDictionary
        print(json)
        let serverResponse = json!.objectForKey("serverResponse") as? String
        let value: AnyObject?=json!.objectForKey("data")
        
        
        if serverResponse == "Success"{
            
            //            let alert =  UIAlertView(title: "预定成功", message: "商家会尽快与您取得联系!", delegate: self, cancelButtonTitle: "确定")
            //            alert.show()
            //
            //
            //        }else if serverResponse == "Failed"{
            //
            //            let alert =  UIAlertView(title: "预定失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
            //            alert.show()
            //
            //        }
            let status :String = value!.objectForKey("orderStatus") as! String
            if  status == "付款完成" {
                let alert =  UIAlertView(title: "", message: "请刷新列表", delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }
        }

    }
    //导航条详情
    func reply (){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func onMakeNavitem() -> UINavigationItem{
        print("创建导航条step1")
        //创建一个导航项
        let navigationItem = UINavigationItem()
        //创建左边按钮
        let leftButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "reply")
        leftButton.tintColor = UIColor.whiteColor()

        //var leftButton =  UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Bordered, target: self, action: "reply")
        //导航栏的标题
        navigationItem.title = "支付详情"
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        
        navigationBar?.pushNavigationItem(navigationItem, animated: true)
        
        
        return navigationItem
    }
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        let userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
            customerid = userDefaultes.stringForKey("customerID")!
            loginPassword = userDefaultes.stringForKey("loginPassword")!
        }
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
