//
//  AppDelegate.swift
//  SHW
//
//  Created by star on 15/5/17.
//  Copyright (c) 2015年 star. All rights reserved.
//
import UIKit
import CoreData

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mapManager: BMKMapManager?
    //读取本地数据
    var customerid:String = ""
    var loginPassword:String = ""
   
 
//此方法是App第一次运行的时候被执行一次，每次从后台激活时不执行该方法.
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
 
//            self.window.rootViewController = 
        
        
        
        mapManager = BMKMapManager() // 初始化 BMKMapManager
        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
        
        let ret = mapManager?.start("W64DZGMGe8SaBFisH3vuiwtc", generalDelegate: nil)  // 注意此时 ret 为 Bool? 类型
        
        if !ret! {  // 如果 ret 为 false，先在后面！强制拆包，再在前面！取反
            NSLog("manager start failed!") // 这里推荐使用 NSLog，当然你使用 println 也是可以的
        }
        
        
        
        //注册服务器推送，请求用户授权
        let  version:String = UIDevice.currentDevice().systemVersion
        if (version as NSString).floatValue >= 8.0{
            application.registerUserNotificationSettings( UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert | UIUserNotificationType.Badge, categories: nil))
            println("//注册服务器推送，请求用户授权")
            
        }else{
            application.registerForRemoteNotificationTypes(UIRemoteNotificationType.Sound | UIRemoteNotificationType.Alert | UIRemoteNotificationType.Badge )
        }
        //放在登录
        if ( UIApplication . instancesRespondToSelector ( Selector ( "registerUserNotificationSettings:" ))) {
            application.registerUserNotificationSettings ( UIUserNotificationSettings (forTypes:  UIUserNotificationType.Sound |  UIUserNotificationType.Alert |  UIUserNotificationType.Badge, categories:  nil ))
        } else {
            application.registerForRemoteNotificationTypes(UIRemoteNotificationType.Sound | UIRemoteNotificationType.Alert | UIRemoteNotificationType.Badge )

        }
        //#warning 测试 开发环境 时需要修改BPushMode为BPushModeDevelopment 需要修改Apikey为自己的Apikey
         // 在 App 启动时注册百度云推送服务，需要提供 Apikey
        BPush.registerChannel(launchOptions, apiKey: "W64DZGMGe8SaBFisH3vuiwtc", pushMode: BPushMode.Development, withFirstAction: nil, withSecondAction: nil, withCategory: nil, isDebug: true)
        
        // App 是用户点击推送消息启动
        
        if (launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] != nil) {
        var userInfo = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? NSDictionary
    
        
        
        if ((userInfo) != nil) {
            println("从消息启动：\(userInfo)")
            BPush.handleNotification(userInfo as! [NSObject : AnyObject])
            }
        }
        //角标清0
        var shared = UIApplication.sharedApplication()
        shared.applicationIconBadgeNumber = 0
//   
//        //设置状态栏的字体颜色模式
//        shared.statusBarStyle = UIStatusBarStyle.LightContent
//        self.window?.makeKeyAndVisible()
      
        return true
    }
    
//    func application(application: UIApplication , didReceiveLocalNotification notification: UILocalNotification ) {
//        var alertView = UIAlertView (title: " 系统本地通知 " , message: notification.alertBody , delegate: nil , cancelButtonTitle: " 返回 " )
//        alertView.show ()
//    }
    // 远程推送通知 注册成功
    func application(application: UIApplication , didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData ) {
          println ("deviceToken.description" )
        println (deviceToken)
        
        //  向云推送注册 device token
       
        BPush.registerDeviceToken(deviceToken)
        // 绑定channel.将会在回调中看获得channnelid appid userid 等
        // 判断是否登录
        readNSUerDefaults ()
        // 之前登录过
        if customerid != "" &&  loginPassword != ""  {
            
            BPush.bindChannelWithCompleteHandler({ (result, error) -> Void in
                var baiduUser = result["user_id"] as! String
                var channelID = result["channel_id"] as! String
         
                //  [self.viewController addLogString:[NSString stringWithFormat:@"Method: %@\n%@",BPushRequestMethodBind,result]];
                // 需要在绑定成功后进行 settag listtag deletetag unbind 操作否则会失败
                if ((result) != nil){
                    
       
                    BPush.setTag("Mytag", withCompleteHandler: { (result, error) -> Void in
                        
                        if ((result) != nil){
                               println("设置tag成功");
//                            func requestUrl(urlString: String){
                        
                             println("baiduUser\(baiduUser)")
                              println(channelID)
                         
                            var url:NSURL = NSURL(string: HttpData.http+"/NationalService/StoreRelationServlet?userID=\(self.customerid)&baiduUser=\(baiduUser)&channelID=\(channelID)&identification=ios")!
                         
                                println("url:\(url)")
                            
                                let request: NSURLRequest = NSURLRequest(URL: url)
                            
                                 NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{    (response, data, error) -> Void in
                                        if (error != nil) {  //Handle Error here
                                            
                                           println("error   \(error)")
                                      }else{
                                            //Handle data in NSData type
                                            println("response\(response)")
                                             
                                            println("data\(data)")

                                            
                                           }
                                     })
 
                            
                        }
                    })
        
                
                }
            })
          
  
        }

    }
    
    // 当 DeviceToken 获取失败时，系统会回调此方法
    func application(application: UIApplication , didFailToRegisterForRemoteNotificationsWithError error: NSError ) {
        if error.code == 3010 {
            println ( "Push notifications are not supported in the iOS Simulator." )
        } else {
            println ( "application:didFailToRegisterForRemoteNotificationsWithError: /(error) " )
        }
    }
 
    func application(application: UIApplication , didReceiveRemoteNotification userInfo: [ NSObject : AnyObject ]) {
        
        // App 收到推送的通知
        BPush.handleNotification(userInfo as [NSObject : AnyObject]!)
        
        
        let notif    = userInfo as NSDictionary
        let apsDic   = notif.objectForKey ( "aps" ) as! NSDictionary
        let alertDic = apsDic.objectForKey ( "alert" ) as! String
        // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
        if (application.applicationState == UIApplicationState.Active || application.applicationState == UIApplicationState.Background) {
        var alertView = UIAlertView (title: "收到一条消息", message: alertDic, delegate: nil , cancelButtonTitle: " 取消 ",otherButtonTitles:"确定")
        alertView.show ()
        }
        else//杀死状态下，直接跳转到跳转页面。
        {
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("finish") as! UIViewController
            // 根视图是普通的viewctr 用present跳转
            var tabBarCtr = self.window?.rootViewController
            tabBarCtr?.presentViewController(vc, animated: true, completion: nil)
        }
    }
 // 此方法是 用户点击了通知，应用在前台 或者开启后台并且应用在后台 时调起
    func application(application: UIApplication , didReceiveRemoteNotification userInfo: [ NSObject : AnyObject ], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult ) -> Void ) {
        let notif    = userInfo as NSDictionary
        let apsDic   = notif.objectForKey ( "aps" ) as! NSDictionary
        let alertDic = apsDic.objectForKey ( "alert" ) as! String
        // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
        if (application.applicationState == UIApplicationState.Active || application.applicationState == UIApplicationState.Background) {
            var alertView = UIAlertView (title: "收到一条消息", message: alertDic, delegate: nil , cancelButtonTitle: " 取消 ",otherButtonTitles:"确定")
            alertView.show ()
        }
        else//杀死状态下，直接跳转到跳转页面。
        {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("finish") as! UIViewController
            // 根视图是普通的viewctr 用present跳转
            var tabBarCtr = self.window?.rootViewController
            tabBarCtr?.presentViewController(vc, animated: true, completion: nil)


        }

    }
    
    // 注册通知 alert 、 sound 、 badge （ 8.0 之后，必须要添加下面这段代码，否则注册失败）
    func application(application: UIApplication , didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings ) {
        application.registerForRemoteNotifications ()
    }
    
//    //ios8系统注册通知成功委托代理
//    
//    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
//         println("wwwwwwwwwwwwwwwwwwwwww")
//        println(notificationSettings)
//    }
//    //远程通知注册成功委托
//    
//    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
//        println("设备号设备号设备号设备号设备号v设备号")
//        println(deviceToken) // 设备号
//          println("设备号设备号设备号设备号设备号v设备号")
//    }
//    
//    //远程通知注册失败委托
//    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
//        println(error)
//    }
//    //点击某条远程通知时调用的委托，如果界面处于打开状态，那么此委托会直接响应
//    
//    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
//        println(userInfo)
//    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        let userDefaultes = NSUserDefaults.standardUserDefaults()
 
        if  (userDefaultes.stringForKey("customerID") != nil) && (userDefaultes.stringForKey("loginPassword") != nil){
            customerid = userDefaultes.stringForKey("customerID")!
            
            loginPassword = userDefaultes.stringForKey("loginPassword")!
            
        }
     
    }

}

