//
//  MainVC.swift
//  生活网/Users/zhang/Desktop/ Learn IOS/生活网/生活网/CollectionViewController.swift
//
//  Created by Zhang on 15/5/17.
//  Copyright (c) 2015年 Zhang. All rights reserved.
//

import UIKit

class MainVC: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //table.dataSource = self
        //table.delegate = self

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
        var cellId:String = "cellId"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier( cellId ) as! UITableViewCell?
        if cell == nil
        {
            cell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier: cellId)
            cell?.textLabel?.font = UIFont(name: "Times New Roman", size: 13)
        }
        //cell!.layer.cornerRadius=12
        //cell!.layer.masksToBounds = true
//        var sectionNo:Int = indexPath.section
//        var rowNo:Int = indexPath.row
//        var sectionTitle:String = HttpData.channelTitles[sectionNo]
//        var items:[Item] = HttpData.tableData[sectionTitle]!
//        var curItem:Item = items[rowNo]
//        cell!.textLabel?.text = curItem.title
//        cell!.detailTextLabel?.text = curItem.url
        return cell!
    }
    
    // Return the number of sections.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0;//HttpData.channelTitles.count
    }
    
    // Return the number of rows in the section.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var sectionTitle:String = HttpData.channelTitles[section]
//        var sectionData:[Item] = HttpData.tableData[sectionTitle]!
        return 0;//sectionData.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "";//HttpData.channelTitles[section]
    }
    
    
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

}
