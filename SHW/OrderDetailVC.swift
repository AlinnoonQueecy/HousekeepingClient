////
////  OrderDetailVC.swift
////  SHW
////
////  Created by Zhang on 15/7/31.
////  Copyright (c) 2015年 star. All rights reserved.
////
//
import UIKit
//人员预订界面
class OrderDetailVC: UIViewController,UITextFieldDelegate,UIAlertViewDelegate,NSURLConnectionDataDelegate,UIScrollViewDelegate,BMKGeoCodeSearchDelegate,UIPickerViewDataSource,UIPickerViewDelegate{

    
    var pageHeight = 1300
    
    //声明导航条
    var navigationBar : UINavigationBar?
    //声明ScrollView
    //var scrollView :UIScrollView?
//    //声明上个界面传递的数据
    var ServantDetail:ServantInfo!
    //读取本地数据
    var customerid:String =  ""
    var loginPassword:String = ""
       //声明传递的参数
    var facilitatorid:String = ""
    //声明Button
    var yuyue:UIButton?
    //声明
    var text:String = ""
    var statusLabelText:NSString = ""
    var ServiceType = ""
    //声明页面其他控件
    //var servicePicture:UIImage?
    var itemName:UILabel?
    var serviceTypeL:UILabel?
    var itemIntro:UILabel?
    var priceDescription:UILabel?
    //有可能为空的控件
//    var customerN:UILabel?
    var servantName: UILabel?
    var servantID :UILabel?
    var customerName = UITextField()
    var salary = UITextField()
    var serviceCounty = UITextField()
    var dizhi = UITextField()
    var serviceTime = UITextField()
    var dianhua = UITextField()
    var beizhu = UITextView()
    
     var scrollView = UIScrollView()
    //获取网络数据
    var myinfo:MyInfo!
    var width:CGFloat!
    var orderY = CGFloat()
    var customerInfoY = CGFloat()
    var CBY = CGFloat()
    
    //经纬度
    var serviceLongitude:Double!
    var serviceLatitude:Double!
    /// 地理位置编码
    var geocodeSearch: BMKGeoCodeSearch!
   
    //选择的城市和地区
    var  selectprovince:String!
    var selectcity:String!
    var  selectcounty:String!
    
    var datePicker: UIDatePicker!
    var Date:String!
    var pickview:UIPickerView!
    
    var root:NSArray = []
    var provinces:NSArray = []
    var  dictionary1:NSDictionary!
    var province:String = ""
    var cities:NSArray = []
    var areas:NSArray = []
 
    
      override func viewDidLoad() {
        super.viewDidLoad()
        print("OrderdetailVC")
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        //初始化数据
        myinfo = QueryInfo(customerid) as MyInfo
         width = self.view.frame.width
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
        print("创建导航条详情")
        onMakeNavitem()
        
        
        scrollView.delegate = self
        // 地理编码器初始化
        geocodeSearch = BMKGeoCodeSearch()
        
        
        //1、创建手势实例，并连接方法UITapGestureRecognizer,点击手势
        let recognizer =  UITapGestureRecognizer(target:self, action:"touchScrollView:")
        print("touchScrollView")
        
           //设置手势点击数,点1下
        recognizer.numberOfTapsRequired = 1
        
        //recognizer.numberOfTouchesRequired = 1
        
        scrollView.addGestureRecognizer(recognizer)
        NSNotificationCenter.defaultCenter().addObserver(self,selector:Selector("keyboardWillShow:"),name:UIKeyboardWillShowNotification,object:nil)
        NSNotificationCenter.defaultCenter().addObserver(self,selector:Selector("keyboardWillHide:"),name:UIKeyboardWillHideNotification,object:nil)
        //添加scrollview
//        var scrollView = UIScrollView()
        //scrollView.bounds = self.view.bounds
        scrollView.frame = CGRectMake(0,64,width,height)
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
        
        //订单信息
        let orderY = CGFloat(0)
        let order = UIButton(frame: CGRectMake(15, orderY, width-30, 30))
        order.setTitle("预定信息", forState: UIControlState.Normal)
        order.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        order.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        order.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
        order.titleLabel?.font = UIFont.systemFontOfSize(17)
        scrollView.addSubview(order)

        let facilitatorID = UILabel(frame: CGRectMake(15, orderY+35, labelW, 25))
        facilitatorID.text = "服务人员ID:\(ServantDetail.servantID) "
        facilitatorID.textColor = UIColor.blackColor()
        facilitatorID.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(facilitatorID)
     
        let servantName1 = UILabel(frame: CGRectMake(15, orderY+35+25, labelW, 25))
        servantName1.text = "服务人员名字:\(ServantDetail.servantName)"
        servantName1.textColor = UIColor.blackColor()
        servantName1.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(servantName1)
        
        //服务项目
        let itemName = UILabel(frame: CGRectMake(15, orderY+35+2*25, labelW, 25))
        itemName.text = "服务项目:\(ServiceType)"
        itemName.textColor = UIColor.blackColor()
        itemName.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(itemName)
        //薪水
        let salaryLabel = UILabel(frame: CGRectMake(15, orderY+35+3*25, 80, 25))
        salaryLabel.text = "服务费用:"
        salaryLabel.textColor = UIColor.blackColor()
        salaryLabel.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(salaryLabel)
        
        salary = UITextField(frame: CGRectMake(80, orderY+35+3*25, 100, 30))
        salary.borderStyle = UITextBorderStyle.RoundedRect
        //salary.clearButtonMode=UITextFieldViewMode.WhileEditing
 
        salary.enabled = false
        salary.text = HttpData.salary
        scrollView.addSubview(salary)
        
        let yuan = UILabel(frame: CGRectMake(180, orderY+40+3*25, 20, 25))
        yuan.text = "元"
        yuan.textColor = UIColor.blackColor()
        yuan.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(yuan)

        let conditionB = UIButton(frame: CGRectMake(200,orderY+40+3*25, 80, 25))
        conditionB.setTitle("选择条件", forState: UIControlState.Normal)
        conditionB.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        conditionB.titleLabel?.font = UIFont.systemFontOfSize(17)
        conditionB.addTarget(self, action: "selectCondition:", forControlEvents: UIControlEvents.TouchUpInside)
        
        scrollView.addSubview(conditionB)
         customerInfoY  =  orderY+35+4*25+20
        let customerN = UILabel(frame: CGRectMake(15, customerInfoY, labelW, 25))
        customerN.text = "客户姓名:"
        customerN.textColor = UIColor.blackColor()
        customerN.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(customerN)
        customerName = UITextField(frame: CGRectMake(80, customerInfoY, width-90, 30))
        customerName.borderStyle = UITextBorderStyle.RoundedRect
        customerName.clearButtonMode=UITextFieldViewMode.WhileEditing
        //编辑时出现清除按钮
        customerName.text = myinfo.customerName
        scrollView.addSubview(customerName)
        

        let quyu = UILabel(frame: CGRectMake(15, customerInfoY+35, 80, 25))
        quyu.text = "所在区域:"
        quyu.textColor = UIColor.blackColor()
        quyu.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(quyu)
        
        
        pickview = UIPickerView(frame: CGRectMake(0,300, self.view.frame.width, 300))
        //添加ToolBar（可以不要）
        
        let f = pickview.frame
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, f.width, (f.height * 0.15)))
        var buttons = [UIBarButtonItem]()
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        buttons.append(space)
        let doneButton = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.Plain, target: self, action: "donePressed")
        buttons.append(doneButton)
        toolbar.setItems(buttons, animated: false)

//        provinces = ["沈阳市":["和平区","大东区","沈河区","皇姑区","铁西区","浑南区","于洪区","沈北新区","苏家屯区","新民市","辽中县","康平县","法库县"]]
//        cities = provinces.values.array[0]
//        println("cities:\(cities)")
        pickview = UIPickerView()
        pickview.delegate = self
        pickview.dataSource = self
        let listPath  = NSBundle.mainBundle().pathForResource("area.plist", ofType: nil)
        //第一层
        
        root =  NSMutableArray(contentsOfFile:listPath!)!//root
        
        dictionary1 = root.objectAtIndex(0) as! NSDictionary//item0
        //第二层
        
        cities = dictionary1.objectForKey("cities") as! NSArray
        
        let dictionary2:NSDictionary =  cities.objectAtIndex(0) as! NSDictionary
        //第三层
        
        areas = dictionary2.objectForKey("areas") as! NSArray

        serviceCounty = UITextField(frame: CGRectMake(80, customerInfoY+35, width-90, 30))
        serviceCounty.borderStyle = UITextBorderStyle.RoundedRect
        serviceCounty.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        serviceCounty.minimumFontSize=12
        serviceCounty.clearButtonMode=UITextFieldViewMode.WhileEditing
        //编辑时出现清除按钮
       
        serviceCounty.inputView = pickview
        selectprovince = myinfo.customerProvince
        selectcity = myinfo.customerCity
        selectcounty = myinfo.customerCounty
        serviceCounty.text = "\(selectprovince)省 \(selectcity)市 \(selectcounty)"
        serviceCounty.inputAccessoryView = toolbar
        scrollView.addSubview(serviceCounty)


         servantID = UILabel(frame: CGRectMake(15, customerInfoY+70, 80, 25))
        servantID!.text = "详细地址:"
        servantID!.textColor = UIColor.blackColor()
        servantID!.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(servantID!)
        
        dizhi = UITextField(frame: CGRectMake(80, customerInfoY+70, width-90, 30))
        dizhi.borderStyle = UITextBorderStyle.RoundedRect
        dizhi.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        dizhi.minimumFontSize=12

        dizhi.clearButtonMode=UITextFieldViewMode.WhileEditing
        //编辑时出现清除按钮
        dizhi.text = myinfo.contactAddress
        scrollView.addSubview(dizhi)
        
        
        
        let  time = UILabel(frame: CGRectMake(15, customerInfoY+105, 80, 25))
        time.text = "服务时间:"
        time.textColor = UIColor.blackColor()
        time.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(time)
        
        // 初始化 datePicker
        datePicker = UIDatePicker(frame: CGRectMake(0,300, self.view.frame.width, 300))
        // 设置样式，当前设为同时显示日期
        datePicker.datePickerMode = UIDatePickerMode.DateAndTime
        // datePicker.hidden = true
        datePicker.locale = NSLocale(localeIdentifier: "zh_CN")
        // 设置分钟表盘的时间间隔（必须能让60整除，默认是1分钟）
        datePicker.minuteInterval = 5
      
        // 设置默认时间
        datePicker.date = NSDate()
       
        serviceTime = UITextField(frame: CGRectMake(80, customerInfoY+105, width-90, 30))
        serviceTime.borderStyle = UITextBorderStyle.RoundedRect
        serviceTime.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        serviceTime.minimumFontSize=12
       
        serviceTime.clearButtonMode=UITextFieldViewMode.WhileEditing
        //编辑时出现清除按钮
        serviceTime.inputView = datePicker
        serviceTime.inputAccessoryView = toolbar
        scrollView.addSubview(serviceTime)

        
        let serviceType = UILabel(frame: CGRectMake(15, customerInfoY+140, 80, 25))
        serviceType.text = "联系电话:"
        serviceType.textColor = UIColor.blackColor()
        serviceType.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(serviceType)
        dianhua = UITextField(frame: CGRectMake(80, customerInfoY+140, width-90, 30))
        dianhua.text = myinfo.phoneNo
        dianhua.borderStyle = UITextBorderStyle.RoundedRect
        dianhua.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        dianhua.minimumFontSize=12

        dianhua.clearButtonMode=UITextFieldViewMode.WhileEditing
        //编辑时出现清除按钮
        scrollView.addSubview(dianhua)
    
        //备注
        let remark = UILabel(frame: CGRectMake(15, customerInfoY+175,50, 20))
        remark.text = "备注:"
        remark.textColor = UIColor.blackColor()
        remark.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(remark)
        
        beizhu = UITextView(frame: CGRectMake(80, customerInfoY+175,width-90, 80))
        //字体
        beizhu.font = UIFont.systemFontOfSize(15)
        beizhu.textColor = UIColor.blackColor()
        
        //边框粗细
        beizhu.layer.borderWidth = 0.2
        //边框颜色
        beizhu.layer.borderColor = UIColor.grayColor().CGColor
        //圆角
        beizhu.layer.cornerRadius = 5
        //是否可以滚动
        beizhu.scrollEnabled = true
        //自适应高度
        beizhu.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        //使文本框在界面打开时就获取焦点，并弹出输入键盘
        //        ReasonField.becomeFirstResponder()
        //使文本框失去焦点，并收回键盘
        beizhu.resignFirstResponder()
        //键盘形式
        beizhu.keyboardType = UIKeyboardType.Twitter
        scrollView.addSubview(beizhu)
        //预定按钮
         CBY = customerInfoY+215+80
        yuyue = UIButton(frame:CGRectMake(width/2-125, CBY,250,30))
        yuyue! .setTitle("确认预订", forState:UIControlState.Normal)
        yuyue!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        yuyue!.titleLabel?.font = UIFont.systemFontOfSize(15)
        yuyue!.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        yuyue!.showsTouchWhenHighlighted = true
        yuyue?.layer.cornerRadius = 5
        yuyue!.backgroundColor = UIColor.orangeColor()
        scrollView.addSubview(yuyue!)
        yuyue!.addTarget(self , action:Selector("yuding:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //scrollView.contentSize = CGSizeMake(width,64+CBY+30+253)
        scrollView.contentSize = CGSizeMake(width,64+CBY+50)
        print(scrollView.bounds.height)
        
        
    }
    func selectCondition(conditionB:UIButton){
        
        self.performSegueWithIdentifier("ToCondition", sender: self)
        
    }
    //toolBar 的函数
    func donePressed() {
        serviceTime.resignFirstResponder()
        

        // NSDate转化NSString
        let s = datePicker.date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        Date = dateFormatter.stringFromDate(s)
        
        print("Date\(Date)")
        serviceTime.text = "\(Date)"
        
        serviceCounty.resignFirstResponder()
         serviceCounty.text = "\(selectprovince)省 \(selectcity)市 \(selectcounty)"
        
        
    }
    //设置列数
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    //设置行数
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            
            return root.count
        }
        
        
        if component == 1 {
         
            return cities.count
       
        }
 
        if component == 2 {
            
            return areas.count
            
        }
        
        return 0
        
        
    }
    
    //设置每行具体内容（titleForRow 和 viewForRow 二者实现其一即可）
    
    func  pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            //return month[row]
            //return provinces.keys.array[row]
            return root[row].objectForKey("state") as? String
        }
        
        if component == 1{
            //return week[row]
            return cities[row].objectForKey("city") as? String
            
        }
        if component == 2{
            //return week[row]
            return areas[row] as? String
            
        }
        return nil

    }
    
    //选中行的操作
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        
        if(component == 0){
            
            dictionary1 = root.objectAtIndex(row) as! NSDictionary//item0
            //第二层
            
            
            cities = dictionary1.objectForKey("cities") as! NSArray
            
            // 重新加载二级选项并复位
            
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            
            let dictionary2:NSDictionary =  cities.objectAtIndex(0) as! NSDictionary
            
            areas = dictionary2.objectForKey("areas") as! NSArray
            
            // 重新加载三级选项并复位
            
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
        }
        
        if(component == 1){
            
            let dictionary2:NSDictionary =  cities.objectAtIndex(row) as! NSDictionary
            
            areas = dictionary2.objectForKey("areas") as! NSArray
            
            // 重新加载三级选项并复位
            
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
            
            
            
        }
        let provinceNum = pickview.selectedRowInComponent(0)
        let cityNum = pickview.selectedRowInComponent(1)
        
        let areaNum = pickview.selectedRowInComponent(2)
        
        let pr: AnyObject? = root[provinceNum].objectForKey("state")
        let cit:AnyObject? = cities[cityNum].objectForKey("city")
        
        
        selectprovince = pr as! String
        selectcity = cit as! String
        if areas != []{
            selectcounty = areas[areaNum] as! String
        }
    }
    

    
    
    
    //预定的跳转函数
    func yuding(yuyue:UIButton){
        
        if dizhi.text == "" || !verifyPhoneNumber(dianhua.text)||serviceCounty.text == ""||serviceTime.text == ""||customerName.text == ""||salary.text == "" {
            let alert =  UIAlertView(title: "", message: "请填写完整", delegate: self, cancelButtonTitle: "确定")
             // alert.tag = 1
            alert.show()
        }else if salary.text == "0" {
        let alert =  UIAlertView(title: "", message: "请选择条件!", delegate: self, cancelButtonTitle: "确定")
            alert.show()
  
        }else {
            
            
            var geocodeSearchOption = BMKGeoCodeSearchOption()
            geocodeSearchOption.city = selectcity
           geocodeSearchOption.address = selectcounty + dizhi.text
            print("dizhi:\(geocodeSearchOption.address)")
            var flag = geocodeSearch.geoCode(geocodeSearchOption)
            if flag {
                print("geo 检索发送成功！")
            }else {
                print("geo 检索发送失败！")
            }
        
         
        }
    }
    func  alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 1{
        self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        //self.performSegueWithIdentifier("OrderServantTo", sender: self)
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
        leftButton.tintColor = UIColor.whiteColor()

        //var leftButton =  UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Bordered, target: self, action: "reply")
        //导航栏的标题
        navigationItem.title = "订单详情"
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
            print("OrderDetailVC\(customerid)")
            loginPassword = userDefaultes.stringForKey("loginPassword")!
                  print("OrderDetailVC\(loginPassword)")
        }
        
          ServiceType = userDefaultes.stringForKey("ServiceType")!
    }
    
  
    // MARK: - 地理解码相关协议实现
    //
    func onGetGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
         print("地理编码")
        if error.value == 0 {
            var item = BMKPointAnnotation()
            item.coordinate = result.location
            item.title = result.address
            serviceLatitude = item.coordinate.latitude
            serviceLongitude = item.coordinate.longitude
            print("La:\(serviceLatitude)")
              print("Long:\(serviceLongitude)")
 
        }
        let serverResponse = QureyDeclare(customerid, customerName.text, ServantDetail.servantID,ServantDetail.servantName, dianhua.text, serviceTime.text,selectprovince, selectcity, selectcounty, dizhi.text,"\(serviceLongitude)", "\(serviceLatitude)", salary.text, ServiceType, beizhu.text,"1")
        
        if serverResponse == "Success"{
            
            let alert =  UIAlertView(title: "预定成功", message: "服务人员会尽快与您取得联系!", delegate: self, cancelButtonTitle: "确定")
            alert.tag = 1
            alert.show()
            
            
        }else if serverResponse == "Failed"{
            
            let alert =  UIAlertView(title: "预定失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
            //alert.tag = 1
            alert.show()
            
        }else if serverResponse == "NotSuccess"{
            
            let alert =  UIAlertView(title: "预定失败", message: "服务人员忙碌，暂时不能预订", delegate: self, cancelButtonTitle: "确定")
            alert.tag = 1
            alert.show()
            
        }

    }

    func touchScrollView(sender: UITapGestureRecognizer){
        print("取消键盘2")
//        self.view.resignFirstResponder()
        scrollView.endEditing(true)
//        self.view.endEditing(true)
    }
    func keyboardWillShow(sender:NSNotification){
        scrollView.contentSize = CGSizeMake(width,64+CBY+50+253)
        
    }
    func keyboardWillHide(sender:NSNotification){
        scrollView.contentSize = CGSizeMake(width,64+CBY+50)
        
    }
    override func viewWillAppear(animated: Bool) {
   
        geocodeSearch.delegate = self
        
        salary.text = HttpData.salary
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        geocodeSearch.delegate = nil
    }
    

 
  }
