//
//  InfoListVC.swift
//  SHW
//
//  Created by Zhang on 15/7/29.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class InfoListVC: UIViewController,NSURLConnectionDataDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    //声明导航条
    var navigationBar : UINavigationBar?
    //声明headPicture
    var headPicture:UIImageView?
    //声明六个button
    var button1 :UIButton?
    var button2 :UIButton?
    var button3 :UIButton?
    var button4 :UIButton?
    var button5 :UIButton?
    var quit :UIButton?
    
    var imagePicker:UIImagePickerController!
  
    var av:UIActivityIndicatorView!

    //读取本地数据
    var customerid:String = ""
    var loginPassword:String = ""
    //存储获取的用户信息
    var info:MyInfo!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        print("本地存储")
        print(customerid)
        print(loginPassword)
        info = QueryInfo(customerid) as MyInfo
        let  width = self.view.frame.width
        let  height = self.view.frame.height
        //实例化导航条
        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.width, 64))
        navigationBar?.barTintColor = UIColor.orangeColor()
        navigationBar?.translucent = false
        navigationBar?.barStyle = UIBarStyle.Default
        let navigationTitleAttribute: NSDictionary = NSDictionary(objectsAndKeys: UIColor.whiteColor(), NSForegroundColorAttributeName)
        navigationBar?.titleTextAttributes =  navigationTitleAttribute as [NSObject: AnyObject]
        self.view.addSubview(navigationBar!)
        print("创建导航条详情")
        onMakeNavitem()
        
        let headY = CGFloat(100)
        
        headPicture = UIImageView(frame: CGRectMake(width/2-50, headY, CGFloat(100),CGFloat(100)))
//        headPicture = UIImageView()
//        headPicture!.frame.origin = CGPoint(x:width/2-90,y:headY);
        headPicture!.contentMode = UIViewContentMode.ScaleAspectFit;
        headPicture!.layer.cornerRadius = 50;
        headPicture!.layer.masksToBounds = true;
        // headPicture = UIImageView(frame: CGRectMake(width/2-90, headY, CGFloat(180),CGFloat(150)))
        
        //网络地址获取图片
        //1.定义一个地址字符串常量
        print("客户")
        let imageUrlString:String = HttpData.http+"/NationalService/\(info.headPicture)"
        print("imageUrlString:\(imageUrlString)")
        //        //2.通过String类型，转换NSUrl对象
        let url:NSString = imageUrlString.URLEncodedString()
      

        headPicture!.setZYHWebImage(url as String, defaultImage: "touxiang.jpg")
        
//            headPicture!.image = UIImage(named: "touxiang.jpg")!
     
        self.view.addSubview(headPicture!)
        
        let buttonW = width
       let buttonY = CGFloat(headY+160)
       let buttonH = CGFloat((height-320)/5)
        button1 = UIButton(frame:CGRectMake(0,buttonY,buttonW,buttonH))
        button1!.setTitle("修改头像", forState: UIControlState.Normal)
        button1!.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button1!.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
       // button1!.backgroundColor = UIColor.orangeColor()
        button1!.titleLabel!.font = UIFont.systemFontOfSize(14)
        button1!.addTarget(self , action: Selector("JumpTo1"), forControlEvents: UIControlEvents.TouchUpInside)
//        button1?.hidden = true
        self.view.addSubview(button1!)
        button2 = UIButton(frame:CGRectMake(0,buttonY+buttonH,buttonW,buttonH))
        button2!.setTitle("基本资料", forState: UIControlState.Normal)
        button2!.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button2!.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
        //button1!.backgroundColor = UIColor.orangeColor()
        button2!.titleLabel!.font = UIFont.systemFontOfSize(16)
        button2!.addTarget(self , action: Selector("JumpTo2"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button2!)
        button3 = UIButton(frame:CGRectMake(0,buttonY+2*buttonH,buttonW,buttonH))
        button3!.setTitle("修改密码", forState: UIControlState.Normal)
        button3!.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button3!.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
        //button1!.backgroundColor = UIColor.orangeColor()
        button3!.titleLabel!.font = UIFont.systemFontOfSize(16)
        button3!.addTarget(self , action: Selector("JumpTo3"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button3!)
//        button4 = UIButton(frame:CGRectMake(0,buttonY+3*buttonH,buttonW,buttonH))
//        button4!.setTitle("通用设置", forState: UIControlState.Normal)
//        button4!.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//        button4!.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
//        //button1!.backgroundColor = UIColor.orangeColor()
//        button4!.titleLabel!.font = UIFont.systemFontOfSize(16)
//        button4!.addTarget(self , action: Selector("JumpTo4"), forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(button4!)
//        button5 = UIButton(frame:CGRectMake(0,buttonY+4*buttonH,buttonW,buttonH))
//        button5!.setTitle("关于软件", forState: UIControlState.Normal)
//        button5!.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//        button5!.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
//        //button1!.backgroundColor = UIColor.orangeColor()
//        button5!.titleLabel!.font = UIFont.systemFontOfSize(16)
//        button5!.addTarget(self , action: Selector("JumpTo5"), forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(button5!)
        let quitX = CGFloat((width-250)/2)
        quit = UIButton(frame:CGRectMake(quitX,height-60,250,30))
        quit!.setTitle("退出当前登录", forState: UIControlState.Normal)
        quit!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        quit!.backgroundColor = UIColor.orangeColor()
        quit!.layer.cornerRadius = 5
        quit!.titleLabel!.font = UIFont.systemFontOfSize(17)
        quit!.addTarget(self , action: Selector("JumpTo6"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(quit!)
    }
    //跳转函数
    func JumpTo1(){
            //self.performSegueWithIdentifier("toHeadPicture", sender: self)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate=self
        imagePicker.sourceType=UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.modalTransitionStyle=UIModalTransitionStyle.CoverVertical
        imagePicker.allowsEditing=true
        self.presentViewController(imagePicker, animated:true, completion: nil)
        
        
    }
    func JumpTo2(){
        self.performSegueWithIdentifier("toBaseInfo", sender: self)
    }
    func JumpTo3(){
        self.performSegueWithIdentifier("toChangePassword", sender: self)
    }
    func JumpTo4(){
        //self.performSegueWithIdentifier("toBaseInfo", sender: self)
    }
    func JumpTo5(){
        //self.performSegueWithIdentifier("toBaseInfo", sender: self)
    }
    func JumpTo6(){
        removeNSUerDefaults()
//        HttpData.customerid = ""
//        HttpData.loginpassword  = ""
        self.performSegueWithIdentifier("toQuit", sender: self)

    }
    
    //上传图片
    func imagePickerController(picker:UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject :AnyObject])
    {
        self.dismissViewControllerAnimated(true, completion:nil);
        
        let gotImage=info[UIImagePickerControllerOriginalImage]as! UIImage
        
        let midImage:UIImage=self.imageWithImageSimple(gotImage,scaledToSize:CGSizeMake(100.0,100.0))//这是对图片进行缩放，因为固定了长宽，所以这个方法会变型，有需要的自已去完善吧， 这里只是粗略使用。
        upload(midImage)//上传
    }
    //缩放图片
    func imageWithImageSimple(image:UIImage,scaledToSize newSize:CGSize)->UIImage
    {
        UIGraphicsBeginImageContext(newSize);
        image.drawInRect(CGRectMake(0,0,newSize.width,newSize.height))
        let newImage:UIImage=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
        
    }
    
    //上传
    func upload(img:UIImage)
    {
        
        //        lb.frame=CGRectMake(0,0,300,20)
        //
        //        lb.textColor=UIColor.whiteColor()
        //        lb.text="上传中...."
        //        lb.textAlignment=NSTextAlignment.Center
        //        lb.backgroundColor=UIColor.blackColor()
        //        lb.alpha=1
        //
        //       // 添加风火轮
        //        av.frame=CGRectMake(200,200,20, 20)
        //        av.backgroundColor=UIColor.whiteColor()
        //        av.color=UIColor.redColor()
        //        av.startAnimating()
        
        
        
        //
        //        self.view.addSubview(av)
        //
        //        self.view.addSubview(lb)
        
        let data=UIImagePNGRepresentation(img)//把图片转成data
        print("data\(data)")
           headPicture!.image = UIImage(data: data!)
        
        let uploadurl:String="http://219.216.65.182:8080/NationalService/MultiFormAction?operation=_updateCustomerPicture"//设置服务器接收地址
        let request=NSMutableURLRequest(URL:NSURL(string:uploadurl)!)
        
        request.HTTPMethod="POST"//设置请求方式
        let boundary:String="-------------------"
        //上传文件必须设置
        let contentType:String="multipart/form-data;boundary="+boundary
        request.addValue(contentType, forHTTPHeaderField:"Content-Type")
        let body=NSMutableData()
        let customerID = customerid
        
        //        一个图片
        body.appendData(NSString(format:"\r\n--\(boundary)\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"Content-Disposition:form-data;name=\"userfile\";filename=\"1.jpg\"\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"Content-Type:application/octet-stream\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(data!)
        body.appendData(NSString(format:"\r\n--\(boundary)").dataUsingEncoding(NSUTF8StringEncoding)!)
        
        //        传入一个普通参数
        body.appendData(NSString(format:"\r\n--\(boundary)\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"Content-Disposition:form-data;name=\"customerID\"\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"Content-Type:text/plain;charset=utf-8\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"\(customerID)").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"\r\n--\(boundary)").dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        request.HTTPBody=body
        let que=NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: que, completionHandler: {
            (response, data, error) ->Void in
            
            if (error != nil){
            print(error)
        }else{
            //Handle data in NSData type
//             println("data\(data)")
//             println("response\(response)")
            let tr:AnyObject=NSString(data:data!,encoding:NSUTF8StringEncoding)!
            //var test2: AnyObject? = json?.objectForKey("tr")
//            let json:AnyObject? = NSJSONSerialization.JSONObjectWithData(tr, options: NSJSONReadingOptions.AllowFragments, error: nil)
//            //        var dic = dict as! NSDictionary
           // println(test2)
            print("tr\(tr)")
//            let serverResponse = tr.objectForKey("serverResponse") as? String
//            println(serverResponse)
          
            
            //在主线程中更新UI风火轮才停止
            dispatch_sync(dispatch_get_main_queue(), {
            //self.av.stopAnimating()
            //self.lb.hidden=true
            
            })
            
            }
            })
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //导航条详情
    func reply (){
        //self.dismissViewControllerAnimated(true, completion: nil)
        self.performSegueWithIdentifier("toQuit", sender: self)
    }
    
    func onMakeNavitem() -> UINavigationItem{
        print("创建导航条step1")
        //创建一个导航项
        let navigationItem = UINavigationItem()
        //创建左边按钮
        let leftButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "reply")
        //var leftButton =  UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Bordered, target: self, action: "reply")
        //导航栏的标题
        navigationItem.title = "我的信息"
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        
        navigationBar?.pushNavigationItem(navigationItem, animated: true)
        
        
        return navigationItem
    }
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        let userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
            customerid = userDefaultes.stringForKey("customerID")!
            loginPassword = userDefaultes.stringForKey("loginPassword")!
            
        }
        
    }
//    //清除NSUerDefaults中数据
    func removeNSUerDefaults () {
        
        //将数据全部存储到NSUerDefaults中
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //存储时，除了NSNumber类型使用对应的类型外，其他的都使用setObject:forKey:
        userDefaults.setObject("" , forKey: "customerID")
        userDefaults.setObject("", forKey: "loginPassword")
         
        //建议同步到磁盘，但不是必须得
        userDefaults.synchronize()
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == "toHeadPicture" {
            let controller = segue.destinationViewController as! ChangeHeadPictureVC
            let  object = info.headPicture
            let   customerid = info.customerID
            controller.Picturename = object
            controller.customerID = customerid
            
        }else if segue.identifier! == "toChangePassword" {
            let controller = segue.destinationViewController as! ChangePasswordVC
            let  object = info.loginPassword
            let  Id = info.id
            controller.Password = object
            controller.id = Id
            
        }

    }
            
}















