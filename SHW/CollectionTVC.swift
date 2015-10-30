//////
//////  CollectionTVC.swift
//////  SHW
//////
//////  Created by Zhang on 15/6/18.
//////  Copyright (c) 2015年 star. All rights reserved.
//////
////没用的
//import UIKit
//
//class CollectionTVC: UITableViewController {
//    //@IBOutlet weak var collectionTable: UITableView!
//    
//    //读取本地数据
//    var customerid:String = HttpData.customerid
//    var loginPassword:String = HttpData.loginpassword
//    
//    var select:String?
//    
//    @IBOutlet var CollectTV: UITableView!
//    
//    @IBAction func reply(sender: AnyObject) {
//        self.dismissViewControllerAnimated(true, completion: nil )
//    }
//    
//  
//    //存储排序字段
////    var  attributeName:String = ""
////    var  upDown :String = ""
//    //存储网络数据
//    var collectionData:[CollectionInfo] = []
//    //声明一个数组businesss来保存商家信息
//    var info:[facilitatorInfo] = []
//    //初始化函数
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        CollectTV.delegate = self
//        CollectTV.dataSource = self
////        //读取用户信息，如果不是第一次登录，则会自动登录
////        readNSUerDefaults()
//        collectionData = refreshCollection(customerid) as! [CollectionInfo]
//        
//    }
// 
//    
////    - (void)pressed:(id)sender {
////    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
////    NSIndexPath * path = [self.tableView indexPathForCell:cell];
////    NSLog(@"index row%d", [path row]);
////    //NSLog(@"view:%@", [[[sender superview] superview] description]);
////    }
//
//    //三个BUtton
//    //按照类别.时间.金额
//    //            var buttonw = (width - 36)/3
//    //            var button1 = UIButton(frame: CGRectMake(18, 68, buttonw, 30))
//    //             button1.setTitle("类别", forState: UIControlState.Normal)
//    //             button1.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//    //             button1.titleLabel?.font = UIFont.systemFontOfSize(14)
//    //             button1.addTarget(self, action: Selector("leibie"), forControlEvents: UIControlEvents.TouchUpInside)
//    //            self.view.addSubview(button1)
//    //            var button2 = UIButton(frame: CGRectMake(buttonw+18, 68, buttonw, 30))
//    //            button2.setTitle("时间", forState: UIControlState.Normal)
//    //            button2.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//    //            button2.titleLabel?.font = UIFont.systemFontOfSize(14)
//    //            button2.addTarget(self, action: Selector("time"), forControlEvents: UIControlEvents.TouchUpInside)
//    //            self.view.addSubview(button2)
//    //            var button3 = UIButton(frame: CGRectMake(width-buttonw-18, 68, buttonw, 30))
//    //            button3.setTitle("金额", forState: UIControlState.Normal)
//    //            button3.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//    //            button3.titleLabel?.font = UIFont.systemFontOfSize(14)
//    //            button3.addTarget(self, action: Selector("price"), forControlEvents: UIControlEvents.TouchUpInside)
//    //            self.view.addSubview(button3)
//    //下拉菜单
//    tabelView1 = UITableView(frame:CGRectMake(0, 100, 100, self.view.frame.height),style:UITableViewStyle.Plain)
//    //指定数据源和代理
//    self.tabelView1.dataSource = self
//    self.tabelView1.delegate = self
//
//    
//    
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    // MARK: - Table view data source
//    
//    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 1;
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return collectionData.count;
//    }
//    // 根据indexPath(section,row)创建每行cell及其内容
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        //创建cell
//        let cell = tableView.dequeueReusableCellWithIdentifier("CollectCell", forIndexPath: indexPath) as! CollectCell
//        
//        let collection = collectionData[indexPath.row] as CollectionInfo
//        cell.firstLabel.text = collection.first
//        cell.cateLabel.text = collection.cate
//        cell.costLabel.text = collection.cost
//        cell.staffLabel.text = collection.staff
//        cell.detailLabel.text = collection.detail
//        
//        return cell
//    
//    }
//
//
//
//    /*
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
//
//        // Configure the cell...
//
//        return cell
//    }
//    */
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return NO if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    //滑动删除必须实现的方法
//    
//    //Override to support editing the table view.
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            //Delete the row from the data source
//            println("删除\(indexPath.row)")
//            self.collections.removeAtIndex(indexPath.row)
//            println("删\(indexPath.row)")
//            println(indexPath.row)
//            println(collectionDate.count)
//            //collectionTable.reloadData()
//            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimation.Left)
//            
//        } else if editingStyle == .Insert {
//            //Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
//
//    //滑动删除
//    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
//        return UITableViewCellEditingStyle.Delete
//    }
//    //修改删除按钮的文字
//    override func  tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
//        return "删除"
//    }
//    
//    
//    // Override to support conditional editing of the table view.
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return NO if you do not want the specified item to be editable.
//        return true
//    }
//    
//    
//
//
//     //Override to support rearranging the table view.
//    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
//
//    }
//    
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return NO if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//    }
//    
//    */
//    //从NSUerDefaults 中读取数据
//    func readNSUerDefaults () {
//        
//        var userDefaultes = NSUserDefaults.standardUserDefaults()
//        customerid = userDefaultes.stringForKey("customerID")!
//    }
//    
//
////    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
////        
////        if segue.identifier == "toDetail" {
////            if let indexPath = self.tableView.indexPathForSelectedRow(){
////                let object = indexPath.row
////                (segue.destinationViewController as! BusinessDVC).detailItem = object
////            }
////        }
////            else if segue.identifier=="toOrder"{
//////            if let indexPath = self.tableView.indexPathForSelectedRow(){
//////                let object = collections[indexPath.row] as Collection
//////                (segue.destinationViewController as! orderTableViewController).collectionInfo = object
//////            }
//////        }
//////
////    }
//// 
////
////
//}
