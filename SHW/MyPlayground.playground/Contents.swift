 
 import Foundation
 import UIKit

 
 
 //创建NSURL
 var url: NSURL! = NSURL(string:"http://192.168.1.101:8080/FamilyServiceSystem/MobileHomePictureAction?operation=_query")
 //创建请求对象
 var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
 //响应对象
 var response:NSURLResponse?
 //错误对象
 var error:NSError?
 //发出请求
 var data:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
 if (error != nil)
 {
    println(error?.code)
    println(error?.description)
 }
 else
 {
    var jsonString = NSString(data:data!, encoding: NSUTF8StringEncoding)
    println(jsonString)
    
 }
 
 var json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil)
 var test1: AnyObject?=json?.objectForKey("serverResponse")
 var test2: AnyObject?=json?.objectForKey("data")
 let jsonArray = test2 as? NSArray
 var count = jsonArray?.count
 
 
//    var AdvertiseData:[facilitatorAdvertise] = []
//    for value in jsonArray!{
//        var id:Int=value.objectForKey("id") as! Int
//        var facilitatorID:String=value.objectForKey("facilitatorID") as! String
//        var facilitatorName:String=value.objectForKey("facilitatorName") as! String
//        var contactName:String=value.objectForKey("contactName") as! String
//        var contactNo:String=value.objectForKey("contactNo") as! String
//        
//        
//        var emailAddress:String=value.objectForKey("emailAddress") as! String
//        var advertiseType:String=value.objectForKey("advertiseType") as! String
//        var orderDate:String=value.objectForKey("orderDate") as! String
//        var startDate:String=value.objectForKey("startDate") as! String
//        var endDate:String=value.objectForKey("endDate") as! String
//        
//        
//        var advertiseTopic:String=value.objectForKey("advertiseTopic") as! String
//        
//        var advertiseIntro:String=value.objectForKey("advertiseIntro") as! String
//        
//        var advertisePicture:String=value.objectForKey("advertisePicture") as! String
//        
//        
//        let obj:facilitatorAdvertise=facilitatorAdvertise(id: id,facilitatorID:facilitatorID,facilitatorName:facilitatorName,contactName:contactName,contactNo:contactNo,emailAddress:emailAddress,advertiseType:advertiseType,orderDate:orderDate,startDate:startDate, endDate:endDate,advertiseTopic:advertiseTopic,advertiseIntro:advertiseIntro,advertisePicture:advertisePicture)
//        
//        AdvertiseData += [obj]
//        println()
//        
//    }
//    return AdvertiseData
//    
//}



