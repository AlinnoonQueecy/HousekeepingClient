//
//  LeftMenuVC.swift
//  SHW
//
//  Created by Zhang on 15/5/22.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class LeftMenuVC: UIViewController {
    //左菜单栏显示内容
 
//    var menuItems:[UIButton] = []
//    var menuItemTitles:[String] = [ "新闻资讯", "政务公开", "公共服务", "服务平台", "组织机构" ]
//    var menuItemImgs:[String] = [ "xwzx.png", "zwgk.png", "ggfw.png", "ffpt.png", "zzjg.png"]
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["第一项","第二项","第三项","第四项"]
    var businessListVC:UIViewController!
    //var secondVC :UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println( "leftMenu viewDidLoad" )
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
       // let secondVC = storyboard.instantiateViewControllerWithIdentifier("SecondVC") as! SecondVC
        //self.secondVC = UINavigationController(rootViewController: secondVC)
   
    }
    override func viewWillAppear(animated: Bool) {
        
        println( "leftMenu viewWillAppear" )
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println( "leftMenu viewDidAppear" )
    }
func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menus.count
}

func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
    cell.backgroundColor = UIColor(red: 64/255, green: 170/255, blue: 239/255, alpha: 1.0)
    cell.textLabel!.font = UIFont.italicSystemFontOfSize(18)
    cell.textLabel!.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    cell.textLabel!.text = menus[indexPath.row]
    return cell
}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

            println("ok")
       
                self.slideMenuController()?.changeMainViewController(self.businessListVC, close: true)
     

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

