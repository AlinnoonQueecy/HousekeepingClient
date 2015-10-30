//
//  EvaluateVC.swift
//  SHW
//
//  Created by Zhang on 15/8/6.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class EvaluateVC: UIViewController,UIAlertViewDelegate,UITextFieldDelegate {

    //声明导航条
    var navigationBar : UINavigationBar?
    //接收上个界面传递的数据
    var EvaluateData:Finishinfo!
    //BUtton
    var Button1 = UIButton()
    var Button2 = UIButton()
    var Button3 = UIButton()
    var Button4 = UIButton()
    var Button5 = UIButton()
    
    var EvaluateS = UIButton()
    var Button6 = UIButton()
    var Button7 = UIButton()
    var Button8 = UIButton()
    var tijiao = UIButton()
    //UIAlertView
    var alert1 =  UIAlertView()
    var alert2 =  UIAlertView()
    
    //存储分数的变量
    var n:String = "5"
    var evaluation = UITextView()
    
    var buttonC = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        //实例化导航条
        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.width, 64))
        self.view.addSubview(navigationBar!)
        print("创建导航条详情")
        onMakeNavitem()
        
        
        let width = self.view.frame.width
        let  height = self.view.frame.height
        let  EvaluateY = CGFloat(80)
        let Evaluate = UIButton(frame: CGRectMake(15, EvaluateY, width, 25))
        Evaluate.setTitle("人员评分:", forState: UIControlState.Normal)
        Evaluate.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        Evaluate.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        Evaluate.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
        Evaluate.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.view.addSubview(Evaluate)
        
        let BuW = (width - 30)/5-4
        let BuW1 = (width - 30)/5
        let BuY = CGFloat(120)
     

        Button1 = UIButton(frame: CGRectMake(15, BuY, BuW, 25))
        Button1.setTitle("5", forState: UIControlState.Normal)
        Button1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        Button1.backgroundColor = buttonC
        Button1.addTarget(self , action: Selector("tapped1:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(Button1)
        
        Button2 = UIButton(frame: CGRectMake(15+BuW1, BuY, BuW, 25))
        Button2.setTitle("4", forState: UIControlState.Normal)
        Button2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        Button2.backgroundColor = buttonC
        Button2.addTarget(self , action: Selector("tapped2:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(Button2)
        
        Button3 = UIButton(frame: CGRectMake(15+2*BuW1, BuY, BuW, 25))
        Button3.setTitle("3", forState: UIControlState.Normal)
        Button3.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        Button3.backgroundColor = buttonC
        Button3.addTarget(self , action: Selector("tapped3:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(Button3)
        
        Button4 = UIButton(frame: CGRectMake(15+3*BuW1, BuY, BuW, 25))
        Button4.setTitle("2", forState: UIControlState.Normal)
        Button4.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        Button4.backgroundColor = buttonC
        Button4.addTarget(self , action: Selector("tapped4:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(Button4)
        
        Button5 = UIButton(frame: CGRectMake(15+4*BuW1, BuY, BuW, 25))
        Button5.setTitle("1", forState: UIControlState.Normal)
        Button5.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        Button5.backgroundColor = buttonC
        Button5.addTarget(self , action: Selector("tapped5:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(Button5)
        
        
        let Button = UIButton(frame: CGRectMake(15, BuY+50, 100, 25))
        Button.setTitle("评论内容:", forState: UIControlState.Normal)
        Button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        Button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        Button.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
        Button.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.view.addSubview(Button)

        
        
        evaluation = UITextView(frame: CGRectMake(15, BuY+80,width-40, 100))
        //字体
        evaluation.font = UIFont.systemFontOfSize(15)
        evaluation.textColor = UIColor.blackColor()
        evaluation.layer.borderWidth = 0.2
        //evaluation.layer.borderColor = UIColor.grayColor() as! CGColorRef
        //边框颜色
        evaluation.layer.borderColor = UIColor.grayColor().CGColor
        //圆角
        evaluation.layer.cornerRadius = 5
        //是否可以滚动
        evaluation.scrollEnabled = true
        //自适应高度
        evaluation.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(evaluation)
        
        tijiao = UIButton(frame: CGRectMake(width/2-125,height-70, 250, 30))
        tijiao.setTitle("确认提交", forState: UIControlState.Normal)
        tijiao.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        tijiao.backgroundColor = UIColor.orangeColor()
        tijiao.layer.cornerRadius = 5
        tijiao.addTarget(self , action: Selector("tapped9:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(tijiao)
        


        
        
    
    }
    func tapped1(Button1:UIButton){
        Button1.backgroundColor = UIColor.orangeColor()
        Button2.backgroundColor = buttonC
        Button3.backgroundColor = buttonC
        Button4.backgroundColor = buttonC
        Button5.backgroundColor = buttonC
        n = "5"
        
    }
    func tapped2(Button2:UIButton){
        Button2.backgroundColor = UIColor.orangeColor()
        Button1.backgroundColor = buttonC
        Button3.backgroundColor = buttonC
        Button4.backgroundColor = buttonC
        Button5.backgroundColor = buttonC
        n = "4"
        
    }
    func tapped3(Button3:UIButton){
        Button3.backgroundColor = UIColor.orangeColor()
        Button1.backgroundColor = buttonC
        Button2.backgroundColor = buttonC
        Button4.backgroundColor = buttonC
        Button5.backgroundColor = buttonC
        n = "3"
        
    }
    func tapped4(Button4:UIButton){
        Button4.backgroundColor = UIColor.orangeColor()
        Button1.backgroundColor = buttonC
        Button3.backgroundColor = buttonC
        Button2.backgroundColor = buttonC
        Button5.backgroundColor = buttonC
        n = "2"
        
    }

    func tapped5(Button5:UIButton){
        Button5.backgroundColor = UIColor.orangeColor()
        Button1.backgroundColor = buttonC
        Button3.backgroundColor = buttonC
        Button4.backgroundColor = buttonC
        Button2.backgroundColor = buttonC
        n = "1"
        
    }
    
    func tapped9(Button9:UIButton){
   
       //调评价接口
        let url: NSURL! = NSURL(string:HttpData.http+"/NationalService/MobileServiceOrderAction?operation=_comment")
        
        let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
        
        request.HTTPMethod = "POST"
 
          let param:String  = "{\"orderNo\":\"\(EvaluateData.orderNo)\",\"score\":\"\(n)\",\"commentContent\":\"\(evaluation.text)\"}"
        print("Evaluate:\(param)")
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

        
        let serviceresponse = json.objectForKey("serverResponse") as? String
        if serviceresponse == "Success"{
            alert1 =  UIAlertView(title: "提交成功", message: "", delegate: self, cancelButtonTitle: "确定")
            alert1.tag = 1
            alert1.show()
            
            
            
        } else if serviceresponse == "Failed"{
            
            alert2 =  UIAlertView(title: "提交失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
            alert2.tag = 2
            alert2.show()
            
        }

        
    }
    //UIAlert触发函数
 
    func  alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if (alertView.tag == 1) {
            print("成功")
          self.dismissViewControllerAnimated(true, completion: nil)
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
    
 

    @IBAction func CloseKey(sender: AnyObject) {
        
        self.view.endEditing(true)

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
        //var leftButton =  UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Bordered, target: self, action: "reply")
        //导航栏的标题
        navigationItem.title = "评价详情"
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        navigationBar?.pushNavigationItem(navigationItem, animated: true)
        
        
        return navigationItem
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
