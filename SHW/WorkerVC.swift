//
//  WorkeVC.swift
//  SHW
//
//  Created by Zhang on 15/7/19.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class WorkerVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate {

    //接受传递过来的参数
     var facilitatorID:String?
  
    //保存一个商家的服务人员
    var info:[ServantInfo] = []
    //声明导航条
    var navigationBar : UINavigationBar?
    @IBOutlet weak var workerTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(facilitatorID)
        let width = self.view.frame.width
        
       //info = refreshServantData(facilitatorID!) as! [ServantInfo]
        if info == []{
            let alert =  UIAlertView(title: "", message: "该商家还没有完善人员信息!", delegate: self, cancelButtonTitle: "确定")
            alert.show()
        }
        
        print("info\(info)")
        workerTable.dataSource = self
        workerTable.delegate = self
       

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
        navigationItem.title = "人员列表"
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        
        navigationBar?.pushNavigationItem(navigationItem, animated: true)
        
        
        return navigationItem
    }
    
    override func viewDidLayoutSubviews() {
        let width = self.view.frame.width
        
        workerTable.frame =  CGRectMake(0,64, width, self.view.frame.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func  alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }

    // MARK: - Table view data source
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("1")
        let cell = tableView.dequeueReusableCellWithIdentifier("Servantcell", forIndexPath: indexPath) as! workerTableViewCell
        
        // Configure the cell...
        print("2")
        let workercell = info[indexPath.row] as ServantInfo
        cell.servantName.text = "名称:\(workercell.servantName)"
        //cell.servantStatus.text = "状态:\(workercell.servantStatus)"
        cell.servantStatus.text = "状态:"
        cell.Status.text = workercell.servantStatus
        if workercell.servantStatus == "服务中"{
//
           // cell.Status.text = "忙"
            cell.Status.textColor = UIColor.grayColor()
        }else{
            //cell.Status.text = "空闲"
            cell.Status.textColor = UIColor.orangeColor()
        }
        
        cell.workYears.text = "从业年限:\(workercell.workYears)年"
        //cell.servantScore.text = "星级:\(workercell.servantScore)"
        cell.servantScore.text = "星级:\(workercell.servantScore)"
//        cell.Score.image = imageForRank(workercell.servantScore )
        //网络地址获取图片
        //1.定义一个地址字符串常量
        let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/upload/servant/\(workercell.id)/\(workercell.headPicture)"
//        //2.通过String类型，转换NSUrl对象
//        let url :NSURL = NSURL(string: imageUrlString)!
//        println("url:\(url)")
//        //3.从网络获取数据流
//        if let data:NSData = NSData(contentsOfURL: url){
//            //4.通过数据流初始化图片
//            cell.headPicture.image = UIImage(data: data)
//        }else {
//            
//           cell.headPicture.image = UIImage(named: "122.jpg")!
//        }
        
//        var data = getImageData(imageUrlString)
//        
//        if data == nil{
//            println(data)
//           cell.headPicture.image = UIImage(named: "122.jpg")
//        }else{
//            cell.headPicture.image = UIImage(data: data!)
//            
//        }
//    
        cell.headPicture.setZYHWebImage(imageUrlString, defaultImage: "122.jpg")
        //cell.headPicture.image = UIImage(data: data)
        print("结束了也")
        
        return cell
    }
    
    func imageForRank(rank:String) -> UIImage? {
        switch rank {
        case "1":
            return UIImage(named: "1")
        case "2":
            return UIImage(named: "2")
        case "3":
            return UIImage(named: "3")
        case "4":
            return UIImage(named: "4")
        case "5":
            return UIImage(named: "5")
        default:
            return nil
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return info.count;
    }

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier=="toWorkerDetail"{
            if let indexPath = self.workerTable.indexPathForSelectedRow(){
                var  object = info[indexPath.row] as ServantInfo
                
                (segue.destinationViewController as! workerViewController).workerdetail = object
            }
        }
      }
    


}
