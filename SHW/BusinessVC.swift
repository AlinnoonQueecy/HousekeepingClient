   //
//  BusinessVC.swift
//  SHW
//
//  Created by Zhang on 15/6/4.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class BusinessVC:  UIViewController,UITableViewDataSource,UITableViewDelegate,JSDropDownMenuDelegate,JSDropDownMenuDataSource,NSURLConnectionDataDelegate{
 
    
    
    var FirstType:String?//选择的大类
    //var SecondType:String?//会有的小类
    var status = true
    //声明导航条
    var navigationBar : UINavigationBar?
    //声明右边按钮
    var rightButton =  UIBarButtonItem()
    //声明label
    //var label :UILabel?
    //读取本地数据
    var customerid:String = ""
    var loginPassword:String = ""
    //声明地址
    var location:String = ""
    //声明一个去一口价的BUtton
    var writing = UIButton()
    //change by LZF
     var data12:[String] = []
    var data1:[String] = ["区域不限"]
    var data11:[String] = [""]
     var data21:[String] = []//存类型
    var data3 = []
    var data31 = []
    var currentData1Index : Int = 0
    var currentData2Index : Int = 0
    var currentData3Index : Int = 0
    var isPerson =  1 //声明点击店家还是人员
    var facilitatorCounty = ""//区域筛选
    var SecondType = ""//会有的小类
    var attributeName = "" //排序
    var upDown = "asc"
    //存储类型数据
    var serviceTypeData:[ServiceType]=[]
    var data2:[String] = []//存类型
    var Person:[String] = []
    //筛选和排序
    var column0 = 0
    var  row0   =  0
    var column1 = 1
    var  row1  = 0
    var column2 = 2
    var  row2  = 0
    var  n = 0
    @IBOutlet weak var businessTable: UITableView!
    //声明一个数组ServantData来保存获取的信息
     var ServantData:[ServantInfo] = []
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            let width = self.view.frame.width
            let height = self.view.frame.height
            businessTable.dataSource = self
            businessTable.delegate = self
        //实例化导航条
        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, 64))
        navigationBar?.barTintColor = UIColor.orangeColor()
        navigationBar?.translucent = false
        navigationBar?.barStyle = UIBarStyle.Default
        let navigationTitleAttribute: NSDictionary = NSDictionary(objectsAndKeys: UIColor.whiteColor(), NSForegroundColorAttributeName)
        navigationBar?.titleTextAttributes =  navigationTitleAttribute as [NSObject: AnyObject]
        self.view.addSubview(navigationBar!)
        print("创建导航条详情B")
        onMakeNavitem()
            //读取本地存储的地址
            readNSUerDefaults()
        //类别
        println("FirstType")
           println(FirstType)
            serviceTypeData = refreshServiceType(FirstType!) as![ServiceType]
        
            for var i = 0;i < serviceTypeData.count;i++ {
            data2 += [serviceTypeData[i].typeName] // 小类名称
            
            }
            //data2 = ["月嫂","保姆","钟点工"]
            SecondType  = data2[row1]
            saveNSUerDefaults ()
        
            ServantData = refreshServant(SecondType,attributeName,upDown,facilitatorCounty) as! [ServantInfo]
            isPerson =  1
            data3 = ["默认排序","人员星级","服务次数"]
            data31 = ["","servantScore","serviceCount"]
            writing.enabled = true
            writing.hidden = false
            
      
 
 
        //change by LZF
          //data1 = ["区域不限","和平区","大东区","沈河区","皇姑区","铁西区","浑南区","于洪区","沈北新区","苏家屯区","新民市","辽中县","康平县","法库县"]
        
           println("location\(location)")
          data12 = queryCounty(location) as! [String]
          data1 += data12
//          println(data1)
          //data11 = ["","和平区","大东区","沈河区","皇姑区","铁西区","浑南区","于洪区","沈北新区","苏家屯区","新民市","辽中县","康平县","法库县"]
        data11 += data12
 
        
        let menu = JSDropDownMenu(origin: label.frame.origin, andHeight: label.frame.size.height)
        menu.indicatorColor = UIColor(red: 175.0/255.0, green: 175.0/255.0, blue: 175.0/255.0, alpha: 1.0)
        menu.separatorColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        menu.textColor = UIColor(red: 83.0/255.0, green: 83.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        menu.dataSource = self;
        menu.delegate = self;
        label.removeFromSuperview()
        self.view.addSubview(menu)
        
        writing = UIButton(frame: CGRect(x: width-100, y: height-70, width: 100, height:50))
        let background  = UIImage(named: "u4")
        writing.setBackgroundImage(background, forState: UIControlState.Normal)
        writing.setTitle("发布需求", forState: UIControlState.Normal)
        writing.titleLabel?.font = UIFont.systemFontOfSize(16)
        //writing.titleLabel!.textAlignment =  NSTextAlignment.Left
        //设置按钮中Title的位置
        writing.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        writing.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 10, 10);
        writing.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        writing.showsTouchWhenHighlighted = true
        writing.addTarget(self , action: Selector("Order"), forControlEvents: UIControlEvents.TouchUpInside)
      
        
        self.view.addSubview(writing)
        
        }
    
    override func viewDidLayoutSubviews() {
        let width = self.view.frame.width
        businessTable.frame =  CGRectMake(0, 100, width, self.view.frame.height-100)
    }
    
    
        //-------------------Table view data source-----------------------------
        // 根据indexPath(section,row)创建每行cell及其内容
 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //            //创建cell
                    print("创建cell")
                    let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
    
                        let business = ServantData[indexPath.row] as ServantInfo
                        cell.name.text = business.servantName //名称
        
                        //网络地址获取图片
                        //1.定义一个地址字符串常量
                       let imageUrlString:String = HttpData.http+"/NationalService/\(business.headPicture)"
                        //2.通过String类型，转换NSUrl对象
                       let url:NSString = imageUrlString.URLEncodedString()
                         cell.picture.setZYHWebImage(url as String, defaultImage: "122.jpg")
        
                        cell.address.text = business.servantGender
                        cell.officePhone.text = "\(business.servantScore)分"
                        cell.businessArea.text = "\(business.workYears)年"
                        cell.dizhi.text = "性别:"
                        cell.dianhua.text = "人员评分:"
                        cell.quyu.text = "从业年限:"
                         return cell
    }
    
    
    func Order (){
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        if customerid != "" && loginPassword != ""{
            self.performSegueWithIdentifier("toOrder", sender: self)
        }else {
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("LoginVC") as! UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
    }
    
    //导航条详情
    func reply (){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    func  map(){
        
        self.performSegueWithIdentifier("toMap", sender: self)
    }

    
    func onMakeNavitem() -> UINavigationItem{
        print("创建导航条step1b")
        //创建一个导航项
        let navigationItem = UINavigationItem()
        
        //创建左边.右边按钮
        let leftButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "reply")
          leftButton.tintColor = UIColor.whiteColor()
        var btn = UIButton(frame:CGRectMake(0, 0, 40, 40))
        btn.setBackgroundImage(UIImage(named: "map"), forState: UIControlState.Normal)
        btn.addTarget(self, action: "map", forControlEvents: UIControlEvents.TouchUpInside)
        //var rightButton =  UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Bordered, target: self, action: "map")
        var rightButton = UIBarButtonItem(customView: btn)

        
       
//        rightButton =  UIBarButtonItem(title: "地图", style: UIBarButtonItemStyle.Bordered, target: self, action: "selection")
        //导航栏的标题
        navigationItem.title = "人员列表"
        
        //导航栏的标题
//        let titleL = UILabel(frame: CGRectMake(0, 0, self.view.frame.width, 30))
//        titleL.text = "人员列表"
//        titleL.textColor = UIColor.whiteColor()
//        titleL.textAlignment = NSTextAlignment.Center
//        navigationItem.titleView = titleL
//        navigationItem.titleView?.frame = CGRectMake(0, 0,self.view.frame.width, 30)
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        navigationItem.setRightBarButtonItem(rightButton, animated: true)
        navigationBar?.pushNavigationItem(navigationItem, animated: true)
        return navigationItem
    }
 
 
        // Return the number of sections.
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1;//HttpData.channelTitles.count
        }
        
        // Return the number of rows in the section.
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         var  count = 0
     
            //返回人员数量作为表格的行数
        count =   ServantData.count;
 
        return count
        
    }
    
  
    

        
        //-------------------Table view delegate-----------------------------
        //cell响应事件
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         
                 self.performSegueWithIdentifier("toServantDetail", sender: self)
            
        }

 
    
    //change by LZF
    func numberOfColumnsInMenu(menu: JSDropDownMenu!) -> Int
    {
        return 3
    }
    
    func displayByCollectionViewInColumn(column: Int) -> Bool
    {
        return false;
    }
    
    func haveRightTableViewInColumn(column: Int) -> Bool
    {
        return false;
    }
    
    func widthRatioOfLeftColumn(column: Int) -> CGFloat
    {
        return 1;
    }
    
    func currentLeftSelectedRow(column: Int) -> Int
    {
        if (column==0) {
            
            return currentData1Index;
            
        }
        if (column==1) {
            
            return currentData2Index;
        }
        
        return 0;
    }
    
    func menu(menu: JSDropDownMenu!, numberOfRowsInColumn column: Int, leftOrRight: Int, leftRow: Int) -> Int {
        
        if (column==0) {
            return data1.count;
        } else if (column==1){
            
            return data2.count;
            
        } else if (column==2){
            
            return data3.count;
        }
        
        return 0;
    }
    
    func menu(menu: JSDropDownMenu!, titleForColumn column: Int) -> String! {
        
        switch (column) {
        case 0:
            return data1[0] as String
            break
        case 1:
            return data2[0] as String
            break
        case 2:
            return data3[0] as! String
            break
        default:
            return nil
            break
        }
    }
    
    func menu(menu: JSDropDownMenu!, titleForRowAtIndexPath indexPath: JSIndexPath!) -> String! {
        
        if (indexPath.column==0) {
            return data1[indexPath.row] as String
        } else if (indexPath.column==1) {
            
            return data2[indexPath.row] as String
            
        } else {
            
            return data3[indexPath.row] as! String
        }
    }
    //点击触发
 
    func menu(menu: JSDropDownMenu!, didSelectRowAtIndexPath indexPath: JSIndexPath!) {
        
        print("\(indexPath.column),\(indexPath.row)")
    
        if (indexPath.column == 0) {
            currentData1Index = indexPath.row
            column0 = 0
            row0   =  indexPath.row
            print("")
            
            
        } else if(indexPath.column == 1){
            
            currentData2Index = indexPath.row;
            row1   =  indexPath.row
            print("点击完了")
           
                data3 = ["默认排序","人员星级"]
                data31 = ["","servantScore"]

                rightButton.title = ""
                writing.enabled = true
                writing.hidden = false
                
        } else{
            currentData3Index = indexPath.row;
            row2   =  indexPath.row
        }
 
        facilitatorCounty = data11[row0] as String
        SecondType  = data2[row1]
        attributeName = data31[row2] as! String
        
        ServantData = refreshServant(SecondType,attributeName, upDown,facilitatorCounty) as! [ServantInfo]
        businessTable .reloadData()
        saveNSUerDefaults ()
  
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //保存数据到NSUerDefaults
    func saveNSUerDefaults () {
        //将数据全部存储到NSUerDefaults中
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //存储时，除了NSNumber类型使用对应的类型外，其他的都使用setObject:forKey:
        print("保存本地")
     
        userDefaults.setObject( SecondType, forKey: "ServiceType")
        //建议同步到磁盘，但不是必须得
        userDefaults.synchronize()
    }

    
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        let userDefaultes = NSUserDefaults.standardUserDefaults()
        println("customerid\(customerid)")
        println(userDefaultes.stringForKey("customerID"))
        println(userDefaultes.stringForKey("loginPassword"))
          println("loginPassword\(customerid)")
        if  (userDefaultes.stringForKey("customerID") != nil) && (userDefaultes.stringForKey("loginPassword") != nil){
            customerid = userDefaultes.stringForKey("customerID")!
            
            loginPassword = userDefaultes.stringForKey("loginPassword")!
            
        }
        if  (userDefaultes.stringForKey("location") != nil ){
        location = userDefaultes.stringForKey("location")!
        print("location\(location)")
        }
        
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         print("跳转传递数据")
        if segue.identifier=="toServantDetail"{
            if let indexPath = self.businessTable.indexPathForSelectedRow(){
                let  object = ServantData[indexPath.row]
                print("人员详情")
                (segue.destinationViewController as! workerViewController).workerdetail = object
                print("人员详情")
            }
        }else    if segue.identifier=="toMap"{
            
                let  object = SecondType
                let  Data = ServantData
          
                (segue.destinationViewController as! MapVC).ServiceType = object
               (segue.destinationViewController as! MapVC).Data = Data
      }
 //           else if segue.identifier=="toOrder"{
//            let  object = SecondType
//            let  Data = ServantData
//            
//           // (segue.destinationViewController as! OrderVC).ServiceType = object
//            (segue.destinationViewController as! OrderVC).servantData = Data
//
//            
//            }
     }
    
}
