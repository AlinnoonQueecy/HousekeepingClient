////
////  MainVC.swift
////  生活网/Users/zhang/Desktop/ Learn IOS/生活网/生活网/CollectionViewController.swift
////
////  Created by Zhang on 15/5/17.
////  Copyright (c) 2015年 Zhang. All rights reserved.
////
//
//import UIKit
////import CoreLocation
//
//
//class MainVCBeifen: UIViewController , UITableViewDelegate,
//UIScrollViewDelegate,UIAlertViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate{
//    
//    //用于定位服务管理类，它能够给我们提供位置信息和高度信息，也可以监控设备进入或离开某个区域，还可以获得设备的运行方向
//    //    var locationManager : CLLocationManager = CLLocationManager()
//    //    var currLocation : CLLocation!
//    //    var imgLabel = UILabel()
//    var urlSelected:String = ""
//    var titleOfState:String = ""
//    var AdvertiseDatas:[HomeAdvertise]=[]
//    var range:NSArray = []
//    var location:String = "当前城市"
//    
//    var customerid:String =  ""
//    var loginPassword:String = ""
//    
//    //var scrollView:UIScrollView!
//    //IB控件绑定
//    
//    @IBOutlet weak var scrollView: UIScrollView!
//    
//    
//    @IBOutlet weak var ButtonScroll: UIScrollView!
//    
//    
//    @IBOutlet weak var pageCtrl: UIPageControl!
//    
//    @IBOutlet weak var lead: UILabel!
//    
//    // @IBOutlet weak var LocationB: UIButton!
//    
//    
//    //@IBOutlet weak var tianqi: UIButton!
//    @IBOutlet weak var shouye: UILabel!
//    //  @IBOutlet weak var lead: UIView!
//    //详细界面属性
//    var detailView:UIView!
//    var webView:UIWebView!
//    var LocationB = UIButton()
//    var _data:NSData?
//    var imageUrlString:NSString?
//    //   var imgView = UIButton()
//    var img:UIImage?
//    /// 定位服务
//    var locationService: BMKLocationService!
//    /// 当前用户位置
//    var userLocation: BMKUserLocation!
//    /// 地理位置编码
//    var geocodeSearch: BMKGeoCodeSearch!
//    //初始化
//    //    var width:CGFloat = 0
//    //    var  height :CGFloat = 0
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let width = self.view.bounds.width
//        let  height = self.view.bounds.height
//        
//        
//        // 定位功能初始化
//        locationService = BMKLocationService()
//        // 设置定位精确度，默认：kCLLocationAccuracyBest
//        BMKLocationService.setLocationDesiredAccuracy(kCLLocationAccuracyBest)
//        
//        //指定最小距离更新(米)，默认：kCLDistanceFilterNone
//        BMKLocationService.setLocationDistanceFilter(10)
//        
//        locationService.startUserLocationService()
//        // 地理编码器初始化
//        geocodeSearch = BMKGeoCodeSearch()
//        
//        
//        AdvertiseDatas = refreshAdvertise() as! [HomeAdvertise]
//        print("advertise:\(AdvertiseDatas)")
//        print("ad:\(AdvertiseDatas.count)")
//        //读取用户信息，如果不是第一次登录，则会自动登录
//        readNSUerDefaults()
//        let  FirstTypeData = refreshParentType("")
//        
//        //
//        let leadheight = height*0.11
//        _ = height*0.27
//        let pageCtrly = height*0.35
//        let pageCtrlheight = 37
//        let ButtonScrolly = pageCtrly + CGFloat(pageCtrlheight)-5
//        //
//        //        var lastheight = height*0.09
//        
//        
//        let tianqi = UIButton(frame: CGRect(x: 50, y: leadheight-35, width: 30, height:30))
//        self.view.addSubview(tianqi)
//        
//        //self.scrollView = UIScrollView(frame: CGRectMake(0, leadheight, bounds.width, bounds.height*0.245))
//        //1.设置图片UIScrollView
//        //scrollView.contentSize =  CGSize(width: bounds.width * CGFloat(range.count), height: bounds.height*0.27)
//        scrollView.contentSize =  CGSize(width: width * CGFloat(AdvertiseDatas.count), height:height*0.27)
//        scrollView.pagingEnabled = true  //设true时，会按页滑动
//        scrollView.bounces = false  //取消UIScrollView的弹性属性，这个可以按个人喜好来定
//        scrollView.delegate = self //UIScrollView的delegate函数在本类中定义
//        scrollView.showsHorizontalScrollIndicator = false//因为我们使用UIPageControl表示页面进度，所以取消UIScrollView自己的进度条。
//        
//        LocationB = UIButton(frame: CGRect(x: 20, y: leadheight-30, width: 100, height:23))
//        LocationB.titleLabel?.font = UIFont.systemFontOfSize(15)
//        LocationB.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
//        LocationB.setTitle(location, forState: UIControlState.Normal)
//        LocationB.addTarget(self, action: "toLocation:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(LocationB)
//        
//        
//        
//        //2.设置图片滚动
//        
//        print("图片")
//        for var i = 0; i < AdvertiseDatas.count; i++ {
//            //    for var i = 0; i <  HttpData.imgArray.count; i++ {
//            print("数目：\(AdvertiseDatas.count)")
//            
//            let imgView:UIButton = UIButton(frame: CGRect(x: width*CGFloat(i), y:0, width: width, height:width*0.45) )
//            
//            //网络地址获取图片
//            //1.定义一个地址字符串常量
//            imageUrlString = HttpData.http+"/NationalService/\(AdvertiseDatas[i].advertisePicture)"
//            ////            //2.通过String类型，转换NSUrl对象
//            
//            let url:NSString = imageUrlString!.URLEncodedString()
//            let data = getImageData(url as String)
//            if data == nil{
//                img = UIImage(named: HttpData.imgArray[i])
//                
//            }else{
//                img = UIImage(data: data!)
//            }
//            imgView.setBackgroundImage(img, forState: UIControlState.Normal)
//            
//            
//            scrollView.addSubview( imgView )
//            //imgView.addTarget(self, action:"clickImg:" , forControlEvents: UIControlEvents.TouchUpInside)
//            
//            
//        }
//        //
//        //        //3.添加图片标题
//        var imgLabel = UILabel()
//        imgLabel = UILabel(frame: CGRect(x:0, y: leadheight+height*0.27-35, width:width, height: 30))
//        //imgLabel = UILabel(frame: CGRect(x:width*CGFloat(i), y: width*0.45, width:width, height: 30))
//        imgLabel.backgroundColor = UIColor.whiteColor()
//        imgLabel.alpha = 0.5
//        imgLabel.text = AdvertiseDatas[0].advertiseTopic
//        //self.view.addSubview(imgLabel)
//        
//        
//        
//        
//        //4.创建UIPageControl
//        //pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 400, bounds.size.width, 30)];  //创建UIPageControl，位置在屏幕最下方。
//        pageCtrl.numberOfPages = AdvertiseDatas.count;//总的图片页数
//        pageCtrl.currentPage = 0; //当前页
//        pageCtrl.pageIndicatorTintColor = UIColor.grayColor()
//        // pageCtrl.currentPageIndicatorTintColor = UIColor.redColor()
//        pageCtrl.addTarget(self, action:"pageTurn:" ,forControlEvents:UIControlEvents.ValueChanged) //用户点击UIPageControl的响应函数
//        //[self.view addSubview:pageCtrl];  //将UIPageControl添加到主界面上。
//        //5.设置定时器（滑动切换图片）
//        _ = NSTimer.scheduledTimerWithTimeInterval(3.5, target: self, selector: "timerFireMethod:", userInfo: nil, repeats:true);
//        
//        
//        //创建buttonScroll
//        //ButtonScroll.contentSize = CGSize(width: width, height:height )
//        ButtonScroll.pagingEnabled = false
//        ButtonScroll.delegate = self
//        ButtonScroll.showsHorizontalScrollIndicator = false
//        ButtonScroll.showsVerticalScrollIndicator = false
//        ButtonScroll.bounces = false
//        //ButtonScroll.contentInset = UIEdgeInsetsMake(0, 0, -, 0)
//        self.automaticallyAdjustsScrollViewInsets = false
//        
//        
//        //创建button
//        let button1C = UIColor  (red: 204/255, green: 255/255, blue: 0/255, alpha: 1.0)
//        let button2C = UIColor(red: 1.0, green: 153/255, blue: 102/255, alpha: 1.0)
//        let button3C = UIColor(red: 204/255, green: 204/255, blue: 255/255, alpha: 1.0)
//        let button4C = UIColor(red: 1.0, green: 153/255, blue: 153/255, alpha: 1.0)
//        let button5C = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1.0)
//        let button6C = UIColor(red: 255/255, green: 153/255, blue: 204/255, alpha: 1.0)
//        let button7C = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1.0)
//        let button8C = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
//        let button9C = UIColor(red: 102/255, green: 204/255, blue: 255/255, alpha: 1.0)
//        var color = [button1C,button2C,button3C,button4C,button5C,button6C,button7C,button8C,button9C]
//        //var terms = HttpData.maintwo.count
//        let terms = FirstTypeData.count
//        let width1 = (width-20)/3
//        let a = terms%3
//        // mainatwo的button
//        let BSH = height*0.53
//        
//        for var i = 0;i < terms;i++ {
//            let term1 = UIButton(frame: CGRectMake(8+(width+2)*CGFloat(i%3),CGFloat(i/3)*((BSH-4)/3+2), width1,(BSH-4)/3))
//            //                term1 .setTitle(HttpData.maintwo[i] as String, forState:UIControlState.Normal)
//            term1 .setTitle(FirstTypeData[i] as? String, forState:UIControlState.Normal)
//            term1.setTitleShadowColor(UIColor.whiteColor(),forState: UIControlState.Normal)
//            term1.backgroundColor = color[i]
//            term1.titleLabel?.font = UIFont.systemFontOfSize(16)
//            term1.showsTouchWhenHighlighted = true
//            term1.addTarget(self , action: Selector("tapped:"), forControlEvents: UIControlEvents.TouchUpInside)
//            ButtonScroll.addSubview(term1)
//        }
//        
//        if a == 0 {
//            // ButtonScroll.contentSize = CGSizeMake(self.view.frame.width, CGFloat(terms/3)*((ButtonScrollheight-4)/3+2))}
//            ButtonScroll.contentSize = CGSizeMake(width, CGFloat(terms/3)*((BSH-4)/3+2))}
//            
//        else{
//            ButtonScroll.contentSize = CGSizeMake(width, CGFloat(terms/3+1)*((BSH-4)/3+2))
//        }
//        
//        var buttontitle = ["我的发布","我的订单","我的收藏","我的信息"]
//        _ = ["mydingdan.png","collect.png","centeryuding.png","mydingdan.png","myinfo.png"]
//        let buttonheight = height - ButtonScrolly - BSH
//        let buttony = ButtonScrolly + BSH
//        for var i = 0;i < 4;i++ {
//            let term1 = UIButton(frame: CGRectMake(3+((width-14)/4+2)*CGFloat(i%4),buttony+2,(width-14)/4,buttonheight-4))
//            term1 .setTitle(buttontitle[i] as String, forState:UIControlState.Normal)
//            term1.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//            //term1.setTitleShadowColor(UIColor.whiteColor(),forState: UIControlState.Normal)
//            let color = UIColor  (red: 255/255, green: 127/255, blue: 27/255, alpha: 1.0)
//            term1.backgroundColor = color
//            term1.layer.cornerRadius = 5.0
//            //term1.setBackgroundImage(UIImage(named:buttonimage[i]), forState:UIControlState.Normal)
//            term1.titleLabel?.font = UIFont.systemFontOfSize(14)
//            term1.showsTouchWhenHighlighted = true
//            term1.addTarget(self , action: Selector("tapped:"), forControlEvents: UIControlEvents.TouchUpInside)
//            self.view.addSubview(term1)
//        }
//        
//        
//        
//        
//        
//    }
//    
//    
//    //    override func  viewDidLayoutSubviews() {
//    //        //var bounds:CGRect = self.view.frame
//    //        var a = height*0.11
//    //        var b = height*0.27
//    //        var c = a + b-height*0.03
//    //        var d = 37
//    //        var e = c + CGFloat(d)-5
//    //
//    //        var lastheight = height*0.09
//    //
//    //
//    //        lead.frame = CGRect(x: 0, y: 0, width:width, height: a)
//    //        shouye.frame = CGRectMake(width/2-20, a-30, 40, 23)
//    //        scrollView.frame = CGRectMake(0, a+2, width, height*0.27)
//    //        pageCtrl.frame = CGRectMake(width*0.25, c,width*0.5, CGFloat(d) )
//    //        ButtonScroll.frame = CGRectMake(0, e, width, height*0.53)
//    //
//    //
//    //
//    //
//    //    }
//    func toLocation(Location:UIButton){
//        print("怎么样了")
//        // self.performSegueWithIdentifier("toLocation", sender: self)
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc: AnyObject! = sb.instantiateViewControllerWithIdentifier("LocationVC") 
//        self.presentViewController(vc, animated: true, completion: nil)
//    }
//    
//    
//    // tapped函数，跳转
//    func tapped(term1:UIButton){
//        titleOfState = term1.titleForState(.Normal)!
//        //读取用户信息，如果不是第一次登录，则会自动登录
//        readNSUerDefaults()
//        print("标题\(titleOfState)")
//        //        if titleOfState == "我的收藏" || titleOfState == "我的订单"|| titleOfState == "我的预定"||  titleOfState == "我的信息"
//        //        {   if  customerid == "" || loginPassword == ""{
//        //            self.performSegueWithIdentifier("toLogin", sender: self)
//        //
//        //          }else{
//        if titleOfState == "我的收藏" {
//            if  customerid == "" || loginPassword == ""{
//                self.performSegueWithIdentifier("toLogin", sender: self)
//            }else {
//                
//                self.performSegueWithIdentifier("toCollection", sender: self)
//            }
//        }else if titleOfState == "我的订单"{
//            if  customerid == "" || loginPassword == ""{
//                self.performSegueWithIdentifier("toLogin", sender: self)
//            }else {
//                
//                self.performSegueWithIdentifier("tofinish", sender: self)
//                
//            }
//            
//        }else if titleOfState == "我的发布"{
//            if  customerid == "" || loginPassword == ""{
//                self.performSegueWithIdentifier("toLogin", sender: self)
//            }else {
//                
//                self.performSegueWithIdentifier("toorder", sender: self)
//                
//            }
//            
//        }else if titleOfState == "我的信息"{
//            
//            if  customerid == "" || loginPassword == ""{
//                self.performSegueWithIdentifier("toLogin", sender: self)
//                
//                
//            }else {
//                
//                self.performSegueWithIdentifier("toMyInfo", sender: self)
//            }
//            //          }else if titleOfState == "更多"{
//            //
//            //                let alert =  UIAlertView(title: "", message: "尚未开放，敬请期待!", delegate: self, cancelButtonTitle: "确定")
//            //                alert.show()
//            //
//            //
//            //
//        }else {
//            titleOfState = term1.titleForState(.Normal)!
//            let  serviceTypeData = refreshServiceType(titleOfState) as![ServiceType]
//            print("我点击的是:\(titleOfState)")
//            if serviceTypeData != [] {
//                self.performSegueWithIdentifier("toItem", sender: self)
//            }else {
//                let alert =  UIAlertView(title: "", message: "暂无数据，敬请期待!", delegate: self, cancelButtonTitle: "确定")
//                alert.show()
//                
//            }
//        }
//    }
//    
//    
//    //6.定时器函数
//    func timerFireMethod(timer: NSTimer) {
//        
//        //令UIScrollView做出相应的滑动显示
//        //self.pageCtrl.currentPage = (self.pageCtrl.currentPage+1)%AdvertiseDatas.count
//        // self.pageCtrl.currentPage = (self.pageCtrl.currentPage+1)%AdvertiseDatas.count
//        let viewSize:CGSize  = scrollView.frame.size
//        let rect:CGRect = CGRect(x:CGFloat(self.pageCtrl.currentPage)*viewSize.width , y: 0, width: viewSize.width, height: viewSize.height)
//        scrollView.scrollRectToVisible(rect , animated:true);
//        //imgLabel.text = AdvertiseDatas[pageCtrl.currentPage].advertiseTopic
//    }
//    //7.单击滚动图片事件
//    func clickImg( sender:UIButton) {
//        print( "clickImgView\(self.pageCtrl.currentPage)" )
//        //urlSelected = AdvertiseDatas[pageCtrl.currentPage].facilitatorID
//        
//        self.performSegueWithIdentifier("AdvertTo", sender: self)
//        //        webView.loadRequest(NSURLRequest(URL: NSURL(string: urlSelected)!))
//        //        self.view.addSubview(detailView)
//        //        toggleDetailView(show: true)
//    }
//    //    func toggleDetailView( #show:Bool ) {
//    //        var direction:CGFloat = 1
//    //        if show {
//    //            direction = -1
//    //        }
//    //        var bounds = self.view.frame
//    //        //self.detailView.transform = CGAffineTransformMakeTranslation(0, 0)//()(1.0f, 1.0f);//将要显示的view按照正常比例显示出来
//    //        UIView.beginAnimations(nil, context:nil)
//    //        UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)//:UIViewAnimationCurveEaseInOut]; //InOut 表示进入和出去时都启动动画
//    //        UIView.setAnimationDuration(0.3)//动画时间
//    //        self.detailView.transform=CGAffineTransformMakeTranslation(direction*bounds.width, 0);//先让要显示的view最小直至消失
//    //        //self.detailView.transform=CGAffineTransformMakeScale(0.8, 0.8)//(direction*bounds.width, 0);//先让要显示的view最小直至消失
//    //        //self.scrollView.transform=CGAffineTransformMakeTranslation(direction*bounds.width, 0)
//    //        UIView.commitAnimations() //启动动画
//    //        //相反如果想要从小到大的显示效果，则将比例调换
//    //        //UIGraphicsGetCurrentContext 里面东西很丰富。
//    //
//    //}
//    
//    
//    //-------------------Table view data source-----------------------------
//    // 根据indexPath(section,row)创建每行cell及其内容
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        //创建cell
//        let cellId:String = "cellId"
//        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier( cellId ) 
//        if cell == nil
//        {
//            cell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier: cellId)
//            cell?.textLabel?.font = UIFont(name: "Times New Roman", size: 13)
//        }
//        
//        return cell!
//    }
//    
//    // Return the number of sections.
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 0;//HttpData.channelTitles.count
//    }
//    
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier! == "toItem" {
//            
//            let controller = segue.destinationViewController as! BusinessVC
//            let object = titleOfState
//            controller.FirstType = object
//            print(controller.FirstType)
//            print("fffffff")
//            
//        }
//        //     else if segue.identifier! == "AdvertTo" {
//        //
//        //            let controller = segue.destinationViewController as! BusinessDVC
//        //            var object = urlSelected
//        //            controller.facilitatorid = object
//        //
//        //            println("fffffff")
//        //
//        //        }
//        
//    }
//    //从NSUerDefaults 中读取数据
//    func readNSUerDefaults () {
//        
//        let userDefaultes = NSUserDefaults.standardUserDefaults()
//        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
//            customerid = userDefaultes.stringForKey("customerID")!
//            loginPassword = userDefaultes.stringForKey("loginPassword")!
//            
//        }
//        print("location")
//        if  (userDefaultes.stringForKey("location")) != nil{
//            location = userDefaultes.stringForKey("location")!
//            
//            print(location)
//        }
//        
//    }
//    
//    
//    // 1.在地图将要启动定位时，会调用此函数
//    func willStartLocatingUser() {
//        print("启动定位……")
//    }
//    // 2.用户位置更新后，会调用此函数
//    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
//        
//        self.userLocation = userLocation
//        print("目前位置：\(userLocation.location.coordinate.longitude), \(userLocation.location.coordinate.latitude)")
//        let  Longtitude =  userLocation.location.coordinate.longitude
//        let  Latitude = userLocation.location.coordinate.latitude
//        let response = RefreshLocation(customerid, realLongitude: "\(Longtitude)", realLatitude: "\(Latitude)")
//        print("更新客户位置:\(response)")
//        //为地理反编码准备
//        var point = CLLocationCoordinate2DMake(0, 0)
//        
//        point = CLLocationCoordinate2DMake(Latitude, Longtitude)
//        
//        let unGeocodeSearchOption = BMKReverseGeoCodeOption()
//        unGeocodeSearchOption.reverseGeoPoint = point
//        let flag = geocodeSearch.reverseGeoCode(unGeocodeSearchOption)
//        if flag {
//            print("反 geo 检索发送成功")
//        }else {
//            print("反 geo 检索发送失败")
//        }
//        
//        locationService.stopUserLocationService()
//        
//    }
//    // 用户方向更新后，会调用此函数
//    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
//        
//    }
//    
//    // 在地图将要停止定位时，会调用此函数
//    func didStopLocatingUser() {
//        print("关闭定位")
//        
//    }
//    
//    // 定位失败的话，会调用此函数
//    func didFailToLocateUserWithError(error: NSError!) {
//        print("定位失败！")
//        
//    }
//    
//    
//    func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
//        print("进入编码状态2")
//        if error.rawValue == 0 {
//            
//            let city = result.addressDetail.city
//            print("city\(result.addressDetail.city)")
//            let index = city.endIndex.advancedBy(-1);
//            let location = city.substringToIndex(index)
//            LocationB.setTitle(location, forState: UIControlState.Normal)
//            //
//            //                        let alert =  UIAlertView(title:location, message:city, delegate: self, cancelButtonTitle: "确定")
//            //                        alert.show()
//            
//        }
//    }
//    
//    
//    
//    
//    //保存数据到NSUerDefaults
//    func saveNSUerDefaults () {
//        //将数据全部存储到NSUerDefaults中
//        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
//        //存储时，除了NSNumber类型使用对应的类型外，其他的都使用setObject:forKey:
//        userDefaults.setObject( location, forKey: "location")
//        //建议同步到磁盘，但不是必须得
//        userDefaults.synchronize()
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        //读取用户信息，如果不是第一次登录，则会自动登录
//        readNSUerDefaults()
//        locationService.delegate = self
//        geocodeSearch.delegate = self
//        
//    }
//    override func viewWillDisappear(animated: Bool) {
//        
//        locationService.delegate = nil
//        print("定位结束")
//        geocodeSearch.delegate = nil
//    }
//    
//}
