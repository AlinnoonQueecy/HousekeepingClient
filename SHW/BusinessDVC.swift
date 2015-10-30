////
////  BusinessDVC.swift
////  SHW
////
////  Created by Zhang on 15/6/15.
////  Copyright (c) 2015年 star. All rights reserved.
////
//
//import UIKit
//
//class BusinessDVC: UIViewController,UIAlertViewDelegate,UIScrollViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate{
//
//    //var  pageWidth =
//    
//    var pageHeight = 1300
//    
//    //声明导航条
//    var navigationBar : UINavigationBar?
//    //读取本地数据
//    var customerid:String = ""
//    var loginPassword:String = ""
//    //声明上个界面传递来的数据
//    var facilitatorid :String = ""
//    //声明数组，存储
//    var detailItem:facilitatorInfo!
//    var CommonItemInfo:[serviceItemInfo] = []
//    var PackageItemInfo:[serviceItemInfo]=[]
//    var isCollect:String = "no"
//    //声明传递的参数
//    var titleOfState:String?
//    //声明BUtton
//    var term1:UIButton?
//      var collect = UIButton()
//     let introImg = UIImageView()
//    //声明项目跳转的数据
//    var commmondetail:[serviceItemInfo]=[]
//    var common:serviceItemInfo!
//    var package:serviceItemInfo!
//    
//   //@IBOutlet weak var scrollView: UIScrollView!
//    var scrollView = UIScrollView()
//    var _data:NSData?
//    var imageUrlString:String?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //scrollView.delegate = self
//        //初始化数据
//        readNSUerDefaults ()
//        
//        detailItem = refreshFDetail(facilitatorid) as facilitatorInfo
//        
//        
//        CommonItemInfo = refreshCommonItem(facilitatorid) as! [serviceItemInfo]
// 
//        PackageItemInfo = refreshPackageItem(facilitatorid) as! [serviceItemInfo]
// 
//       if customerid != "" && loginPassword != "" {
//        isCollect = GetCollect(facilitatorid,customerid) as String
//
//        }
//     
// 
//
//        var width1 = self.view.frame.width
//        scrollView = UIScrollView(frame: CGRectMake(0, 64, width1, self.view.frame.height*5))
//        scrollView.contentSize=CGSizeMake(width1,self.view.frame.height*5)
//        //scrollView.contentInset = UIEdgeInsetsMake(-64,0,0, 0)
//        scrollView.pagingEnabled = false
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.showsVerticalScrollIndicator = false
//        //设置不可下拉
//        scrollView.bounces = false
//        scrollView.scrollsToTop = false 
//        self.view.addSubview(scrollView)
//        
//        //实例化导航条
//        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width1, 64))
//        self.view.addSubview(navigationBar!)
//        onMakeNavitem()
//        
//        var facilitatorName = UILabel(frame: CGRectMake(8, 0, 300, 20))
//        facilitatorName.text = "商家名称:\(detailItem.facilitatorName)"
//        facilitatorName.textColor = UIColor.orangeColor()
//        facilitatorName.font = UIFont.systemFontOfSize(17)
//        scrollView.addSubview(facilitatorName)
//        
//         collect = UIButton(frame:CGRectMake(width1-70,10, 50,25))
//        
//        if isCollect == "yes" {
//            collect.setTitle("取消收藏", forState: UIControlState.Normal)
//        }else {
//            collect.setTitle("收藏", forState: UIControlState.Normal)
//        }
//        collect.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        collect.backgroundColor = UIColor.orangeColor()
//       collect.titleLabel!.font = UIFont.systemFontOfSize(12)
//        collect.layer.cornerRadius = 5
//        collect.showsTouchWhenHighlighted = true
//        collect.addTarget(self , action: Selector("collect:"), forControlEvents: UIControlEvents.TouchUpInside)
//        scrollView.addSubview(collect)
//        
//        var facilitatorID = UILabel(frame: CGRectMake(8, 20, 290, 20))
//        facilitatorID.text = "商家账号:\(detailItem.facilitatorID)"
//        facilitatorID.textColor = UIColor.blackColor()
//        facilitatorID.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(facilitatorID)
//        
////        var level = UILabel(frame: CGRectMake(8, 40, 70, 20))
////        //level.text = detailItem.facilitatorLevel
////        level.text = "商家级别:"
////        level.textColor = UIColor.blackColor()
////        level.font = UIFont.systemFontOfSize(14)
////        scrollView.addSubview(level)
////        
////        let levelImg = UIImageView(frame: CGRectMake(75, 41, 80, 16))
////        levelImg.image = imageForRank(detailItem.facilitatorLevel)
////        scrollView.addSubview(levelImg)
//        
//        var score = UILabel(frame: CGRectMake(8, 40, 200, 20))
//        score.text = "信用评分:\(detailItem.creditScore)"
//        score.textColor = UIColor.blackColor()
//        score.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(score)
//        
////        let scoreImg = UIImageView(frame: CGRectMake(75, 60, 80, 16))
//// 
////        
////        var scoreN:Int = detailItem.creditScore.toInt()!
////
////        scoreImg.image = imageForRank(scoreN)
////        
////        scrollView.addSubview(scoreImg)
//
//        
//  
//        
//        var dizhi = UILabel(frame: CGRectMake(8, 60, width1-8, 20))
//        dizhi.text = "公司地址:"
//        dizhi.textColor = UIColor.blackColor()
//        dizhi.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(dizhi )
//        
//        var province = UILabel(frame: CGRectMake(78, 60, 290, 20))
//        province.text = "\(detailItem.facilitatorProvince)省\(detailItem.facilitatorCity)市\(detailItem.facilitatorCounty)"
//        province.textColor = UIColor.blackColor()
//        province.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(province)
//        
// 
//        
//        var officePhone = UILabel(frame: CGRectMake(8, 80, 172, 20))
//        officePhone.text = "办公电话:\(detailItem.officePhone)"
//        officePhone.textColor = UIColor.blackColor()
//        officePhone.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(officePhone)
//        
//        
//        var contactAddress = UILabel(frame: CGRectMake(8, 100, width1-8, 20))
//        contactAddress.text = "联系地址:\(detailItem.contactAddress)"
//        contactAddress.textColor = UIColor.blackColor()
//        contactAddress.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(contactAddress)
//        
//        var contactPhone = UILabel(frame: CGRectMake(8, 120, 189, 20))
//        contactPhone.text = "联系电话:\(detailItem.contactPhone)"
//        contactPhone.textColor = UIColor.blackColor()
//        contactPhone.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(contactPhone)
//     
//    
//     
//        var emailAddress = UILabel(frame: CGRectMake(8, 140, 220, 20))
//        emailAddress.text = "Email地址:\(detailItem.emailAddress)"
//        emailAddress.textColor = UIColor.blackColor()
//        emailAddress.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(emailAddress)
//     
//        var qqNumber = UILabel(frame: CGRectMake(8, 160, 169, 20))
//        qqNumber.text = "qq号码:\(detailItem.qqNumber)"
//        qqNumber.textColor = UIColor.blackColor()
//        qqNumber.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(qqNumber)
//        
////        var introImg = UIImageView(frame: CGRectMake(0, 190, self.view.frame.width, 216))
//      //  let introImg = HYBLoadingImageView()
//       
//        
////        var front = UIFont(name: "Arial", size: 14)
////        var size = CGSizeMake(self.view.frame.width,200)
//        
//        introImg.frame = CGRectMake((width1-216)/2, 190, 216, 216)
//        println("宽度\(self.view.frame.width)")
//        //        //网络地址获取图片
//        //1.定义一个地址字符串常量
//        imageUrlString = HttpData.http+"/FamilyServiceSystem/upload/facilitator/\(detailItem.id)/\(detailItem.facilitatorLogo)"
//        //2.通过String类型，转换NSUrl对象
//        //        let url :NSURL = NSURL(string: imageUrlString!)!
//        //
//        //        //3.发出异步请求
//        //        var request = NSURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10)
//        //        //4.连接服务器
//        //        var connection =  NSURLConnection(request:request, delegate:self)
//        introImg.setZYHWebImage(imageUrlString, defaultImage: "reserve2.jpg" )
//        
//        scrollView.addSubview(introImg)
//        // 商家介绍
//        //计算文字的高度
////        var text = detailItem.facilitatorIntro
//        var statusLabelText:NSString = detailItem.facilitatorIntro
//        var font = UIFont.systemFontOfSize(14)
//        var statusLabelSize = statusLabelText.sizeWithAttributes([NSFontAttributeName:font])
//        //根据高度设LabelFrame
//        var H = statusLabelSize.height
//        var W = statusLabelSize.width
//        var labelW = self.view.frame.width - 16
//        var TH = H*(W/labelW+1)
//        
//        
//        
//        var introheight = TH
//        let introText = UILabel(frame:CGRectMake(8, 415,labelW,introheight ))
//        introText.text = "介绍:\(detailItem.facilitatorIntro)"
//        introText.textColor = UIColor.blackColor()
//        introText.font = font
//        introText.numberOfLines = 0
//        scrollView.addSubview(introText)
//        
//        
// 
//    
//                var registrationTime = UILabel(frame: CGRectMake(8, 420+introheight, 150, 20))
//                registrationTime.text = "注册时间:\(detailItem.registerTime)"
//                registrationTime.textColor = UIColor.blackColor()
//                registrationTime.font = UIFont.systemFontOfSize(14)
//                scrollView.addSubview(registrationTime)
//    
//                var serviceAmount = UILabel(frame: CGRectMake(200, 420+introheight, 100, 20))
//                serviceAmount.text = "服务次数:\(detailItem.serviceCount)次"
//                serviceAmount.textColor = UIColor.blackColor()
//                serviceAmount.font = UIFont.systemFontOfSize(14)
//                scrollView.addSubview(serviceAmount)
//
//          println("一步了吗")
//        var textFont = UIFont(name:"nil", size:16)
//        var y1 = 450 + introheight
//       // var y1 = CGFloat(450)
//        var Label1 = UILabel(frame:CGRectMake(8,CGFloat(y1),304,30))
//        Label1.text = "服务项目列表:"
//        Label1.numberOfLines = 1
//        Label1.backgroundColor = UIColor.whiteColor()
//        Label1.textAlignment = NSTextAlignment.Left
//        Label1.font = textFont
//        Label1.textColor = UIColor.orangeColor()
//        scrollView.addSubview(Label1)
//        
//        var bounds = self.view.frame
//        var width = (bounds.width-20)/3
//        var terms = CommonItemInfo.count
//        var  y2 = y1 + 33
//         //var  y2 = CGFloat(500)
//        for var i = 0;i < terms;i++ {
//             term1 = UIButton(frame:CGRectMake(8+(width+2)*CGFloat(i%3),y2 + CGFloat(i/3)*(28+4), width,28))
//            //term1! .setTitle(CommonItemInfo[i].itemName as String, forState:UIControlState.Normal)
//            term1! .setTitle(CommonItemInfo[i].serviceType as String, forState:UIControlState.Normal)
//            term1!.setTitleShadowColor(UIColor.whiteColor(),forState: UIControlState.Normal)
//            term1!.backgroundColor = UIColor.orangeColor()
//            term1!.titleLabel?.font = UIFont.systemFontOfSize(14)
//            term1!.showsTouchWhenHighlighted = true
//            term1!.addTarget(self , action: Selector("Common:"), forControlEvents: UIControlEvents.TouchUpInside)
//            
//            scrollView.addSubview(term1!)
//        }
//        //一口价列表
//        var y3 = y2 + CGFloat((terms-1)/3)*(28+4)+28
//         //var y3 = CGFloat(540)
//        var Label2 = UILabel(frame:CGRectMake(8, y3+5,304,30))
//        Label2.text = "一口价列表:"
//        Label2.numberOfLines = 1
//        Label2.backgroundColor = UIColor.whiteColor()
//        Label2.textAlignment = NSTextAlignment.Left
//        Label2.font = textFont
//        Label2.textColor = UIColor.orangeColor()
//        scrollView.addSubview(Label2)
//       
//        var terms2 = PackageItemInfo.count
//        var y4 = y3+CGFloat((terms2-1)/3)*28+65
//        //var y4 = CGFloat(600)
//        println(y4)
//        for var i = 0;i < terms2;i++ {
//            let term2 = UIButton(frame:CGRectMake(8+(width+2)*CGFloat(i%3),y3+35+CGFloat(i/3)*(28+4), width,28))
//            //term2 .setTitle(PackageItemInfo[i].itemName as String, forState:UIControlState.Normal)
//            term2 .setTitle(PackageItemInfo[i].serviceType as String, forState:UIControlState.Normal)
//            term2.setTitleShadowColor(UIColor.whiteColor(),forState: UIControlState.Normal)
//            term2.backgroundColor = UIColor.orangeColor()
//            term2.titleLabel?.font = UIFont.systemFontOfSize(14)
//            term2.showsTouchWhenHighlighted = true
//            term2.addTarget(self , action: Selector("Package:"), forControlEvents: UIControlEvents.TouchUpInside)
//            scrollView.addSubview(term2)
//            println(y4+CGFloat(i/3)*28+40)
//        }
//        
//  
//        var  renyuan = UIButton(frame:CGRectMake(8, y4+5,150,30))
//        renyuan .setTitle("服务人员列表", forState:UIControlState.Normal)
//        renyuan.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
//        renyuan.titleLabel?.font = UIFont.systemFontOfSize(16)
//        renyuan.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
//        renyuan.showsTouchWhenHighlighted = true 
//        renyuan.backgroundColor = UIColor.whiteColor()
//        renyuan.addTarget(self , action:Selector("tapped:"), forControlEvents: UIControlEvents.TouchUpInside)
//        scrollView.addSubview(renyuan)
//        
//        
//  
//        var  renyuan1 = UIButton(frame:CGRectMake(bounds.width-160, y4+5,154,30))
//        renyuan1 .setTitle("点击查看详情", forState:UIControlState.Normal)
//        renyuan1.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//        renyuan1.titleLabel?.font = UIFont.systemFontOfSize(14)
//        renyuan1.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
//        renyuan1.showsTouchWhenHighlighted = true
//        renyuan1.backgroundColor = UIColor.whiteColor()
//        scrollView.addSubview(renyuan1)
//        renyuan1.addTarget(self , action:Selector("tapped1:"), forControlEvents: UIControlEvents.TouchUpInside)
//        scrollView.contentSize = CGSizeMake(bounds.width,y4+100)
//       
//        
//    }
//    
//    
//    override func viewDidLayoutSubviews() {
//        scrollView.frame = CGRectMake(0, 64, self.view.frame.width, self.view.frame.height)
//    }
//    //服务项目的跳转函数
//    func  Common(term1:UIButton){
//        
//        titleOfState = term1.titleForState(.Normal)!
//        for var i = 0;i < CommonItemInfo.count;i++ {
//            if CommonItemInfo[i].serviceType == titleOfState{
//                common = CommonItemInfo[i]
//            }
//        }
//        println(titleOfState)
//        self.performSegueWithIdentifier("toCommon", sender: self)
//        println("tocommon")
//    }
//    //一口价的跳转函数
//    func  Package(term2:UIButton){
//        titleOfState = term2.titleForState(.Normal)!
//        for var i = 0;i < PackageItemInfo.count;i++ {
//            if PackageItemInfo[i].serviceType == titleOfState{
//                package = PackageItemInfo[i]
//            }
//        }
//        println("toPackage")
//          println(package)
//        self.performSegueWithIdentifier("toPackage", sender: self)
//        println(titleOfState)
//        
//    }
//    //服务人员的跳转函数
//    func tapped(renyuan:UIButton){
//                self.performSegueWithIdentifier("toServant", sender: self)
//        }
//    func tapped1(renyuan1:UIButton){
//        self.performSegueWithIdentifier("toServant", sender: self)
//    }
//    //收藏的函数传数据函数
//    func collect(collect:UIButton){
//        
//        
//        //读取用户信息，如果不是第一次登录，则会自动登录
//        readNSUerDefaults()
//        
//        if customerid == "" ||  loginPassword == "" {
//            
//            
////            let alert =  UIAlertView(title: "", message: "登录后才能收藏哦!", delegate: self, cancelButtonTitle: "确定")
////            alert.show()
////            let alert = UIAlertView(title: "登录", message: "", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "登录","还没账号吗?去注册")
////               alert.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
////               alert.show()
//            
//            
//            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let vc = sb.instantiateViewControllerWithIdentifier("LoginVC") as! UIViewController
//            self.presentViewController(vc, animated: true, completion: nil)
//        }else {
//        
//       isCollect = GetCollect(facilitatorid,customerid) as String
//
//        if isCollect == "yes" {
//            var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorCollectionAction?operation=_delete")
//            
//            var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
//            
//            request.HTTPMethod = "POST"
//            //要改参数类型
//            var param:String = "{\"customerID\":\"\(customerid)\",\"facilitatorID\":\"\(detailItem.facilitatorID)\",\"facilitatorName\":\"\(detailItem.facilitatorName)\"}"
//            
//            var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
//            request.HTTPBody = data;
//            var response:NSURLResponse?
//            var error:NSError?
//            var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
//            if (error != nil)
//            {
//                println(error?.code)
//                println(error?.description)
//            }
//            else
//            {
//                var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
//                println(jsonString)
//                
//            }
//            
//            let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
//            
//            var serviceresponse = json.objectForKey("serverResponse") as? String
//            if serviceresponse == "Success"{
//                let alert =  UIAlertView(title: "取消成功", message: "", delegate: self, cancelButtonTitle: "确定")
//                alert.show()
//                collect.setTitle("收藏", forState: UIControlState.Normal)
//                isCollect = "no"
//                
//            } else if serviceresponse == "Failed"{
//                
//                let alert =  UIAlertView(title: "取消失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
//                alert.show()
//            }
//            
//            
//        }else if isCollect == "no"{
//            
//        var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorCollectionAction?operation=_add")
//        
//        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
//        
//        request.HTTPMethod = "POST"
//        //要改参数类型
//        var param:String = "{\"customerID\":\"\(customerid)\",\"facilitatorID\":\"\(detailItem.facilitatorID)\",\"facilitatorName\":\"\(detailItem.facilitatorName)\"}"
//        
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
//            println(jsonString)
//            
//        }
//        
//        let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
//        
//        var serviceresponse = json.objectForKey("serverResponse") as? String
//        if serviceresponse == "Success"{
//            let alert =  UIAlertView(title: "收藏成功", message: "", delegate: self, cancelButtonTitle: "确定")
//            alert.show()
//            isCollect = "yes"
//            collect.setTitle("取消收藏", forState: UIControlState.Normal)
//            
//        } else if serviceresponse == "Failed"{
//            
//            let alert =  UIAlertView(title: "收藏失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
//            alert.show()
//        }
//       }
//      }
//    }
//    
//    
//    //登录和
//    
//    //等级图片的转换函数
//    func imageForRank(rank:Int) -> UIImage? {
//        switch rank {
//        case 1:
//            return UIImage(named: "1")
//        case 2:
//            return UIImage(named: "2")
//        case 3:
//            return UIImage(named: "3")
//        case 4:
//            return UIImage(named: "4")
//        case 5:
//            return UIImage(named: "5")
//        default:
//            return nil
//        }
//    }
//  //
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
//        navigationItem.title = "商家详情"
//        //设置导航栏左边按钮
//        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
//        
//        navigationBar?.pushNavigationItem(navigationItem, animated: true)
//        
//        
//        return navigationItem
//    }
//
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier! == "toCommon" {
//            let controller = segue.destinationViewController as! CommonItemVC
//            var  object = common
//            println("common:\(common)")
//            controller.CommonItem = object
//            
//            
//        }else if segue.identifier! == "toPackage" {
//            let controller = segue.destinationViewController as! PackageItemVC
//            var  object = package
//            println("common:\(package)")
//            controller.CommonItem = object
//        }else if segue.identifier! == "toServant" {
//            let controller = segue.destinationViewController as! WorkerVC
//            var  object = detailItem.facilitatorID
//            controller.facilitatorID = object
//          
//       }
//    }
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
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    override func  viewWillAppear(animated: Bool) {
//        readNSUerDefaults()
//        
//        if customerid != "" && loginPassword != "" {
//           isCollect = GetCollect(facilitatorid,customerid) as String
//            
//            println("isCollect:\(isCollect)")
//        }
//        
//      
//        if isCollect == "yes" {
//            collect.setTitle("取消收藏", forState: UIControlState.Normal)
//        }else {
//            collect.setTitle("收藏", forState: UIControlState.Normal)
//        }
//        
//    }
////    
////    func connection(data:NSData){
////        
////        _data?.appendData(data)
////        println("---data:\(data)")
////        
////   }
////    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
////        
////        println("接收信号")
////          _data = getImageData(imageUrlString)
//////        println("_---data:\(_data)")
////       introImg.image = UIImage(data:_data!)
////        
////        
////    }
////    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
////       introImg.image = UIImage(named: "reserve2.jpg")
////      
////    }
////    
////    
////    func connectionDidFinishLoading(connection:NSURLConnection)
////    {
////        
////        introImg.image = UIImage(data:_data!)
////    }
//
//}
