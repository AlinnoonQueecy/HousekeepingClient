//: Playground - noun: a place where people can play

import UIKit
import CoreLocation


////class dingweiViewController: UIViewController,CLLocationManagerDelegate {
//
//    
//    
//    var currLocation : CLLocation!
//    //用于定位服务管理类，它能够给我们提供位置信息和高度信息，也可以监控设备进入或离开某个区域，还可以获得设备的运行方向
//    var locationManager : CLLocationManager = CLLocationManager()
////    
////    override func viewDidLoad() {
////        super.viewDidLoad()
//        locationManager.delegate = self
//        //设备使用电池供电时最高的精度
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        //精确到1000米,距离过滤器，定义了设备移动后获得位置信息的最小距离
//        locationManager.distanceFilter = kCLLocationAccuracyKilometer
//        if self.locationManager.respondsToSelector("requestAlwaysAuthorization"){
//            locationManager.requestAlwaysAuthorization()
//            println("requestAlwaysAuthorization")
//            
//        }
//        
//        locationManager.startUpdatingLocation()
//    }
//    
//    
//    
//    //    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//    //        if status ==  CLAuthorizationStatus.NotDetermined || status == CLAuthorizationStatus.Denied{
//    //            //允许使用定位服务
//    //            //开始使用定位服务
//    //            locationManager.startUpdatingLocation()
//    //                println("定位开始1111")
//    //
//    //        }
//    //    }
//    override func viewWillAppear(animated: Bool) {
//        locationManager.startUpdatingLocation()
//        println("定位开始2222")
//    }
//    
//    //    override func viewWillDisappear(animated: Bool) {
//    //        locationManager.stopUpdatingLocation()
//    //        println("定位结束")
//    //    }
//    
//    
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
//        println("定位进行中1")
//        //获取最新坐标
//        currLocation = locations.last as! CLLocation
////        
////        if (currLocation.horizontalAccuracy > 0) {
//            locationManager.stopUpdatingLocation()
//            println("定位结束")
//            var longitude = currLocation.coordinate.longitude
//            var latitude = currLocation.coordinate.latitude
            var url = NSURL(string: "http://gc.ditu.aliyun.com/regeocoding?l=41.7675003,123.4178237&type=111")
                        var data = NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingUncached, error: nil)
            var   str = NSString(data: data! ,encoding: NSUTF8StringEncoding)
            println(str)            var json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil)
            
            //获取经度
            //            longitudeTxt.text = "\(currLocation.coordinate.longitude)"
            //            //获取纬度
            //            latitudeTxt.text = "\(currLocation.coordinate.latitude)"
            //            //获取海拔
//            //            HeightTxt.text = "\(currLocation.altitude)"
//        }
//        
//    }
//    
//    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
//        println(error)
//        if let  clErr = CLError(rawValue: error.code) {
//        switch clErr {
//        case .LocationUnknown:
//            println("位置不明")
//        case .Denied :
//            println("允许检索位置被拒绝")
//        case .Network:
//            println("用于检索位置的网络不可用")
//        default:
//            println("未知的位置错误")
//        }
//        
//    } else {
//        println ("其他错误")
//        let alert = UIAlertView (title: "提示信息", message: "定位失败", delegate: nil, cancelButtonTitle: "确定")
//        alert.show()
//        }
//    }
//    //地理信息反编译
//    //    @IBAction func reverseGeocode(sender: AnyObject) {
//    //        var geocoder = CLGeocoder()
//    //        var p:CLPlacemark?
//    //        geocoder.reverseGeocodeLocation(currLocation, completionHandler: { (placemarks, error) -> Void in
//    //
//    //        //强制成中文简体
//    //        var array = NSArray (object: "zh-hans")
//    //        NSUserDefaults.standardUserDefaults().setObject(array, forKey: "AppleLanguages")
//    //
//    //        //显示所有信息
//    //        if error != nil {
//    //        println("reverse geodcode fail: \(error.localizedDescription)")
//    //        return
//    //        }
//    //        let pm = placemarks as! [CLPlacemark]
//    //        if (pm.count > 0){
//    //        p = placemarks[0] as? CLPlacemark
//    //        println(p) //输出反编码信息
//    //    }else{
//    //        println("No Placemarks!")
//    //        }
//    //        })
//    //    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        
//    }
//    
//    
//}
//
