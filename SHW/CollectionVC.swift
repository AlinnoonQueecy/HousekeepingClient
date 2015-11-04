//
//  CollectionVC.swift
//  SHW
//
//  Created by Zhang on 15/7/23.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class CollectionVC: UIViewController,UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate {
        
        
        //声明导航条
        var navigationBar : UINavigationBar?
      
    //change by LZF
   
 
 
 
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var CollectTable: UITableView!
    //读取本地数据
   var customerid:String = ""
   var loginPassword:String = ""
 
       //存储网络数据
      var ServantData:[ServantInfo] = []
 
 
   
    //初始化函数
        override func viewDidLoad() {
            super.viewDidLoad()
            let width = self.view.frame.width
            //读取用户信息，如果不是第一次登录，则会自动登录
            readNSUerDefaults()
  
            CollectTable.dataSource = self
            CollectTable.delegate = self
 
            ServantData = refreshSCollection(customerid) as [ServantInfo]
            
       
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
    
            
        }
        
        override func viewDidLayoutSubviews() {
            let width = self.view.frame.width
           

            CollectTable.frame =  CGRectMake(0, 64, width, self.view.frame.height-100)
    }
 
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        //-------------------Table view data source-----------------------------
        // 根据indexPath(section,row)创建每行cell及其内容
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            print("显示列表")
            //创建cell
            let cell = tableView.dequeueReusableCellWithIdentifier("CollectCell", forIndexPath: indexPath) as! CollectCell
            
            let collect = ServantData[indexPath.row] as ServantInfo
                cell.facilitatorName.text = "人员姓名:\(collect.servantName)"
                cell.itemName.text = "服务项目:\(collect.serviceItems) "
                cell.servicePay.text = "服务次数:\(collect.serviceCount)次"
                //网络地址获取图片
                //1.定义一个地址字符串常量
               let imageUrlString:String = HttpData.http+"/NationalService/\(collect.headPicture)"
//                //2.通过String类型，转换NSUrl对象
                let url:NSString = imageUrlString.URLEncodedString()
                  cell.picture.setZYHWebImage(url as String, defaultImage: "reserve2.jpg")
            
            return cell
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
            //var leftButton =  UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Bordered, target: self, action: "reply")
            //导航栏的标题
            navigationItem.title = "收藏列表"
            //设置导航栏左边按钮
            navigationItem.setLeftBarButtonItem(leftButton, animated: true)
            navigationBar?.pushNavigationItem(navigationItem, animated: true)
            return navigationItem
        }
        
    
       // Return the number of sections.
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1;
        }
        
        // Return the number of rows in the section.
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
            var  count = 0
            
            //返回人员数量作为表格的行数
            count = ServantData.count;
            return count

            }
    
        //    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //        return "";//HttpData.channelTitles[section]
        //    }
    
    
   // 滑动删除必须实现的方法
    
    //Override to support editing the table view.
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //Delete the row from the data source
            print("删除\(indexPath.row)")
            
            
            var response = deleteSCollection(customerid, ServantData[indexPath.row].servantID)
            if response == "Success" {
            ServantData.removeAtIndex(indexPath.row)
            self.CollectTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimation.Left)
            }else {
                let alert =  UIAlertView(title: "删除失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }
            
            print("删\(indexPath.row)")
            
        } else if editingStyle == .Insert {
            //Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    //滑动删除
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    //修改删除按钮的文字
     func  tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "取消收藏"
    }
    

 
    

    
        //-------------------Table view
  
    //cell响应事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
            print("去人员详情1")
            self.performSegueWithIdentifier("toSDetail", sender: self)
            print("去人员详情")
       
        
    }

    
    
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        let userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
            customerid = userDefaultes.stringForKey("customerID")!
            loginPassword = userDefaultes.stringForKey("loginPassword")!
            
        }
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="toSDetail"{
            if let indexPath = self.CollectTable.indexPathForSelectedRow() {
                let  object = ServantData[indexPath.row]
                print("到人员详情")
                (segue.destinationViewController as! workerViewController).workerdetail = object
                print("到人员详情")
            }
        }
        
    }

        
}
