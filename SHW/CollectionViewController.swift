//
//  CollectionViewController.swift
//  生活网
//
//  Created by Zhang on 15/5/17.
//  Copyright (c) 2015年 Zhang. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var collectionTable: UITableView!
    
    
    @IBAction func reply(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil )
    }
  
    @IBAction func reserveButton(sender: AnyObject) {
       // var vc = OrderDetailVC()
        //self.presentViewController(vc, animated: true, completion: nil )
        
        //获取数据，显示在订单中
        self.performSegueWithIdentifier( "toOrder", sender: self )
        
    }
    
    var collections:[Collection] = collectionDate

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionTable.dataSource = self
        collectionTable.delegate = self
        // Do any additional setup after loading the view.
    
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-------------------Table view data source-----------------------------
    // 根据indexPath(section,row)创建每行cell及其内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //创建cell
        let cell = tableView.dequeueReusableCellWithIdentifier("CollectCell", forIndexPath: indexPath) as! CollectCell
        
                let collection = collections[indexPath.row] as Collection
                cell.firstLabel.text = collection.first
                cell.cateLabel.text = collection.cate
                cell.costLabel.text = collection.cost
                cell.staffLabel.text = collection.staff
                cell.detailLabel.text = collection.detail
                
                return cell
    
    }
    
    // Return the number of sections.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;//HttpData.channelTitles.count
    }
    
    // Return the number of rows in the section.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        var sectionTitle:String = HttpData.channelTitles[section]
        //        var sectionData:[Item] = HttpData.tableData[sectionTitle]!
        
        return collections.count;
        //sectionData.count
    }
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "";//HttpData.channelTitles[section]
//    }
    
    
    //-------------------Table view delegate-----------------------------
    //选中行事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        var sectionNo:Int = indexPath.section
        //        var rowNo:Int = indexPath.row
        //        var sectionTitle:String = HttpData.channelTitles[sectionNo]
        //        var items:[Item] = HttpData.tableData[sectionTitle]!
        //        var curItem:Item = items[rowNo]
        //        urlSelected = curItem.url
        //        //self.performSegueWithIdentifier("toDetail", sender: self)
        //        //urlSelected = "http://www.baidu.com"
        //        webView.loadRequest(NSURLRequest(URL: NSURL(string: urlSelected)!))
        //        
        //        toggleDetailView(show: true)
        
    }
    //滑动删除必须实现的方法
    
    //Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //Delete the row from the data source
            println("删除\(indexPath.row)")  
            self.collections.removeAtIndex(indexPath.row)
            println("删\(indexPath.row)")
            println(indexPath.row)
            println(collectionDate.count)
            //collectionTable.reloadData()
            collectionTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimation.Left)
            
        } else if editingStyle == .Insert {
            //Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    //重排Cell
//    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
//        var object:AnyObject = collectionDate.objectAtIndex(sourceIndexPath.row)
//        collectionDate.removeAtIndex(sourceIndexPath.row)
//        if toIndexPath.row > self.collections.count {
//            self.collections.addObject(object)
//        }
//        else {
//            self.collections.insertObject(object, atIndex: toIndexPath.row)
//        }
//        
//    }
    
    //滑动删除
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    //修改删除按钮的文字
    func  tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        return "删"
    }
    
    
    // Override to support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }

    


    

     //Override to support rearranging the table view.
     func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
//    */
//     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//        if segue.identifier=="collect"{
//            println("dwsfqbtwhfn")
////            let indexPath = self.tableView.indexPathForSelectedRow()
////                let object = collections[indexPath.row] as 
////                (segue.destinationViewController as! FinishViewController).detailItem = object
//
        //}
   // }
//
//    override func  prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "collect"{
//            let indexPath = self.tableView(tableView: UITableView, willSelectRowAtIndexPath: NSIndexPath)
//            
//    }
    
    
//}
    
    
}