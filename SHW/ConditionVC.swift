//
//  ConditionVC.swift
//
//
//  Created by Zhang on 15/10/29.
//
//

import UIKit

class ConditionVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    //声明导航条
    var navigationBar : UINavigationBar?
    
    
    var tableView = UITableView()
    
    var IndexSettingData:[IndexSetting] = []
    var data:[String:NSArray] = Dictionary<String,NSArray>()
    var selectData:[String:String] = Dictionary<String,String>()
    var  Index:NSArray!
    var  indexCode:String!
    var  indexPrice:String!
    
    var selectedCell: UITableViewCell?
    var selectedIndexPath: NSIndexPath?
    var sectionCount: Int?
    var selectedItems: NSMutableArray = NSMutableArray() // 存放所有选中的cell标题
    var selectedPrice: NSMutableArray = NSMutableArray() // 存放所有选中的cell的价格
    
    var  width:CGFloat!
    var salary:String!
    var ServiceType:String?
    
    override func viewWillAppear(animated: Bool) {
        HttpData.count = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        width = self.view.frame.width
        let  height = self.view.frame.height
        readNSUerDefaults ()
        //实例化导航条
        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, 64))
        navigationBar?.barTintColor = UIColor.orangeColor()
        navigationBar?.translucent = false
        navigationBar?.barStyle = UIBarStyle.Default
        let navigationTitleAttribute: NSDictionary = NSDictionary(objectsAndKeys: UIColor.whiteColor(), NSForegroundColorAttributeName)
        navigationBar?.titleTextAttributes =  navigationTitleAttribute as [NSObject: AnyObject]
        navigationBar?.translucent = false
        
        
        
        self.view.addSubview(navigationBar!)
        print("创建导航条详情B")
        onMakeNavitem()
        
        tableView = UITableView(frame: CGRectMake(0, 64, width, height-64))
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        IndexSettingData =  refreshIndexSetting(ServiceType!)as! [IndexSetting]
      
        
      
        
        for var i = 0;i < IndexSettingData.count;i++ {
            
            var indexName = IndexSettingData[i].indexName
             
            
            var string1 = IndexSettingData[i].indexRange
             var string2 = IndexSettingData[i].price
           
            
            
            var range1:[String] = []
            range1 = string1.componentsSeparatedByString(";")
            var range2:[String] = []
            range2 = string2.componentsSeparatedByString(";")
            var range:[String] = []
            
            for var n = 0;n < range1.count;n++ {
                if range2[n] == "-1"{
                    range2[n] = ""
                }
                range += ["\(range1[n]) （ \(range2[n])元）"]
                
            }
            
            data[indexName] = range
        }
        var keys:NSArray = Array(data.keys)
        println("data\(data.count)")
        
        self.Index  = keys
    }
    //导航条详情
    func reply (){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func confirm (){
        println("selectedItems\(selectedItems)")
        var selectedItem = selectedItems as NSArray
        if selectedItem.count != IndexSettingData.count{
            let alert =  UIAlertView(title: "", message: "条件选择不完全!", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            
        }else {
       

            let sortedItem = selectedItem.sortedArrayUsingSelector(Selector("compare:"))  // ["A", "D", "Z"]
                 println("arrayIndex\(sortedItem)")
            var selectIndex:String = ""
            
            for var i = 0;i < IndexSettingData.count;i++ {
                
                selectIndex += "\(sortedItem[i])"
                
                
            }
            println("selectIndex\(selectIndex)")
            
           // salary = getPrice(ServiceType!, selectIndex)
            
            salary = "0.01"
            if salary == "-1"{
                let alert =  UIAlertView(title: "", message: "组合条件错误!", delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }else {
                let alert =  UIAlertView(title: "根据您选择的条件，基本费用为", message: "\(salary)元", delegate: self, cancelButtonTitle: "知道了")
//                HttpData.salary = salary
                alert.tag = 1
                alert.show()
            }

        }
        

    }
    
    
    
    //UIAlert触发函数
    
    func  alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if (alertView.tag == 1) {
                HttpData.salary = salary
            self.dismissViewControllerAnimated(true, completion: nil)
            //        let sb = UIStoryboard(name: "Main", bundle: nil)
            //        let vc = sb.instantiateViewControllerWithIdentifier("finish") as! UIViewController
            //        self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    func onMakeNavitem() -> UINavigationItem{
        print("创建导航条step1b")
        //创建一个导航项
        let navigationItem = UINavigationItem()
        
        
        //创建左边按钮
        var leftButton =  UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Bordered, target: self, action: "reply")
        leftButton.tintColor = UIColor.whiteColor()
        var rightButton =  UIBarButtonItem(title: "确认", style: UIBarButtonItemStyle.Bordered, target: self, action: "confirm")
        rightButton.tintColor = UIColor.whiteColor()
        //导航栏的标题
        navigationItem.title = "条件选择"
        
        //navigationItem.
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        navigationItem.setRightBarButtonItem(rightButton, animated: true)
        
        navigationBar?.pushNavigationItem(navigationItem, animated: true)
        
        return navigationItem
    }
    
    
    override func viewDidAppear(animated: Bool) {
        for var i = 0; i < sectionCount; ++i{
            let userDefault = NSUserDefaults.standardUserDefaults()
            userDefault.setInteger(0, forKey: "\(i)")
            
        }
        
        
    }
    
    //section Number
    func numberOfSectionsInTableView(tableView:UITableView) -> Int {
        sectionCount = data.count
        println("sectionCount\(data.count)")
        return sectionCount!
        
    }
    //cell Number
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var  key: String = self.Index.objectAtIndex(section) as! String
        //return self.data[key]!.count
        let rowNum = self.data[key]!.count
        println("rowNum\(rowNum)")
        return rowNum;
    }
    //creat Cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var section = indexPath.section
        var  row = indexPath.row
        var  key: String = self.Index.objectAtIndex(section) as! String
        var  indexs:NSArray = self.data[key]!
        
        
        let cellIdentifier : String = "Cell\(indexPath.section)\(indexPath.row)"
        var cell: AnyObject? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil{
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }else{
            while cell?.contentView.subviews.last != nil{
                let lastView : UIView = (cell?.contentView.subviews.last)! as! UIView
                lastView.removeFromSuperview()
            }
        }
        
        // cell!.textLabel?!.text = "text\(indexPath.section)\(indexPath.row)"
        cell!.textLabel?!.text = indexs[indexPath.row] as? String
        return cell! as! UITableViewCell;
        
    }
    
    
    //set Footer Height
    //     func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 20;
    //    }
    
    //set Header Height
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40;
    }
    //set Header Title
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return Index.objectAtIndex(section) as? String
    }
    //set Cell Row Height
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30;
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedIndexPath = indexPath
        return indexPath;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        struct Static{
//            static var count = 0
//        }
//        Static.count = 0
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        
        let selectedRow:NSInteger = userDefault.integerForKey("\(indexPath.section)")
        
        indexCode = IndexSettingData[indexPath.section].indexCode
        
        println("indexCode\(indexCode)")
        
        if selectedRow == 0 && HttpData.count < sectionCount{
            userDefault.setInteger(indexPath.row, forKey: "\(indexPath.section)")
            
            // 如果selectedCell为空
            if selectedCell == nil {
                cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
                
                if indexPath.row <= 9 {
                    selectedItems.addObject(indexCode+"0"+"\(indexPath.row+1)"); // 添加到数组中
                   // selectedPrice.addObject(<#anObject: AnyObject#>)
                }else {
                    selectedItems.addObject(indexCode+"\(indexPath.row+1)"); // 添加到数组中
                }
                selectedCell = cell!
                ++HttpData.count
              
            }else{
                let selectIndexPath = self.tableView.indexPathForCell(selectedCell!)
                
                if selectIndexPath?.section != indexPath.section{ // Not in the same section
                    cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
                    if indexPath.row <= 9 {
                        selectedItems.addObject(indexCode+"0"+"\(indexPath.row+1)"); // 添加到数组中
                    }else {
                        selectedItems.addObject(indexCode+"\(indexPath.row+1)"); // 添加到数组中
                    }
                    ++HttpData.count
                }else{ // In the same section
                    cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
                    selectedCell!.accessoryType = UITableViewCellAccessoryType.None
                    let selectedIndexpath = self.tableView.indexPathForCell(selectedCell!)
                    
                    
                    
                    if indexPath.row <= 9 {
                        selectedItems.removeObject(indexCode+"0"+"\(selectedIndexpath!.row+1)") // 删除原来的
                        selectedItems.addObject(indexCode+"0"+"\(indexPath.row+1)"); // 添加到数组中
                    }else {
                        selectedItems.removeObject(indexCode+"\(selectedIndexpath!.row+1)") // 删除原来的
                        selectedItems.addObject(indexCode+"\(indexPath.row+1)"); // 添加到数组中
                    }
                }
                selectedCell = cell
            }
        }else{
            let currentSelectedSection = selectedIndexPath!.section
            let currentSelectedRow = userDefault.integerForKey("\(currentSelectedSection)")
            
            
            let currentIndexPath = NSIndexPath.init(forRow: currentSelectedRow, inSection: currentSelectedSection)
            
            selectedCell = self.tableView.cellForRowAtIndexPath(currentIndexPath)
            
            // 如果点击的不是同一行
            if currentSelectedRow != selectedIndexPath!.row{
                selectedCell!.accessoryType = UITableViewCellAccessoryType.None
                cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
                
                let selectedIndexpath = self.tableView.indexPathForCell(selectedCell!)
                
                
                if indexPath.row <= 9 {
                    selectedItems.removeObject(indexCode+"0"+"\(selectedIndexpath!.row+1)") // 删除原来的
                    selectedItems.addObject(indexCode+"0"+"\(indexPath.row+1)"); // 添加到数组中
                }else {
                    selectedItems.removeObject(indexCode+"\(selectedIndexpath!.row+1)") // 删除原来的
                    selectedItems.addObject(indexCode+"\(indexPath.row+1)"); // 添加到数组中
                }
                
                userDefault.setInteger(indexPath.row, forKey: "\(indexPath.section)")
                
                selectedCell = cell
            }else{
                let selectedIndexpath = self.tableView.indexPathForCell(selectedCell!)
                cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
                if indexPath.row <= 9 {
                    selectedItems.removeObject(indexCode+"0"+"\(selectedIndexpath!.row+1)") // 删除原来的
                    selectedItems.addObject(indexCode+"0"+"\(indexPath.row+1)"); // 添加到数组中
                }else {
                    selectedItems.removeObject(indexCode+"\(selectedIndexpath!.row+1)") // 删除原来的
                    selectedItems.addObject(indexCode+"\(indexPath.row+1)"); // 添加到数组中
                }

                userDefault.setInteger(indexPath.row, forKey: "\(indexPath.section)")
                selectedCell = cell
            }
            HttpData.count = sectionCount!
            
        }
       println("selected\(selectedItems)")
        
           }
    
    func readNSUerDefaults () {
        
        let userDefaultes = NSUserDefaults.standardUserDefaults()
        
        ServiceType = userDefaultes.stringForKey("ServiceType")!
    }
    
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
