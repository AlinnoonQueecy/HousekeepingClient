//////
//////  dingweiViewController.swift
//////  SHW
//////
//////  Created by Zhang on 15/7/13.
//////  Copyright (c) 2015年 star. All rights reserved.
//////
////
import UIKit
import CoreLocation



class getLocationController: UIViewController,CLLocationManagerDelegate {

    
    //声明导航条
    var navigationBar : UINavigationBar?
    var currLocation : CLLocation!
    //用于定位服务管理类，它能够给我们提供位置信息和高度信息，也可以监控设备进入或离开某个区域，还可以获得设备的运行方向
    var locationManager : CLLocationManager = CLLocationManager()
    var range:NSArray = []
    var  location:String = ""
    @IBOutlet var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = self.view.frame.width
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
        
        locationManager.delegate = self
        //设备使用电池供电时最高的精度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //精确到1000米,距离过滤器，定义了设备移动后获得位置信息的最小距离
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
        if self.locationManager.respondsToSelector("requestAlwaysAuthorization"){
            locationManager.requestAlwaysAuthorization()
            println("requestAlwaysAuthorization")
            
            
        }

        
        locationManager.startUpdatingLocation()
         print("定位开始1111")
      
    }
    
    //导航条详情
    func reply (){
       // self.dismissViewControllerAnimated(true, completion: nil)
        self.performSegueWithIdentifier("toLocation", sender: self)
    }
 
    
    
    func onMakeNavitem() -> UINavigationItem{
        print("创建导航条step1b")
        //创建一个导航项
        let navigationItem = UINavigationItem()
        //创建左边.右边按钮
        let leftButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "reply")

        //rightButton.title = "好吧"
        //导航栏的标题
        navigationItem.title = "选择城市"
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        navigationBar?.pushNavigationItem(navigationItem, animated: true)
        
        
        return navigationItem
    }

    
    //    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    //        if status ==  CLAuthorizationStatus.NotDetermined || status == CLAuthorizationStatus.Denied{
    //            //允许使用定位服务
    //            //开始使用定位服务
    //            locationManager.startUpdatingLocation()
    //                println("定位开始1111")
    //
    //        }
    //    }
    override func viewWillAppear(animated: Bool) {
        
        locationManager.startUpdatingLocation()
        
    }
    
//        override func viewWillDisappear(animated: Bool) {
//            locationManager.stopUpdatingLocation()
//            println("定位结束")
//        }
    
    
 
    func  locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    
        
        //获取最新坐标
        currLocation = locations.last as! CLLocation
        
       if (currLocation.horizontalAccuracy > 0) {
            locationManager.stopUpdatingLocation()
        
            var longitude = currLocation.coordinate.longitude
            var latitude = currLocation.coordinate.latitude
        
        
            var url = NSURL(string:"http://gc.ditu.aliyun.com/regeocoding?l=\(longitude),\(latitude)&type=100")
        
 
            var data = NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingUncached, error: nil)
            var   str = NSString(data: data! ,encoding: NSUTF8StringEncoding)
        
       
            var json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil)
        
            var test2: AnyObject?=json!.objectForKey("addrList")
    
            let jsonArray = test2 as? NSArray
        
        
            var count = jsonArray?.count
            var pictureName:String = ""
            for value in jsonArray!{
            
             pictureName  =  value.objectForKey("admName") as! String
           
        
                var city :String
               
            //将字符串切割成数组
            if pictureName != "" {
                
            range = pictureName.componentsSeparatedByString(",")
        
      
            if range[0] as! String == "上海市"||range[0] as! String == "北京市"||range[0] as! String == "重庆市"||range[0] as! String == "天津市"||range[0] as! String == "香港特别行政区"||range[0] as! String == "澳门特别行政区" {
                city = self.range[0] as! String
                
                let index = advance(city.endIndex, -1);
                
                
                self.location = city.substringToIndex(index)
                println("location:\(location)")
                
                //            self.location = self.range[0] as! String
            }else {
                city = self.range[1] as! String
                
                let index = advance(city.endIndex, -1);
                
                
                self.location = city.substringToIndex(index)
                println("location:\(location)")
                //                    self.location = self.range[1] as! String
                }
            }else {
                println("我是空的")
                self.location = "沈阳"
                }

                saveNSUerDefaults()
                label.text = location
                
        }
      }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print(error)
        if let  clErr = CLError(rawValue: error.code) {
            switch clErr {
            case .LocationUnknown:
                print("位置不明")
            case .Denied :
                print("允许检索位置被拒绝")
            case .Network:
                print("用于检索位置的网络不可用")
            default:
                print("未知的位置错误")
            }
            
        } else {
            print ("其他错误")
            let alert = UIAlertView (title: "提示信息", message: "定位失败", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //保存数据到NSUerDefaults
    func saveNSUerDefaults () {
        //将数据全部存储到NSUerDefaults中
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //存储时，除了NSNumber类型使用对应的类型外，其他的都使用setObject:forKey:
        userDefaults.setObject( location, forKey: "location")
        //建议同步到磁盘，但不是必须得
        userDefaults.synchronize()
    }

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//   
//            if segue.identifier == "toLocation"{
//        
//            let controller = segue.destinationViewController as! MainVC
//            var object = location
//            controller.location = object
//        }
//        
//    }



}
