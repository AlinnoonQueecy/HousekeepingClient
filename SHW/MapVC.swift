//
//  MapVC.swift
//  SHW
//
//  Created by Zhang on 15/9/27.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class MapVC: UIViewController,BMKMapViewDelegate,BMKLocationServiceDelegate{
    //声明导航条
    var navigationBar : UINavigationBar?
    
    
    
    /// 百度地图视图
    var mapView: BMKMapView!
    var i = 0
    /// 定位服务
    var locationService: BMKLocationService!
    /// 当前用户位置
    var userLocation: BMKUserLocation!
    //属性
    var pointAnnotation: BMKPointAnnotation!
    var animatedAnnotation: BMKPointAnnotation!
    var annotationView:BMKAnnotationView!
    var polygon: BMKPolygon!
    var polygon2: BMKPolygon!
    var popview:UIView!
    var la:CLLocationDegrees = 0.0
    var lo:CLLocationDegrees = 0.0
    //数据
    var ServiceType:String = ""
    //声明一个数组ServantData来保存获取的信息
    var Data:[ServantInfo] = []
    
    var index:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = self.view.frame.width
        var height = self.view.frame.height
        //实例化导航条
        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, 64))
        self.view.addSubview(navigationBar!)
        print("创建导航条详情B")
        onMakeNavitem()
        readNSUerDefaults ()
        
        // 地图界面初始化
        mapView = BMKMapView(frame: CGRectMake(0, 64, width, self.view.frame.height-64))
         // mapView = BMKMapView(frame: self.view.frame)
         // mapView.setTranslatesAutoresizingMaskIntoConstraints(true)
      
        //self.view = mapView
        mapView.centerCoordinate = CLLocationCoordinate2DMake(la, lo)//初始位置
        mapView.zoomLevel = 11
        print("dingweibu")
        // 设置定位精确度，默认：kCLLocationAccuracyBest
        BMKLocationService.setLocationDesiredAccuracy(kCLLocationAccuracyBest)
        //指定最小距离更新(米)，默认：kCLDistanceFilterNone
        BMKLocationService.setLocationDistanceFilter(10)
        // 定位功能初始化
        locationService = BMKLocationService()
        print("开始定位")
        locationService.startUserLocationService()
        mapView.showsUserLocation = true //显示定位图层
        self.view.addSubview(mapView)
        // 创建地图视图约束
        var constraints = [NSLayoutConstraint]()
        constraints.append(NSLayoutConstraint(item: mapView, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: mapView, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: mapView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0))
        //constraints.append(NSLayoutConstraint(item: mapView, attribute: .Top, relatedBy: .Equal, toItem: navigationBar, attribute: .Bottom, multiplier: 1, constant: 8))
        self.view.addConstraints(constraints)
    }
    
    
    
    //导航条详情
    func reply (){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func onMakeNavitem() -> UINavigationItem{
        print("创建导航条step1b")
        //创建一个导航项
        let navigationItem = UINavigationItem()
        //创建左边.右边按钮
        let leftButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "reply")
        
        
        
        let rightButton =  UIBarButtonItem(title: "返回列表", style: UIBarButtonItemStyle.Bordered, target: self, action: "reply")
        //导航栏的标题
        navigationItem.title = "找附近"
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        navigationItem.setRightBarButtonItem(rightButton, animated: true)
        navigationBar?.pushNavigationItem(navigationItem, animated: true)
        return navigationItem
    }
    
    
    
    // MARK: - 添加覆盖物操作
    
 
    
//    /// 添加标注
    func addPointAnnotation() {
//                pointAnnotation = BMKPointAnnotation()
//                var coordinator = CLLocationCoordinate2DMake(la, lo)
//                pointAnnotation.coordinate = coordinator
//                pointAnnotation.title = "测试标注"
//                pointAnnotation.subtitle = "这个标注大头针可以被拖曳！"
//                mapView.addAnnotation(pointAnnotation)
        
//        
//        var test = ["0","1","2","3","4"]
        var  servantData = Data
        let n = Data.count
        
        for i = 0 ;i<n;i++  {
            
            pointAnnotation = BMKPointAnnotation()
//            var n = Double(i)*0.1
//            var coordinator = CLLocationCoordinate2DMake(Double(n)+la, lo)
            let coordinator = CLLocationCoordinate2DMake(servantData[i].registerLatitude, servantData[i].registerLongitude)
            pointAnnotation.coordinate = coordinator
            pointAnnotation.title = servantData[i].servantName
            pointAnnotation.subtitle = "星级:\(servantData[i].servantScore)"
            mapView.addAnnotation(pointAnnotation)
            //mapView.selectAnnotation(pointAnnotation, animated: true)
            //这样就可以在初始化的时候将 气泡信息弹出
            let aview = mapView.viewForAnnotation(pointAnnotation)
            aview.tag = i
            
        }
        
        
    }
//
////    /// 添加动画标注
    func addAnimatedAnnotation() {
        print("添加动画标注")
        animatedAnnotation = BMKPointAnnotation()
        let coordinator = CLLocationCoordinate2DMake(la, lo)
        animatedAnnotation.coordinate = coordinator
        animatedAnnotation.title = "动画标注"
        animatedAnnotation.subtitle = "我漂亮不?"
        mapView.addAnnotation(animatedAnnotation)
    }
    
    // MARK: - 覆盖物相应协议实现
    func mapView(mapView: BMKMapView!, viewForOverlay overlay: BMKOverlay!) -> BMKOverlayView! {
        if (overlay as? BMKCircle) != nil {
            let circleView = BMKCircleView(overlay: overlay)
            circleView.fillColor = UIColor.redColor().colorWithAlphaComponent(0.5)
            circleView.strokeColor = UIColor.blueColor().colorWithAlphaComponent(0.5)
            circleView.lineWidth = 5
            
            return circleView
        }
        
        if (overlay as? BMKPolyline) != nil {
            let polylineView = BMKPolylineView(overlay: overlay)
            polylineView.strokeColor = UIColor.blueColor().colorWithAlphaComponent(1)
            polylineView.lineWidth = 20
            polylineView.loadStrokeTextureImage(UIImage(named: "texture_arrow.png"))
            
            return polylineView
        }
        
        if (overlay as? BMKPolygon) != nil {
            let polygonView = BMKPolygonView(overlay: overlay)
            polygonView.strokeColor = UIColor.purpleColor().colorWithAlphaComponent(1)
            polygonView.fillColor = UIColor.cyanColor().colorWithAlphaComponent(0.2)
            polygonView.lineWidth = 2
            polygonView.lineDash = (overlay as! BMKPolygon == polygon2)
            
            return polygonView
        }
        
        if (overlay as? BMKGroundOverlay) != nil {
            let groundView = BMKGroundOverlayView(overlay: overlay)
            
            return groundView
        }
        
        if (overlay as? BMKArcline) != nil {
            let arclineView = BMKArclineView(overlay: overlay)
            arclineView.strokeColor = UIColor.blueColor()
            arclineView.lineDash = true
            arclineView.lineWidth = 6
            
            return arclineView
        }
        return nil
    }
//
//    // MARK: - 覆盖物协议设置
//    // 根据标注生成对应的视图
//    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
//        // 普通标注
//        if annotation as! BMKPointAnnotation == pointAnnotation {
//            var AnnotationViewID = "renameMark"
//            annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(AnnotationViewID) as BMKAnnotationView?
//            if annotationView == nil {
//                annotationView = BMKAnnotationView(annotation: annotation, reuseIdentifier: AnnotationViewID)
//                // 设置颜色
//                //                annotationView!.pinColor = UInt(BMKPinAnnotationColorPurple)
//                //                // 从天上掉下的动画
//                //                annotationView!.animatesDrop = true
//                //                // 设置可拖曳
//                //                annotationView!.draggable = true
//                //设置气泡
//                popview = UIView(frame: CGRectMake(0, 0, 140, 100))
//                //设置气泡图片
//                var image = UIImageView()
//                image.image = UIImage(named: "poi_2")
//                image.frame = CGRectMake(0, 0, 50, 50);
//                popview.addSubview(image)
//                //自定义显示的内容
//                var test = ["0","1","2","3","4"]
//                var label = UILabel(frame: CGRectMake(50, 0, 90, 60))
//                label.text = test[i]
//                label.backgroundColor = UIColor.greenColor()
//                popview.addSubview(label)
//                //                annotationView.image =
//                //                var pView = BMKActionPaopaoView()
//                //                pView = BMKActionPaopaoView(customView: popview)
//                //                pView.frame =  CGRectMake(0, 0, 100, 60);
//                //                annotationView!.paopaoView = nil
//                //                annotationView!.paopaoView = pView
//                //                annotationView!.canShowCallout = true
//                popview.tag = i
//                println("开始转换图片")
//                annotationView.image = getImageFromView(popview)
//                image.tag = i
//               // println(popview.frame.width)
//                annotationView.canShowCallout = false
//                annotationView.tag = i
//            }
//            return annotationView
//        }
//        
//        if annotation as! BMKPointAnnotation == animatedAnnotation {
//            // 动画标注
//            var AnnotationViewID = "AnimatedAnnotation"
//            var annotationView: AnimatedAnnotationView? = nil
//            
//            if annotationView == nil {
//                annotationView = AnimatedAnnotationView(annotation: annotation, reuseIdentifier: AnnotationViewID)
//            }
//             var images = Array(count: 3, repeatedValue: UIImage())
//            for i in 1...3 {
//                var image = UIImage(named: "poi_\(i).png")
//                images[i-1] = image!
//            }
//            annotationView?.setImages(images)
//            return annotationView
//        }
//        return nil
//    }
    
    
    func getImageFromView(view:UIView)->UIImage{
        print("转换图片")
        UIGraphicsBeginImageContext(view.bounds.size);
        print(view.bounds.size)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        var image1 = UIImage()
        image1 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image1
    }
    // 当点击annotation view弹出的泡泡时，调用此接口
    func mapView(mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
        print("点击了泡泡~")
          print(view.tag)
        
        index = view.tag
        self.performSegueWithIdentifier("MapTo", sender: self)

        
        
    }
    func mapView(mapView: BMKMapView!, didSelectAnnotationView view: BMKAnnotationView!) {
        print("点击了标注")
        let content = view.tag
        print("\(view.annotation.coordinate.latitude)")
        print("\(view.annotation.coordinate.latitude)")
        print("标注的tag:\(content)")
        //根据经纬度得到该annotation的信息
        
    }
    // 地图初始化完毕的设置
    func mapViewDidFinishLoading(mapView: BMKMapView!) {
       // mapView.removeOverlays(mapView.overlays)
       // mapView.removeAnnotations(mapView.annotations)
        // 添加内置覆盖物
       // addOverlayView()
      // addPointAnnotation()
       // addAnimatedAnnotation()
    }
    
    // MARK: - 定位协议实现
    
    // 在地图将要启动定位时，会调用此函数
    func willStartLocatingUser() {
        print("启动定位……")
    }
    
    // 用户位置更新后，会调用此函数
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        mapView.updateLocationData(userLocation)
        mapView.centerCoordinate = userLocation.location.coordinate
        self.userLocation = userLocation
        print("目前位置：\(userLocation.location.coordinate.latitude), \(userLocation.location.coordinate.longitude)")
        la = userLocation.location.coordinate.latitude
        lo = userLocation.location.coordinate.longitude
        print("经纬度:\(la)")
         addPointAnnotation()
         //addAnimatedAnnotation()
    }
    
    // 用户方向更新后，会调用此函数
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        mapView.updateLocationData(userLocation)
        print("目前朝向:\(userLocation.heading)")
    }
    
    // 在地图将要停止定位时，会调用此函数
    func didStopLocatingUser() {
        print("关闭定位")
    }
    
    // 定位失败的话，会调用此函数
    func didFailToLocateUserWithError(error: NSError!) {
        print("定位失败！")
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("跳转传递数据")
        if segue.identifier=="MapTo"{
                let  object = Data[index]
                print("人员详情")
                (segue.destinationViewController as! workerViewController).workerdetail = object
                print("人员详情")
            }
        }


    
    
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        let userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("Longtitude")) != nil && (userDefaultes.stringForKey("Latitude")) != nil{
            la = userDefaultes.doubleForKey("Latitude")
            lo = userDefaultes.doubleForKey("Longtitude")
            
        }
        
    }
    // MARK: - 协议代理设置
    
    override func viewWillAppear(animated: Bool) {
        mapView.viewWillAppear()
        mapView.delegate = self  // 此处记得不用的时候需要置nil，否则影响内存的释放
        locationService.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        mapView.viewWillDisappear()
        mapView.delegate = nil  // 不用时，置nil
        locationService.delegate = nil
    }
    
    // MARK: - 内存管理
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
