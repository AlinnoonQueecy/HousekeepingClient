//
//  TableViewController.swift
//  未完成订单
//
//  Created by appl on 15/6/9.
//  Copyright (c) 2015年 appl. All rights reserved.
//

import UIKit

class FinishVController: UIViewController,UITableViewDataSource,UITableViewDelegate{
  
    @IBOutlet var yuding: UITableView!
    //读取本地数据
    var customerid:String = ""
    var loginPassword:String = ""
    //获取网络数据
    var Infor:[Finishinfo] = []
    var FinishDatas:[Finishinfo] = []
    //删除
     var barButtonItem:UIBarButtonItem?;
    //声明导航条
    var navigationBar : UINavigationBar?
     //刷新
    var refreshControl = UIRefreshControl()
    //分段选择
    var segmentedControl = UISegmentedControl()
    //orderStatus
    var  orderStatus:String = ""
    func readNSUerDefaults () {
        
        let userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
            customerid = userDefaultes.stringForKey("customerID")!
            loginPassword = userDefaultes.stringForKey("loginPassword")!
            
        }
        
    }
        override func viewDidLoad() {
        super.viewDidLoad()
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        //setRightDeleteButtonItem()
        //FinishDatas = refreshFinish(customerid) as! [Finishinfo]
        FinishDatas = refreshOrderData(customerid,orderStatus) as! [Finishinfo]
 
         
        yuding.dataSource = self
        yuding.delegate = self
        
       //初始下拉刷新控件
//        self.refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "松开后自动刷新")
        refreshControl.tintColor = UIColor.grayColor()
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
         yuding.addSubview(refreshControl)
        print("要刷新喽")
            //实例化导航条
            navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.width, 64))
            navigationBar?.barTintColor = UIColor.orangeColor()
            navigationBar?.translucent = false
            navigationBar?.barStyle = UIBarStyle.Default
            let navigationTitleAttribute: NSDictionary = NSDictionary(objectsAndKeys: UIColor.whiteColor(), NSForegroundColorAttributeName)
            navigationBar?.titleTextAttributes =  navigationTitleAttribute as [NSObject: AnyObject]
            self.view.addSubview(navigationBar!)
        
            onMakeNavitem()
            
            //分段选择设置
            let arr = NSArray(objects: "全部","待确认","待付款","服务中","服务完成")
           _ = (self.view.frame.width-10)/5
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
        yuding.frame = CGRectMake(0, 100, self.view.frame.width, self.view.frame.height-100)
        
        
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
        return FinishDatas.count;
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FinishTVCell
        
        let yud = FinishDatas[indexPath.row] as Finishinfo
        cell.orderNo.text = "订单编号:\(yud.orderNo)"
        cell.serviceType.text = "订单状态:\(yud.orderStatus)"
        cell.facilitator.text = "服务人员:\(yud.servantName)"
        cell.ServantPhone.text = "联系电话:\(yud.servantPhone)"
        cell.servantName.text = "服务类型:\(yud.serviceType)"
        cell.servicePay.text = "服务费用:\(yud.servicePrice )元"
        //cell.pic.image = UIImage(named:yud.pic)

        return cell
    }
    //分段选择器的函数
    func selected() {
        print("点击开始")
        //读取控件
        let x = segmentedControl.selectedSegmentIndex
        switch(x){
        case 0:
            orderStatus = ""
            FinishDatas = refreshOrderData(customerid,orderStatus) as! [Finishinfo]
            print("点击第一个")
            self.yuding.reloadData()

            break
        case 1:
            orderStatus = "待确认"
            FinishDatas = refreshOrderData(customerid, orderStatus) as! [Finishinfo]
            print("点击第3个")
            self.yuding.reloadData()
            break

        case 2:
            orderStatus = "待付款"
            FinishDatas = refreshOrderData(customerid, orderStatus) as! [Finishinfo]
            print("点击第3个")
            self.yuding.reloadData()
            break
        case 3:
            orderStatus = "服务中"
            FinishDatas = refreshOrderData(customerid,orderStatus) as! [Finishinfo]
            print("点击第3个")
            self.yuding.reloadData()
            break

        default:
            orderStatus = "服务完成"
            FinishDatas = refreshOrderData(customerid,orderStatus) as! [Finishinfo]
            print("点击其他")
            self.yuding.reloadData()
            break
        }
        
        
    }
    //确定单元格是否具有编辑功能
    // Override to support conditional editing of the table view.
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//    // Return NO if you do not want the specified item to be editable.
//    return true
//    }
//    //指定每一行的编辑类型
//    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
//        //允许删除操作
//    return UITableViewCellEditingStyle.Delete
//    }
    //删除表单元格
    //设置导航右边管理按钮
//    func setRightDeleteButtonItem(){
//        
//        
//        barButtonItem = UIBarButtonItem(title:"管理", style: .Done, target: self, action: "RightButtonItemAction")
//        barButtonItem!.tag = 10;
//        self.navigationItem.rightBarButtonItem = barButtonItem
//    }
    //管理按钮的函数
//    func RightButtonItemAction(){
//        
//        if barButtonItem?.tag == 10{
//            self.tableView.setEditing(true, animated: true);
//            barButtonItem!.title = "删除"
//            barButtonItem!.tag = 20;
//        }
//        else{
//            
//            self.tableView.setEditing(false, animated: true);
//            barButtonItem!.title = "管理"
//            barButtonItem!.tag = 20;
//        }
//        
//    }

    
    // Override to support rearranging the table view.
//    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
//    
//    }

    
    
    // Override to support conditional rearranging of the table view.
//    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//    // Return NO if you do not want the item to be re-orderable.
//    return true
//    }

    


//    //从NSUerDefaults 中读取数据
//    func readNSUerDefaults () {
//        
//        var userDefaultes = NSUserDefaults.standardUserDefaults()
//        customerid = userDefaultes.stringForKey("customerID")!
//    }
    
    //删除cell事件
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
//        
//        //删除数据源的对应数据
//        //Infor.removeAtIndex(indexPath.row)
//       var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileServiceOrderAction?operation=_cancelOrder")
//        
//        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
//        
//        request.HTTPMethod = "POST"
//        var id:Int = Infor[indexPath.row].id
//        var param:String = "{\"id\":\"\(id)\"}"
//        println(param)
//        var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
//        request.HTTPBody = data;
//        var response:NSURLResponse?
//        var error:NSError?
//        var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
//        if (error != nil)
//        {
//            println(error?.code)
//            println(error?.description)
//        }
//        else
//        {
//            var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
//            println("jsonString")
//            println(jsonString)
//            
//        }
//        
//        let dict:AnyObject? = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
//        var dic = dict as! NSDictionary
//        let serverResponse = dic.objectForKey("serverResponse") as? String
//        
//        if serverResponse == "Success"{
// 
//            //刷新数据
//            yuding.reloadData()
//            
//            //tableView.beginUpdates()
//            //删除数据源的对应数据
//            FinishDatas.removeAtIndex(indexPath.row)
//            println("删除后的数量")
//            println(Infor.count)
//            //yuding.beginUpdates()
//            //删除对应的cell
//            self.yuding.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
//            //yuding.endUpdates()
//            //刷新数据
//            //tableView.reloadData()
//        }
//        
//        if serverResponse == "Failed"{
//            
//            let alert =  UIAlertView(title: "删除失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
//            alert.show()
//        }
//        
//
//        
////        //删除对应的cell
////        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
//        
//        //数据源为空的时候管理按钮不能删除
//        if self.FinishDatas.count == 0{
//            barButtonItem?.enabled = false;
//        }
//        
//    }
//    //把delete 该成中文
//    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
//        
//        return "删除"
//    }
    ////导航条详情
//    func reply (){
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func onMakeNavitem() -> UINavigationItem{
//        println("创建导航条step1")
//        //创建一个导航项
//        var navigationItem = UINavigationItem()
//        //创建左边按钮
//        var leftButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "reply")
//        //var leftButton =  UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Bordered, target: self, action: "reply")
//        //导航栏的标题
//        navigationItem.title = "类别详情"
//        //设置导航栏左边按钮
//        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
//        
//        navigationBar?.pushNavigationItem(navigationItem, animated: true)
//        
//        
//        return navigationItem
//    }
    
    
    //导航条详情
    func reply (){
//        self.dismissViewControllerAnimated(true, completion: nil)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("MainVC") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)

    }
    
    func onMakeNavitem() -> UINavigationItem{
        print("创建导航条step1")
//        //创建一个导航项
//        var navigationItem = UINavigationItem()
        //创建左边按钮
        let leftButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "reply")
        leftButton.tintColor = UIColor.whiteColor()

        //var leftButton =  UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Bordered, target: self, action: "reply")
        //导航栏的标题
        navigationItem.title = "订单列表"
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        navigationBar?.pushNavigationItem(navigationItem, animated: true)
   
        
        return navigationItem
    }
    override func  viewWillAppear(animated: Bool) {
        
        FinishDatas = refreshOrderData(customerid,orderStatus) as! [Finishinfo]
        self.yuding.reloadData()
        
    }
    


    // 下拉刷新方法
    func refresh() {
 

        self.refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
 
         FinishDatas = refreshOrderData(customerid, orderStatus) as! [Finishinfo]
        self.yuding.reloadData()
        self.refreshControl.endRefreshing()
        print("刷新好了")
     
     }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier=="detail"{
            if let indexPath = self.yuding.indexPathForSelectedRow(){
                println("哈哈哈哈哈哈哈哈")
                let object = FinishDatas[indexPath.row] as Finishinfo
                println( "Finish:\(object)" )
                (segue.destinationViewController as! FinishViewController).detailData = object
                
            }
        }
    }
    

    


}
