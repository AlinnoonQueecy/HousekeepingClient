////
////  reserveTableViewController.swift
////  我的预定
////
////  Created by appl on 15/6/16.
////  Copyright (c) 2015年 appl. All rights reserved.
////
//
import UIKit

class reserveTViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var reserve: UITableView!
    
//    @IBAction func reply(sender: AnyObject) {
//        self.dismissViewControllerAnimated(true, completion: nil )
//    }
    
//    //读取本地数据
    var customerid:String = ""
    var loginPassword:String = ""
 
    //获取网络数据
    
    var DeclaresData:[DeclaresInfo] = []
    //声明导航条
    var navigationBar=UINavigationBar()
    //刷新
    var refreshControl = UIRefreshControl()
    //分段选择
    var segmentedControl = UISegmentedControl()
    var  isAccepted:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
//        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        //实例化导航条
        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.width, 64))
        navigationBar.barTintColor = UIColor.orangeColor()
        navigationBar.translucent = false
        navigationBar.barStyle = UIBarStyle.Default
        let navigationTitleAttribute: NSDictionary = NSDictionary(objectsAndKeys: UIColor.whiteColor(), NSForegroundColorAttributeName)
        navigationBar.titleTextAttributes =  navigationTitleAttribute as [NSObject: AnyObject]
        self.view.addSubview(navigationBar)
        print("创建导航条详情")
        onMakeNavitem()
        
        DeclaresData = QueryDeclareData(customerid,isAccepted) as! [DeclaresInfo]
        reserve.dataSource = self
        reserve.delegate = self
      
 
        
        //初始下拉刷新控件
        //        self.refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "松开后自动刷新")
        refreshControl.tintColor = UIColor.grayColor()
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        reserve.addSubview(refreshControl)
        
        //分段选择设置
        let arr = NSArray(objects: "未接受","已拒绝")
        var sw = (self.view.frame.width-10)/4
        //设置item
        segmentedControl = UISegmentedControl(items: arr as [AnyObject])
        //设置位置
        segmentedControl.frame =  CGRectMake(5, 64,self.view.frame.width-10, 36)
        //设置Item的宽度
        //            segmentedControl.setWidth(sw, forSegmentAtIndex: 0)
        //            segmentedControl.setWidth(sw, forSegmentAtIndex: 1)
        //            segmentedControl.setWidth(sw, forSegmentAtIndex: 2)
        //            segmentedControl.setWidth(sw, forSegmentAtIndex: 3)
        //每个的宽度按segment的宽度平分
        segmentedControl.apportionsSegmentWidthsByContent =  true
        
        //选中第几个segment 一般用于初始化时选中
        segmentedControl.selectedSegmentIndex = 0
        //风格
        self.view.addSubview(segmentedControl)//添加到父视图
        //添加事件
        print("点击")
        segmentedControl.addTarget(self, action: "selected", forControlEvents: UIControlEvents.ValueChanged)
        
        

    }
    override func viewDidLayoutSubviews() {
        reserve.frame = CGRectMake(0, 100, self.view.frame.width, self.view.frame.height-100)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1;
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return DeclaresData.count;
    }

    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reservecell", forIndexPath: indexPath) as! reserveTableViewCell

        // Configure the cell...
//      let reservecell = ReserveData[indexPath.row] as Finishinfo
        let reservecell = DeclaresData[indexPath.row] as DeclaresInfo

        cell.orderNo.text = "服务项目:\(reservecell.serviceType)"
        cell.orderTime.text = "服务时间:\(reservecell.serviceTime)"
        cell.servantName.text = "薪水:\(reservecell.salary)元"
        cell.cancel.addTarget(self, action: "cancel:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.cancel.tag = indexPath.row
        if reservecell.isAccepted == 0{
            cell.cancel.hidden = false
            cell.cancel.enabled = true
            cell.serviceType.text = "状态:未接受"
            cell.serviceType.textColor = UIColor.orangeColor()
        }else {
            cell.cancel.hidden = true
            cell.cancel.enabled = false
            cell.serviceType.text = "状态:已拒绝"
            cell.serviceType.textColor = UIColor.grayColor()
        }
        
        return cell
    }
    
    
    func cancel(cancel:UIButton){
        
        let  response = deleteDeclare(DeclaresData[cancel.tag].id)
        
        if response == "Success" {
            DeclaresData.removeAtIndex(cancel.tag)
            //self.reserve.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimation.Left)
            self.reserve.reloadData()
             print("刷新好了")
        }else {
            let alert =  UIAlertView(title: "取消失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
            alert.show()
        }
        
    }
    
    // 滑动删除必须实现的方法
    
    //Override to support editing the table view.
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            //Delete the row from the data source
//            println("删除\(indexPath.row)")
//            
//            
//            var  response = deleteDeclare(DeclaresData[indexPath.row].id)
//            
//            if response == "Success" {
//                DeclaresData.removeAtIndex(indexPath.row)
//                self.reserve.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimation.Left)
//            }else {
//                let alert =  UIAlertView(title: "取消失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
//                alert.show()
//            }
//            
//            println("删\(indexPath.row)")
//            
//        } else if editingStyle == .Insert {
//            //Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
//    
//    //滑动删除
//    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
//        return UITableViewCellEditingStyle.Delete
//    }
//    //修改删除按钮的文字
//    func  tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
//        return "取消发布"
//    }
//    

    //分段选择器的函数
    func selected() {
        print("点击开始")
        //读取控件
        let x = segmentedControl.selectedSegmentIndex
        switch(x){
        case 0:
               isAccepted = 0
             DeclaresData = QueryDeclareData(customerid,isAccepted) as! [DeclaresInfo]
            print("点击第一个")
            self.reserve.reloadData()
            
            break
          default:
             isAccepted = 2
           DeclaresData = QueryDeclareData(customerid,isAccepted) as! [DeclaresInfo]
            print("点击第2个")
            self.reserve.reloadData()
            break
            
       
        }
        
        
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
        navigationItem.title = "发布列表"
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        navigationBar.pushNavigationItem(navigationItem, animated: true)
        
        
        return navigationItem
    }
    
    
    // 下拉刷新方法
    func refresh() {
        //if self.refreshControl.refreshing == true {
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
         DeclaresData = QueryDeclareData(customerid, isAccepted) as! [DeclaresInfo]
        self.reserve.reloadData()
        self.refreshControl.endRefreshing()
        print("刷新好了")
        //}
        //self.automaticallyAdjustsScrollViewInsets = false
    }

    
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        let userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
            customerid = userDefaultes.stringForKey("customerID")!
            loginPassword = userDefaultes.stringForKey("loginPassword")!
            
        }
        
    }

    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier=="reservedetail"{
            if let indexPath = self.reserve.indexPathForSelectedRow(){
                
                let object = DeclaresData[indexPath.row] as DeclaresInfo
                println(object)
                // (segue.destinationViewController as! reserveViewController).detailItem = object
            }
        }

    }
    

}
