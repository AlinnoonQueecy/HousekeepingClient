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
        return collections.count;//sectionData.count
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
    



}
