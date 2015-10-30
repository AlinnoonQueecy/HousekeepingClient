//
//  WebVC.swift
//  SHW
//
//  Created by Zhang on 15/6/15.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class WebVC: UIViewController {
    
    @IBAction func reply(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil )
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
