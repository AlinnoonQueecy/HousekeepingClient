//
//  CommonItemVC.swift
//  SHW
//
//  Created by Zhang on 15/7/21.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class CommonItemVC: UIViewController {
    
    var pageHeight = 1300
    
    //声明导航条
    var navigationBar : UINavigationBar?
    //读取本地数据
    var customerid:String = ""
    var loginPassword:String =  ""
    //声明ScrollView
    //var scrollView :UIScrollView?
    //声明上个界面传递的数据
    var CommonItem:serviceItemInfo!
    var CommonTitle:String!
    //声明传递的参数
    var facilitatorid:String!
    //声明Button
    var yuyue:UIButton?
    //声明
    var text:String = ""
    var statusLabelText:NSString = ""
    //存储类型数据
    var serviceTypeData:ServiceType?
    //声明页面其他控件
    //var servicePicture:UIImage?
    var itemName:UILabel?
    var serviceType:UILabel?
    var itemIntro:UILabel?
    var priceDescription:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        //初始化数据
        //CommonItemInfo = refreshServiceItemC(facilitatorid!) as! [serviceItemInfo]
         print("CommonItem.serviceTyp")
        print("\(CommonItem.serviceType)")

        //serviceTypeData = getServiceType(CommonItem.serviceType) as ServiceType
        
         print("\(CommonItem.serviceType)")
        let width = self.view.frame.width
        let height = self.view.frame.height
        let labelW = self.view.frame.width - 20
        
        //实例化导航条
        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, 64))
        navigationBar?.barTintColor = UIColor.orangeColor()
        navigationBar?.translucent = false
        navigationBar?.barStyle = UIBarStyle.Default
        let navigationTitleAttribute: NSDictionary = NSDictionary(objectsAndKeys: UIColor.whiteColor(), NSForegroundColorAttributeName)
        navigationBar?.titleTextAttributes =  navigationTitleAttribute as [NSObject: AnyObject]

        self.view.addSubview(navigationBar!)
        print("创建导航条详情commontitemVC")
        onMakeNavitem()

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
        
      //  服务图片
        let introimgY = CGFloat(20)
        let servicePicture = UIImageView(frame: CGRectMake(20, introimgY,width - 40, 200))
        //println("宽度\(self.view.frame.width)")
        //网络地址获取图片
        //1.定义一个地址字符串常量
//      
        let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/upload/service-type/\(serviceTypeData!.id)/\(serviceTypeData!.typeLogo)"
//             let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/upload/service/id/\(serviceTypeData!.typeLogo)"
        let url :NSURL = NSURL(string: imageUrlString)!
        print("url:\(url)")
        
//       
//        var data = getImageData(imageUrlString)
//        
//        if data == nil{
//            servicePicture.image = UIImage(named:"127.jpg")
//            
//        }else{
//            servicePicture.image = UIImage(data: data!)
//        }
        
        servicePicture.setZYHWebImage(imageUrlString, defaultImage: "127.jpg")
        scrollView.addSubview(servicePicture)
        
        //服务项目
        let itemNameY = introimgY + 180
//        itemName = UILabel(frame: CGRectMake(8, itemNameY, 300, 20))
//        itemName!.text = "服务项目:\(CommonItem!.serviceType)"
//        itemName!.textColor = UIColor.orangeColor()
//        itemName!.font = UIFont.systemFontOfSize(15)
//        scrollView.addSubview(itemName!)
        
        //服务类别
        serviceType = UILabel(frame: CGRectMake(8, itemNameY+20, labelW, 20))
        serviceType!.text = "服务类别:\(CommonItem.serviceType)"
        serviceType!.textColor = UIColor.blackColor()
        serviceType!.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(serviceType!)
       
        //项目介绍
        //计算文字的高度
        //text = CommonItemInfo.itemIntro
        statusLabelText = CommonItem!.itemIntro
        let font = UIFont.systemFontOfSize(14)
        let statusLabelSize1 = statusLabelText.sizeWithAttributes([NSFontAttributeName:font])
        
        //根据高度设LabelFrame
        let H1 = statusLabelSize1.height
        let W1 = statusLabelSize1.width
        let TH1 = H1*(W1/labelW+1)
        print("高高高:\(TH1)")
        itemIntro = UILabel(frame: CGRectMake(8, itemNameY+40, labelW, TH1))
        itemIntro!.text = "项目介绍:\(CommonItem!.itemIntro)"
        itemIntro!.textColor = UIColor.blackColor()
        itemIntro!.font = UIFont.systemFontOfSize(14)
        //保留整个单词
        itemIntro!.lineBreakMode = NSLineBreakMode.ByWordWrapping
        itemIntro!.numberOfLines = 0
        scrollView.addSubview(itemIntro!)
        let trainingYH = CGFloat(itemNameY+40+TH1)
        //价格
        priceDescription = UILabel(frame: CGRectMake(8, trainingYH+4, labelW, 20))
        priceDescription!.text = "价格:面议"
        priceDescription!.textColor = UIColor.blackColor()
        priceDescription!.font = UIFont.systemFontOfSize(14)
        scrollView.addSubview(priceDescription!)
        //预定按钮
        let CBY = trainingYH+44
        yuyue = UIButton(frame:CGRectMake(width/2-50, CBY,100,30))
        yuyue! .setTitle("立即预定", forState:UIControlState.Normal)
        yuyue!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        yuyue!.titleLabel?.font = UIFont.systemFontOfSize(15)
        yuyue!.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        yuyue!.showsTouchWhenHighlighted = true
        yuyue?.layer.cornerRadius = 5
        yuyue!.backgroundColor = UIColor.orangeColor()
        scrollView.addSubview(yuyue!)
        yuyue!.addTarget(self , action:Selector("yuding:"), forControlEvents: UIControlEvents.TouchUpInside)
    
        
        scrollView.contentSize = CGSizeMake(width,CBY+120)
        print(scrollView.bounds.height)
        

    }
    //预定的跳转函数
    func yuding(yuyue:UIButton){
        
        
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        
        if customerid != "" && loginPassword != ""{
            self.performSegueWithIdentifier("toOrderC", sender: self)
        }else {
//            let alert =  UIAlertView(title: "", message: "登录后才能预定哦!", delegate: self, cancelButtonTitle: "确定")
//            alert.show()
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("LoginVC") as! UIViewController
            self.presentViewController(vc, animated: true, completion: nil)

        }
 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        navigationItem.title = "项目详情"
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
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == "toOrderC" {
            let controller = segue.destinationViewController as! CommonOrder
            let  object = CommonItem
            controller.OrderData = object
      
       }
    }

}
