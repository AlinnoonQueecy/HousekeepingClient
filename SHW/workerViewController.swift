
//  ViewController.swift
//  人员信息
//
//  Created by appl on 15/6/15.
//  Copyright (c) 2015年 appl. All rights reserved.

import UIKit

class workerViewController: UIViewController,NSURLConnectionDataDelegate{
    
    var pageHeight = 1300
    
    //声明导航条
    var navigationBar : UINavigationBar?
    //读取本地数据
    var customerid:String = ""
    var loginPassword:String = ""
    //声明接收的数据
    var workerdetail:ServantInfo!
    //声明传递的参数
    var titleOfState:String?
    //声明网络获取的数据
    var isCollect:String = "no"
  
    //声明BUtton
    var comunication:UIButton!
    var yuyue:UIButton!
    //
    var text:String = ""
    var statusLabelText:NSString = ""
    var collect = UIButton()
    //@IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        //初始化数据
        print("初始化是否被收藏")
        
        if customerid != "" && loginPassword != "" {
            isCollect = GetServantCollect(workerdetail.servantID, customerid) as String
           
            print("isCollect:\(isCollect)")
        }
        
       
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        let labelW = self.view.frame.width - 20
        //添加scrollview
        let scrollView = UIScrollView()
        //scrollView.bounds = self.view.bounds
        scrollView.frame = CGRectMake(0, 64,width,height)
        scrollView.contentSize=CGSizeMake(width,height*5)
        //scrollView.contentInset = UIEdgeInsetsMake(-64,0,0, 0)
        //不可翻页
        scrollView.pagingEnabled = false
        //不显示横向滑竿
        scrollView.showsHorizontalScrollIndicator = false
        //不显示纵向滑竿
        scrollView.showsVerticalScrollIndicator = false
        //设置不可下拉
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        self.view.addSubview(scrollView)
        
        //实例化导航条
        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, 64))
        navigationBar?.barTintColor = UIColor.orangeColor()
        navigationBar?.translucent = false
        navigationBar?.barStyle = UIBarStyle.Default
        let navigationTitleAttribute: NSDictionary = NSDictionary(objectsAndKeys: UIColor.whiteColor(), NSForegroundColorAttributeName)
        navigationBar?.titleTextAttributes =  navigationTitleAttribute as [NSObject: AnyObject]
        self.view.addSubview(navigationBar!)
        print("创建导航条详情servant")
        onMakeNavitem()
        //人员头像
        let introimgY = CGFloat(20)
        let introImg = UIImageView(frame: CGRectMake((width-180)/2, introimgY,180, 180))
        print("宽度\(self.view.frame.width)")
        //网络地址获取图片
        //1.定义一个地址字符串常量
        print("服务员图片")
        let picturename = workerdetail.headPicture
        //1.隐式定义字符串数组
        var myArray = picturename.componentsSeparatedByString(".")
        let  pictureName = "\(myArray[0])f.\(myArray[1])"
        print("pictureName\(pictureName)")
        // let imageUrlString:String = HttpData.http+"/NationalService/\(workerdetail.headPicture)"
         let imageUrlString:String = HttpData.http+"/NationalService/\(pictureName)"
        
        //2.通过String类型，转换NSUrl对象
         let url:NSString = imageUrlString.URLEncodedString()

 
        introImg.setZYHWebImage(url as String, defaultImage: "reserve2.jpg")
        scrollView.addSubview(introImg)
        
        //人员名称
        let NameY = introimgY + 187
        let ServantName = UILabel(frame: CGRectMake(8, NameY,200, 20))
        ServantName.text = "人员名称:\(workerdetail.servantName)"
        ServantName.textColor = UIColor.orangeColor()
        ServantName.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(ServantName)
//        //人员状态
//        var servantStatus = UILabel(frame: CGRectMake(8, 100, 172, 20))
//        servantStatus.text = "状态:"
//      
//        servantStatus.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(servantStatus)
         //收藏按钮
         collect = UIButton(frame:CGRectMake(width-70,NameY+10, 50,25))
        
        if isCollect == "yes" {
            collect.setTitle("取消收藏", forState: UIControlState.Normal)
        }else {
            collect.setTitle("收藏", forState: UIControlState.Normal)
        }
        collect.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        collect.backgroundColor = UIColor.orangeColor()
        collect.titleLabel!.font = UIFont.systemFontOfSize(12)
        collect.layer.cornerRadius = 5
        collect.showsTouchWhenHighlighted = true
        collect.addTarget(self , action: Selector("collect:"), forControlEvents: UIControlEvents.TouchUpInside)
        scrollView.addSubview(collect)


        //性别
        let servantGender = UILabel(frame: CGRectMake(8, NameY+20, 200, 20))
        servantGender.text = "性别:\(workerdetail.servantGender)"
        servantGender.textColor = UIColor.blackColor()
        servantGender.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(servantGender)
        //是否已婚
        let servantAge = UILabel(frame: CGRectMake(8, NameY+20*2, 200, 20))
        servantAge.text = "年龄:\(workerdetail.servantAge)"
        servantAge.textColor = UIColor.blackColor()
        servantAge.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(servantAge)

        //民族
        let servantNationality = UILabel(frame: CGRectMake(8, NameY+20*3, 200, 20))
        servantNationality.text = "民族:\(workerdetail.servantNationality)"
        servantNationality.textColor = UIColor.blackColor()
        servantNationality.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(servantNationality)

        //状态
        // var Status = UILabel(frame: CGRectMake(width-70, NameY+10, 50, 25))
        let Status = UILabel(frame: CGRectMake(100, NameY+20, 50, 20))
        Status.text = (workerdetail.servantStatus)
        if workerdetail.servantStatus == "服务中"{
          
            Status.textColor = UIColor.redColor()
            Status.text = "服务中"
            
        }else if workerdetail.servantStatus == "空闲"{
            
            Status.textColor = UIColor.greenColor()
              Status.text = "空闲"
        }
        
        Status.textAlignment = NSTextAlignment.Center
        // Status.layer.cornerRadius = 30  没效果
        Status.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(Status)
        //是否已婚
        let isMarried = UILabel(frame: CGRectMake(8, NameY+20*4, 200, 20))
        if workerdetail.isMarried {
            isMarried.text = "是否结婚:已婚"
        }else {
          isMarried.text = "是否结婚:未婚"
        }
       
        isMarried.textColor = UIColor.blackColor()
        isMarried.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(isMarried)
        //联系电话
        let phoneNo = UILabel(frame: CGRectMake(8, NameY+20*5, labelW, 20))
        phoneNo.text = "联系电话:\(workerdetail.phoneNo)、\(workerdetail.servantMobil) "
        phoneNo.textColor = UIColor.blackColor()
        phoneNo.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(phoneNo)
        //QQ
        let qqNumber = UILabel(frame: CGRectMake(8, NameY+20*6, labelW, 20))
        qqNumber.text = "QQ账号:\(workerdetail.qqNumber)"
        qqNumber.textColor = UIColor.blackColor()
        qqNumber.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(qqNumber)
        //邮箱
        let emailAddress = UILabel(frame: CGRectMake(8, NameY+20*7, labelW, 20))
        emailAddress.text = "邮箱:\(workerdetail.emailAddress)"
        emailAddress.textColor = UIColor.blackColor()
        emailAddress.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(emailAddress)
        
        //区域
        let quyu = UILabel(frame: CGRectMake(8, NameY+20*8, labelW, 20))
        quyu.text = "所在区域:\(workerdetail.servantProvince)省\(workerdetail.servantCity)市\(workerdetail.servantCounty)"
        quyu.textColor = UIColor.blackColor()
        quyu.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(quyu)
        //服务区域
        let serviceArea = UILabel(frame: CGRectMake(8, NameY+20*9, labelW, 20))
        serviceArea.text = "服务区域:\(workerdetail.serviceArea)"
        serviceArea.textColor = UIColor.blackColor()
        serviceArea.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(serviceArea)
        //服务区域
        let serviceCount = UILabel(frame: CGRectMake(8, NameY+20*10, labelW, 20))
        serviceCount.text = "服务次数:\(workerdetail.serviceCount)"
        serviceCount.textColor = UIColor.blackColor()
        serviceCount.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(serviceCount)
        //从业年限
        let workYears = UILabel(frame: CGRectMake(8, NameY+20*11, labelW, 20))
        workYears.text = "从业年限:\(workerdetail.workYears)年"
        workYears.textColor = UIColor.blackColor()
        workYears.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(workYears)
        //教育程度
        let educationLevel = UILabel(frame: CGRectMake(8, NameY+20*12, labelW, 20))
        educationLevel.text = "教育程度:\(workerdetail.educationLevel)"
        educationLevel.textColor = UIColor.blackColor()
        educationLevel.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(educationLevel)
        //培训经历
        //计算文字的高度
         text = workerdetail.trainingIntro
         statusLabelText = text
        let font = UIFont.systemFontOfSize(14)
        let statusLabelSize1 = statusLabelText.sizeWithAttributes([NSFontAttributeName:font])
//        println("文字的高度:\(statusLabelSize.height)")
//        println("文字的宽度:\(statusLabelSize.width)")
        
        //根据高度设LabelFrame
        let H1 = statusLabelSize1.height
        let W1 = statusLabelSize1.width
        let TH1 = H1*(W1/labelW+1)
        print("高高高:\(TH1)")
        let trainingIntro = UILabel(frame: CGRectMake(8, NameY+20*13, labelW, TH1))
        trainingIntro.text = "培训经历:\(workerdetail.trainingIntro)"
        trainingIntro.textColor = UIColor.blackColor()
        trainingIntro.font = UIFont.systemFontOfSize(14)
        //保留整个单词
//        trainingIntro.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //保留整个字符
        //trainingIntro.lineBreakMode = NSLineBreakMode.ByCharWrapping
        //以边界为止
        trainingIntro.lineBreakMode = NSLineBreakMode.ByClipping
        trainingIntro.numberOfLines = 0
        scrollView.addSubview(trainingIntro)
        let trainingYH = CGFloat(NameY+20*14+TH1)
        
        //所获奖项
        //计算文字的高度
         text = workerdetail.servantHonors
         statusLabelText = text
        let statusLabelSize2 = statusLabelText.sizeWithAttributes([NSFontAttributeName:font])
        //        println("文字的高度:\(statusLabelSize.height)")
        //        println("文字的宽度:\(statusLabelSize.width)")
        
        //根据高度设LabelFrame
        let H2 = statusLabelSize2.height
        let W2 = statusLabelSize2.width
        let TH2 = H2*(W2/labelW+1)
        let servantHonors = UILabel(frame: CGRectMake(8, trainingYH+4, labelW, TH2))
        servantHonors.text = "所获奖项:\(workerdetail.servantHonors)"
        servantHonors.textColor = UIColor.blackColor()
        servantHonors.font = UIFont.systemFontOfSize(14)
        servantHonors.lineBreakMode = NSLineBreakMode.ByCharWrapping
        servantHonors.numberOfLines = 0
        scrollView.addSubview(servantHonors )
        
        let Honors = CGFloat(trainingYH+TH2+4)
        //工作介绍
        //计算文字的高度
        text = workerdetail.servantIntro
        statusLabelText = text
        let statusLabelSize3 = statusLabelText.sizeWithAttributes([NSFontAttributeName:font])
        //        println("文字的高度:\(statusLabelSize.height)")
        //        println("文字的宽度:\(statusLabelSize.width)")
        
        //根据高度设LabelFrame
        let H3 = statusLabelSize3.height
        let W3 = statusLabelSize3.width
        let TH3 = H3*(W3/labelW+1)

        let servantIntro = UILabel(frame: CGRectMake(8, Honors+4, labelW, TH3))
        //level.text = detailItem.facilitatorLevel
        servantIntro.text = "工作介绍:\(workerdetail.servantIntro)"
        servantIntro.textColor = UIColor.blackColor()
//        servantIntro.lineBreakMode = NSLineBreakMode.ByCharWrapping
        servantIntro.lineBreakMode = NSLineBreakMode.ByWordWrapping
        servantIntro.numberOfLines = 0
        servantIntro.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(servantIntro)
        let servantintroYH = CGFloat(Honors+TH3+8)

        //是否住家
        let isStayHome = UILabel(frame: CGRectMake(8, servantintroYH, labelW, 20))
        //level.text = detailItem.facilitatorLevel
        if workerdetail.isStayHome {
            isStayHome.text = "是否住家:住家"
        }else {
            isStayHome.text = "是否住家:不住家"
        }
        //isStayHome.text = "是否住家:\(workerdetail.isStayHome)"
        isStayHome.textColor = UIColor.blackColor()
        isStayHome.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(isStayHome)
        
        //每月休息天数
        let holidayInMonth = UILabel(frame: CGRectMake(8, servantintroYH+20, labelW, 20))
        //level.text = detailItem.facilitatorLevel
        holidayInMonth.text = "每月休息天数:\(workerdetail.holidayInMonth)天"
        holidayInMonth.textColor = UIColor.blackColor()
        holidayInMonth.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(holidayInMonth)
        //人员星级
        let servantScore = UILabel(frame: CGRectMake(8, servantintroYH+40, labelW, 20))
        servantScore.text = "人员评分:\(workerdetail.servantScore)分"
        servantScore.textColor = UIColor.blackColor()
        servantScore.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(servantScore)
        
       
        
        
        let  comment = UIButton(frame:CGRectMake( width-158,servantintroYH+40,150,30))
        comment .setTitle("查看客户评价", forState:UIControlState.Normal)
        comment.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        comment.titleLabel?.font = UIFont.systemFontOfSize(14)
        comment.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        comment.showsTouchWhenHighlighted = true
        comment.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(comment)
        comment.addTarget(self , action:Selector("tapped1:"), forControlEvents: UIControlEvents.TouchUpInside)

       
        //星级图片
//        let servantScoreImg = UIImageView(frame: CGRectMake(78, servantintroYH+42, 80, 16))
//        servantScoreImg.image = imageForRank(workerdetail.servantScore)
//        scrollView.addSubview(servantScoreImg)
        //服务次数
//        var serviceCount = UILabel(frame: CGRectMake(8, servantintroYH+60, labelW, 20))
//        serviceCount.text = "服务次数:\(workerdetail.serviceCount)次"
//        serviceCount.textColor = UIColor.blackColor()
//        serviceCount.font = UIFont.systemFontOfSize(14)
//        scrollView.addSubview(serviceCount)
        //职业头衔
        let careerType = UILabel(frame: CGRectMake(8, servantintroYH+60, labelW, 20))
        careerType.text = "职业头衔:\(workerdetail.careerType)"
        careerType.textColor = UIColor.blackColor()
        careerType.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(careerType)
        //服务项目
        //计算文字的高度
        text = workerdetail.serviceItems
        statusLabelText = text
        let statusLabelSize4 = statusLabelText.sizeWithAttributes([NSFontAttributeName:font])
        //根据高度设LabelFrame
        let H4 = statusLabelSize4.height
        let W4 = statusLabelSize4.width
        let TH4 = H4*(W4/labelW+1)
        let serviceItems = UILabel(frame: CGRectMake(8, servantintroYH+80, labelW, TH4))
        serviceItems.text = "服务项目:\(workerdetail.serviceItems)"
        serviceItems.textColor = UIColor.blackColor()
        serviceItems.lineBreakMode = NSLineBreakMode.ByWordWrapping
        serviceItems.numberOfLines = 0
        serviceItems.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(serviceItems)
        
        let clientClick = UILabel(frame: CGRectMake(8, servantintroYH+90+TH4, labelW, 20))
        clientClick.text = "浏览数量:\(workerdetail.clientClick)"
        clientClick.textColor = UIColor.blackColor()
        clientClick.lineBreakMode = NSLineBreakMode.ByWordWrapping
        clientClick.numberOfLines = 0
        clientClick.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(clientClick)
        
//        //交流按钮
          let CBY = servantintroYH+150+TH4
//        comunication = UIButton(frame:CGRectMake(30, CBY,100,30))
//        comunication! .setTitle("在线交流", forState:UIControlState.Normal)
//        comunication!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        comunication!.titleLabel?.font = UIFont.systemFontOfSize(15)
//        //title的位置
//        comunication!.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
//        //点击是否亮
//        comunication!.showsTouchWhenHighlighted = true
//        //圆角
//        comunication?.layer.cornerRadius = 5
//        comunication!.backgroundColor = UIColor.orangeColor()
//        scrollView.addSubview(comunication!)
//        comunication!.addTarget(self , action:Selector("comunication"), forControlEvents: UIControlEvents.TouchUpInside)
        //预定按钮
        yuyue = UIButton(frame:CGRectMake(width/2-125, CBY,250,30))
        yuyue! .setTitle("立即预定", forState:UIControlState.Normal)
        yuyue!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        yuyue!.titleLabel?.font = UIFont.systemFontOfSize(15)
        yuyue!.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        yuyue!.showsTouchWhenHighlighted = true
        yuyue?.layer.cornerRadius = 5
        yuyue!.backgroundColor = UIColor.orangeColor()
        if workerdetail.servantStatus == "1"{
            yuyue.hidden = true
            yuyue.enabled = false
        }else{
            yuyue.enabled = true
            yuyue.hidden = false
        }

        scrollView.addSubview(yuyue!)
        yuyue!.addTarget(self , action:Selector("yuding:"), forControlEvents: UIControlEvents.TouchUpInside)
        scrollView.contentSize = CGSizeMake(width,CBY+120)
        print(scrollView.bounds.height)
    }
    
    
    override func viewDidLayoutSubviews() {
//        scrollView.frame = CGRectMake(0, 64, self.view.frame.width, self.view.frame.height)
    }
    // 星级图片
    func imageForRank(rank:String) -> UIImage? {
        switch rank {
        case "1":
            return UIImage(named: "1")
        case "2":
            return UIImage(named: "2")
        case "3":
            return UIImage(named: "3")
        case "4":
            return UIImage(named: "4")
        case "5":
            return UIImage(named: "5")
        default:
            return nil
        }
    }
    

//在线交流的跳转函数
    func  tapped1(comment:UIButton){
        
        self.performSegueWithIdentifier("toComment", sender: self)
    }
    
    
    //收藏的函数传数据函数
    func collect(collect:UIButton){
        
        //考事业编
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        
        if customerid == "" ||  loginPassword == "" {
//            let alert =  UIAlertView(title: "", message: "登录后才能收藏哦!", delegate: self, cancelButtonTitle: "确定")
//            alert.show()
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("LoginVC") as! UIViewController
            self.presentViewController(vc, animated: true, completion: nil)


            
        }else {
            
        isCollect = GetServantCollect(workerdetail.servantID,  customerid) as String
        if isCollect == "no"{
            print("nonono\(workerdetail.servantName)")
        let response = addSCollection(customerid,  workerdetail.servantID,  workerdetail.servantName)
            
            if response == "Success"{
                let alert =  UIAlertView(title: "收藏成功", message: "", delegate: self, cancelButtonTitle: "确定")
                alert.show()
                collect.setTitle("取消收藏", forState: UIControlState.Normal)
                isCollect  = "yes"
            } else if response == "Failed"{
                
                let alert =  UIAlertView(title: "收藏失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }
        }else if isCollect == "yes"{
            
            let response = deleteSCollection(customerid, workerdetail.servantID)
            if response == "Success"{
                let alert =  UIAlertView(title: "取消成功", message: "", delegate: self, cancelButtonTitle: "确定")
                alert.show()
                collect.setTitle("收藏", forState: UIControlState.Normal)
                isCollect  = "no"
                
            } else if response == "Failed"{
                
                let alert =  UIAlertView(title: "取消失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }

           }
         }
    }
//    //立即预订的跳转函数
    func yuding(yuyue:UIButton){
        
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        if customerid != "" && loginPassword != ""{
            self.performSegueWithIdentifier("toOrder", sender: self)
        }else {
//            let alert =  UIAlertView(title: "", message: "登录后才能预定哦!", delegate: self, cancelButtonTitle: "确定")
//            alert.show()
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("LoginVC") as! UIViewController
            self.presentViewController(vc, animated: true, completion: nil)

        }

    }
    
    //导航条详情
    func reply (){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func onMakeNavitem() -> UINavigationItem{
        print("创建导航条servant")
        //创建一个导航项
        let navigationItem = UINavigationItem()
        //创建左边按钮
        let leftButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "reply")
        //var leftButton =  UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Bordered, target: self, action: "reply")
        //导航栏的标题
        navigationItem.title = "人员详情"
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        
        navigationBar?.pushNavigationItem(navigationItem, animated: true)
        
        
        return navigationItem
    }
//    //预定的传参函数
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("去预定啦")
        if segue.identifier! == "toOrder" {
            let controller = segue.destinationViewController as! OrderDetailVC
            let  object = workerdetail
            controller.ServantDetail = object
            
        }else if segue.identifier! == "toComment"{
            
            let controller = segue.destinationViewController as! CommentVC
            let  object = workerdetail.servantID
            controller.servantID = object
        }
     
    }
    
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        let userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
            customerid = userDefaultes.stringForKey("customerID")!
            loginPassword = userDefaultes.stringForKey("loginPassword")!
            
        }
        
    }
    
    override func  viewWillAppear(animated: Bool) {
         readNSUerDefaults()
        
        if customerid != "" && loginPassword != "" {
            isCollect = GetServantCollect(workerdetail.servantID, customerid) as String
            
            print("isCollect:\(isCollect)")
        }
        
         print( "调用了吗")
        if isCollect == "yes" {
            collect.setTitle("取消收藏", forState: UIControlState.Normal)
        }else {
            collect.setTitle("收藏", forState: UIControlState.Normal)
        }
        print( "是什么情况")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



