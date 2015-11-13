////
//  MainVCdata.swift
//  SHW
//
//  Created by Zhang on 15/7/17.
//  Copyright (c) 2015年 star. All rights reserved.
//
import Foundation
import UIKit
 

class ServiceType:NSObject {
    var id :Int
    var typeName:String
    var typeIntro:String
    var typeLogo:String
    
    var parentId:Int

    init(id :Int,typeName:String,typeIntro:String,typeLogo:String,parentId:Int){
            self.id = id
            self.typeName = typeName
            self.typeIntro = typeIntro
            self.typeLogo = typeLogo
            self.parentId = parentId
  
            super.init()
    }
    
}

//查询父类(A)
func refreshParentType(select:String) ->NSArray  {
    let url: NSURL! = NSURL(string:HttpData.http+"/NationalService/MobileServiceTypeAction?operation=_query")
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    
    let param:String = "{\"typeName\":\"\(select)\"}"
   
    let data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    request.HTTPBody = data;
    var response:NSURLResponse?
    var error:NSError?
    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    if (error != nil)
    {
        println(error?.code)
        println(error?.description)
    }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
        println(jsonString)
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
    
    let test1: AnyObject?=json.objectForKey("serverResponse")
    var ServiceTypeData:[ServiceType] = []
    let serverResponse:String = test1 as! String
    if serverResponse == "Success" {
        let test2: AnyObject = json.objectForKey("data")!
        let jsonArray = test2 as? NSArray
       
        
        for value in jsonArray!{
            
            let id:Int=value.objectForKey("id") as! Int
            let typeName:String=value.objectForKey("typeName") as! String
            let typeIntro:String=value.objectForKey("typeIntro") as! String
            let typeLogo:String=value.objectForKey("typeLogo") as! String
            
            let parentId:Int=value.objectForKey("parentId") as! Int
            
            
            let obj:ServiceType=ServiceType(id:id,typeName:typeName,typeIntro:typeIntro,typeLogo:typeLogo,parentId:parentId )
            
            ServiceTypeData += [obj]
            
            
            
        }
    }
    return ServiceTypeData
}


//根据父类查询子类(A)
func refreshServiceType(select:String) ->NSArray  {
    let url: NSURL! = NSURL(string:HttpData.http+"/NationalService/MobileServiceTypeAction?operation=_query")
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
  
    let param:String = "{\"typeName\":\"\(select)\"}"
   
    let data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    request.HTTPBody = data;
    var response:NSURLResponse?
    var error:NSError?
    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    if (error != nil)
    {
        println(error?.code)
        println(error?.description)
    }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
        println(jsonString)
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
   
    let test1: AnyObject?=json.objectForKey("serverResponse")
    var ServiceTypeData:[ServiceType] = []
    let serverResponse:String = test1 as! String
    if serverResponse == "Success" {
    let test2: AnyObject = json.objectForKey("data")!
    let jsonArray = test2 as? NSArray
    for value in jsonArray!{
        
        let id:Int=value.objectForKey("id") as! Int
        let typeName:String=value.objectForKey("typeName") as! String
        let typeIntro:String=value.objectForKey("typeIntro") as! String
        let typeLogo:String=value.objectForKey("typeLogo") as! String
        let parentId:Int=value.objectForKey("parentId") as! Int
        let obj:ServiceType=ServiceType(id:id,typeName:typeName,typeIntro:typeIntro,typeLogo:typeLogo,parentId:parentId )
        ServiceTypeData += [obj]
        }
    }
    return ServiceTypeData
    
}



//根据子类名称得到其详情
//func getServiceType(select:String) ->ServiceType{
//    println("chaxunzileixiangqing")
//    //要改URL
//    var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileServiceTypeAction?operation=_queryByName")
//    
//    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
//    
//    request.HTTPMethod = "POST"
//    
//    var param:String = "{\"typeName\":\"\(select)\"}"
//    println("typeName\(select)")
//    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
//    request.HTTPBody = data;
//    var response:NSURLResponse?
//    var error:NSError?
//    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
//    if (error != nil)
//    {
//        println(error?.code)
//        println(error?.description)
//        
//    }
//    else
//    {
//        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
//        println("jsonString\(jsonString)")
//        
//    }
//    
//    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
// 
//    var test1: AnyObject?=json.objectForKey("serverResponse")
//    var ServiceTypeData:ServiceType?
//    var serverResponse:String = test1 as! String
//    
//    if serverResponse == "Success" {
//        var value: AnyObject = json.objectForKey("data")!
//      
//            println("serverResponse\(serverResponse)")
//            var id:Int=value.objectForKey("id") as! Int
//            println("id\(id)")
//
//            var typeName:String=value.objectForKey("typeName") as! String
//            var typeIntro:String=value.objectForKey("typeIntro") as! String
//            var typeLogo:String=value.objectForKey("typeLogo") as! String
//            var isPerson:String=value.objectForKey("isPerson") as! String
//            var parentId:Int=value.objectForKey("parentId") as! Int
//            
//            
//            let obj:ServiceType=ServiceType(id: id,typeName:typeName,typeIntro:typeIntro,typeLogo:typeLogo,isPerson:isPerson,parentId:parentId )
//            
//            ServiceTypeData = obj
//            //        println(obj)
//            
//       
//    }
//    return ServiceTypeData!
//
//}
//






class  HomeAdvertise:NSObject{
    var id:Int
    var contactName:String
    var contactNo:String
    var emailAddress:String
    var advertiseType:String
    
    
    var orderDate:String
    var startDate:String
    var endDate:String
    
    var advertiseTopic:String
    var advertiseIntro:String
    var advertisePicture:String
  
    init(id :Int,contactName:String,contactNo:String,emailAddress:String,advertiseType:String,orderDate:String,startDate:String,endDate:String ,advertiseTopic:String,advertiseIntro:String,advertisePicture:String  ){
        self.id = id
        self.contactName = contactName
        self.contactNo = contactNo
        self.emailAddress = emailAddress
        self.advertiseType = advertiseType
        
        self.orderDate = orderDate
        self.startDate = startDate
        self.endDate = endDate
        
        self.advertiseTopic = advertiseTopic
        self.advertiseIntro = advertiseIntro
        self.advertisePicture = advertisePicture
        
        super.init()
    }
    
}
//广告数据查询
func refreshAdvertise() ->NSArray  {
 
    
    //创建NSURL
    let url: NSURL! = NSURL(string: HttpData.http+"/NationalService/MobileFacilitatorAdvertiseAction?operation=_query")
    print("url:\(url)")
    //创建请求对象
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    //响应对象
    var response:NSURLResponse? 
    //错误对象
    var error:NSError?
    //发出请求
    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    if (error != nil)
    {
        println(error?.code)
        println(error?.description)
    }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
        //println(jsonString)
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
//    print("json\(json)")
    let test1: AnyObject?=json?.objectForKey("serverResponse")
    let serverResponse:String = test1 as! String
    var AdvertiseData:[HomeAdvertise] = []
    
    if serverResponse == "Success" {
    let test2: AnyObject?=json?.objectForKey("data")
    let jsonArray = test2 as? NSArray
 //   var count = jsonArray?.count
    
   // print("dsvcqgrdbwvr")
    for value in jsonArray!{
        
        let id:Int=value.objectForKey("id") as! Int
        let contactName:String=value.objectForKey("contactName") as! String
        let contactNo:String=value.objectForKey("contactNo") as! String
        let emailAddress:String=value.objectForKey("emailAddress") as! String
        let advertiseType:String=value.objectForKey("advertiseType") as! String
        
        
        let orderDate:String=value.objectForKey("orderDate") as! String
        let startDate:String=value.objectForKey("startDate") as! String
        let endDate:String=value.objectForKey("endDate") as! String
        
        let advertiseTopic:String=value.objectForKey("advertiseTopic") as! String
        let advertiseIntro:String=value.objectForKey("advertiseIntro") as! String
        let advertisePicture:String=value.objectForKey("advertisePicture") as! String
        
        let obj:HomeAdvertise=HomeAdvertise(id :id,contactName:contactName,contactNo:contactNo,emailAddress:emailAddress,advertiseType:advertiseType,orderDate:orderDate,startDate:startDate,endDate:endDate ,advertiseTopic:advertiseTopic,advertiseIntro:advertiseIntro,advertisePicture:advertisePicture)
        
           AdvertiseData += [obj]
        
       // print(AdvertiseData)
        
       }
    }
    return AdvertiseData
    
}



func getImageData(url:String?)->NSData?{
    
    var dataA:NSData?
 
        let data:NSData?=ZYHWebImageChcheCenter.readCacheFromUrl(url!)
    
        if data != nil {
            dataA = data
            print("直接读缓存")
            
        }else{
         
            let URL:NSURL = NSURL(string:url!)!
            let data:NSData?=NSData(contentsOfURL: URL)
            
            if data != nil {
                
                dataA = data
                //写缓存
                print("写缓存1")
                ZYHWebImageChcheCenter.writeCacheToUrl(url!, data: data!)
                
            }
        }
    
    print("直接")
    return dataA
    
}












