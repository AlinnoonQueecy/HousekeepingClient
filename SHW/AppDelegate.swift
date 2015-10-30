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

//    private func createMenuView() {
//        
//        // create viewController code...
//        var storyboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
//        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("LeftViewController")as!LeftViewController
//        let rightViewController = storyboard.instantiateViewControllerWithIdentifier("RightViewController") as! RightViewController
//        
//        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
//        
//        leftViewController.mainViewController = nvc
//        
//        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
//        
        //self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
       // self.window?.rootViewController = MainVC
//        self.window?.makeKeyAndVisible ()
//    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        mapManager = BMKMapManager() // 初始化 BMKMapManager
        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
        
        let ret = mapManager?.start("W64DZGMGe8SaBFisH3vuiwtc", generalDelegate: nil)  // 注意此时 ret 为 Bool? 类型
        
        if !ret! {  // 如果 ret 为 false，先在后面！强制拆包，再在前面！取反
            NSLog("manager start failed!") // 这里推荐使用 NSLog，当然你使用 println 也是可以的
        }
//        //注册服务器推送，请求用户授权
//        let  version:String = UIDevice.currentDevice().systemVersion
//        if (version as NSString).floatValue >= 8.0{
//            application.registerUserNotificationSettings( UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert | UIUserNotificationType.Badge, categories: nil))
//            println("//注册服务器推送，请求用户授权")
//            
//        }else{
//            application.registerForRemoteNotificationTypes(UIRemoteNotificationType.Sound | UIRemoteNotificationType.Alert | UIRemoteNotificationType.Badge )
//        }
        
        if ( UIApplication . instancesRespondToSelector ( Selector ( "registerUserNotificationSettings:" ))) {
            application.registerUserNotificationSettings ( UIUserNotificationSettings (forTypes:  UIUserNotificationType.Sound |  UIUserNotificationType.Alert |  UIUserNotificationType.Badge, categories:  nil ))
        } else {
            application.registerForRemoteNotificationTypes(UIRemoteNotificationType.Sound | UIRemoteNotificationType.Alert | UIRemoteNotificationType.Badge )

        }

        return true
    }
    
    func application(application: UIApplication , didReceiveLocalNotification notification: UILocalNotification ) {
        var alertView = UIAlertView (title: " 系统本地通知 " , message: notification.alertBody , delegate: nil , cancelButtonTitle: " 返回 " )
        alertView.show ()
    }
    // 远程推送通知 注册成功
    func application(application: UIApplication , didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData ) {
          println ("deviceToken.description" )
        println (deviceToken.description )
    }
    // 远程推送通知 注册失败
    func application(application: UIApplication , didFailToRegisterForRemoteNotificationsWithError error: NSError ) {
        if error.code == 3010 {
            println ( "Push notifications are not supported in the iOS Simulator." )
        } else {
            println ( "application:didFailToRegisterForRemoteNotificationsWithError: /(error) " )
        }
    }
    // 8.0 之前   收到远程推送通知
    func application(application: UIApplication , didReceiveRemoteNotification userInfo: [ NSObject : AnyObject ]) {
        let notif    = userInfo as NSDictionary
        let apsDic   = notif.objectForKey ( "aps" ) as! NSDictionary
        let alertDic = apsDic.objectForKey ( "alert" ) as! String
        var alertView = UIAlertView (title: " 系统本地通知 " , message: alertDic, delegate: nil , cancelButtonTitle: " 返回 " )
        alertView.show ()
    }
    // 8.0 之后 收到远程推送通知
    func application(application: UIApplication , didReceiveRemoteNotification userInfo: [ NSObject : AnyObject ], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult ) -> Void ) {
        let notif    = userInfo as NSDictionary
        let apsDic   = notif.objectForKey ( "aps" ) as! NSDictionary
        let alertDic = apsDic.objectForKey ( "alert" ) as! String
        var alertView = UIAlertView (title: " 远程推送通知 " , message: alertDic, delegate: nil , cancelButtonTitle: " 返回 " )
        alertView.show ()
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


}

