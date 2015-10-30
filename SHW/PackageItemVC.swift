////
////  PackageItemVC.swift
////  SHW
////
////  Created by Zhang on 15/7/31.
////  Copyright (c) 2015年 star. All rights reserved.
////
//
//import UIKit
//
//class PackageItemVC: UIViewController {
//
//    var pageHeight = 1300
//    
//    //声明导航条
//    var navigationBar : UINavigationBar?
//    //读取本地数据
//    var customerid:String = ""
//    var loginPassword:String = ""
//    //声明ScrollView
//    //var scrollView :UIScrollView?
//    //声明上个界面传递的数据
//    var CommonItem:serviceItemInfo!
//    var CommonTitle:String!
//    //声明传递的参数
//    var facilitatorid:String!
//    //声明Button
//    var yuyue:UIButton?
//    //声明
//    var text:String = ""
//    var statusLabelText:NSString = ""
//    //声明页面其他控件
//    //var servicePicture:UIImage?
//    var itemName:UILabel?
//    var serviceType:UILabel?
//    var itemIntro:UILabel?
//    var priceDescription:UILabel?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //读取用户信息，如果不是第一次登录，则会自动登录
//        readNSUerDefaults()
//        //初始化数据
//        //CommonItemInfo = refreshServiceItemC(facilitatorid!) as! [serviceItemInfo]
//        println("Package")
//       
//        var width = self.view.frame.width
//        var height = self.view.frame.height
//        var labelW = self.view.frame.width - 20
//        
//        //实例化导航条
//        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, 64))
//        self.view.addSubview(navigationBar!)
//        println("创建导航条详情Package")
//        onMakeNavitem()
//        println("创建导航条详情Package结束")
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
//        println("id:\(CommonItem!.id)")
//        //  服务图片
//        var introimgY = CGFloat(20)
//        var servicePicture = UIImageView(frame: CGRectMake(20, introimgY,width - 40, 200))
//        //println("宽度\(self.view.frame.width)")
//        //网络地址获取图片
//        //1.定义一个地址字符串常量
//        let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/upload/service/\(CommonItem.id)/\(CommonItem.servicePicture)"
// 
////        //let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/upload/service/\(business.id)/\(business.servicePicture)"
////        //2.通过String类型，转换NSUrl对象
//        let url :NSURL = NSURL(string: imageUrlString)!
//        println("url:\(url)")
////        //3.从网络获取数据流
////        if let data:NSData = NSData(contentsOfURL: url){
////            //4.通过数据流初始化图片
////            servicePicture.image = UIImage(data: data)
////        }else {
////            
////            servicePicture.image = UIImage(named: "1211.jpg")!
////        }
//        
//       
////        var data = getImageData(imageUrlString)
////        if data == nil{
////            servicePicture.image = UIImage(named: "1211.jpg")
////            
////        }else{
////            servicePicture.image = UIImage(data: data!)
////        }
//        
//        servicePicture.setZYHWebImage(imageUrlString, defaultImage: "1211.jpg")
//        scrollView.addSubview(servicePicture)
//        
//        //服务项目
//        var itemNameY = introimgY + 180
////        println("CommonItem:\(CommonItem)")
////        println("CommonItem:\(CommonItem.serviceType)")
////        itemName = UILabel(frame: CGRectMake(8, itemNameY, 300, 20))
////        itemName!.text = "服务项目:\(CommonItem!.serviceType)"
////        itemName!.textColor = UIColor.orangeColor()
////        itemName!.font = UIFont.systemFontOfSize(15)
////        scrollView.addSubview(itemName!)
//        
//        //服务类别
//        serviceType = UILabel(frame: CGRectMake(8, itemNameY+20, labelW, 20))
//        serviceType!.text = "服务类别:\(CommonItem!.serviceType)"
//        serviceType!.textColor = UIColor.blackColor()
//        serviceType!.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(serviceType!)
//        
//        //项目介绍
//        //计算文字的高度
//        //text = CommonItemInfo.itemIntro
//        statusLabelText = CommonItem!.itemIntro
//        var font = UIFont.systemFontOfSize(14)
//        var statusLabelSize1 = statusLabelText.sizeWithAttributes([NSFontAttributeName:font])
//        
//        //根据高度设LabelFrame
//        var H1 = statusLabelSize1.height
//        var W1 = statusLabelSize1.width
//        var TH1 = H1*(W1/labelW+1)
//        println("高高高:\(TH1)")
//        itemIntro = UILabel(frame: CGRectMake(8, itemNameY+40, labelW, TH1))
//        itemIntro!.text = "项目介绍:\(CommonItem!.itemIntro)"
//        itemIntro!.textColor = UIColor.blackColor()
//        itemIntro!.font = UIFont.systemFontOfSize(14)
//        //保留整个单词
//        itemIntro!.lineBreakMode = NSLineBreakMode.ByWordWrapping
//        itemIntro!.numberOfLines = 0
//        scrollView.addSubview(itemIntro!)
//        var trainingYH = CGFloat(itemNameY+40+TH1)
//        //价格
//        priceDescription = UILabel(frame: CGRectMake(8, trainingYH+4, labelW, 20))
//        priceDescription!.text = "价格:\(CommonItem!.priceDescription)元"
//        priceDescription!.textColor = UIColor.blackColor()
//        priceDescription!.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(priceDescription!)
//        //预定按钮
//        var CBY = trainingYH+44
//        yuyue = UIButton(frame:CGRectMake(width/2-50, CBY,100,30))
//        yuyue! .setTitle("立即预定", forState:UIControlState.Normal)
//        yuyue!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        yuyue!.titleLabel?.font = UIFont.systemFontOfSize(15)
//        yuyue!.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
//        yuyue!.showsTouchWhenHighlighted = true
//        yuyue?.layer.cornerRadius = 5
//        yuyue!.backgroundColor = UIColor.orangeColor()
//        scrollView.addSubview(yuyue!)
//        yuyue!.addTarget(self , action:Selector("yuding:"), forControlEvents: UIControlEvents.TouchUpInside)
//        scrollView.contentSize = CGSizeMake(width,CBY+120)
//        println(scrollView.bounds.height)
//        
//        
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    //    //立即预订的跳转函数
//        func yuding(yuyue:UIButton){
//            
//            //读取用户信息，如果不是第一次登录，则会自动登录
//            readNSUerDefaults()
//            
//             if customerid != "" && loginPassword != ""{
//                self.performSegueWithIdentifier("toOrderP", sender: self)
//             }else {
////                 let alert =  UIAlertView(title: "", message: "登录后才能预定哦!", delegate: self, cancelButtonTitle: "确定")
//                //alert.show()
//                let sb = UIStoryboard(name: "Main", bundle: nil)
//                let vc = sb.instantiateViewControllerWithIdentifier("LoginVC") as! UIViewController
//                self.presentViewController(vc, animated: true, completion: nil)
//            }
//            
//    
//        }
//    
//    //从NSUerDefaults 中读取数据
//    func readNSUerDefaults () {
//        
//        var userDefaultes = NSUserDefaults.standardUserDefaults()
//        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
//            customerid = userDefaultes.stringForKey("customerID")!
//            loginPassword = userDefaultes.stringForKey("loginPassword")!
//            
//        }
//        
//    }
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
//        navigationItem.title = "项目详情"
//        //设置导航栏左边按钮
//        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
//        navigationBar?.pushNavigationItem(navigationItem, animated: true)
//         println("创建导航条step1结束")
//        return navigationItem
//       
//    }
// 
//    
//
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier! == "toOrderP" {
//            println("下订单")
//            let controller = segue.destinationViewController as! PackageOrder
//            var  object = CommonItem
//            println(object.serviceType)
//            controller.OrderData = object
//            
//        }
//    }
//
//}
