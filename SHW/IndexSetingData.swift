//
//  PackageData.swift
//  SHW
//
//  Created by Zhang on 15/8/13.
//  Copyright (c) 2015年 star. All rights reserved.
//

import Foundation
//指标
class IndexSetting:NSObject {
    var id :Int
    var serviceType:String
    var indexCode:String
    var indexName:String
    var indexRange:String
    var price:String
   
    
    init(id :Int,serviceType:String,indexCode:String,indexName:String,indexRange:String,price:String ){
        self.id = id
        self.serviceType = serviceType
        self.indexCode = indexCode
        self.indexName = indexName
        self.indexRange = indexRange
        self.price = price
      
        
        super.init()
    }
    
}

//指标数据data
func refreshIndexSetting(select:String) ->NSArray  {
    
    let url: NSURL! = NSURL(string:HttpData.http+"/NationalService/MobileServiceTypeAction?operation=_queryIndex")
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    
    let param:String = "{\"serviceType\":\"\(select)\"}"
    
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
    var IndexSettingData:[IndexSetting] = []
    let serverResponse:String = test1 as! String
    if serverResponse == "Success" {
        let test2: AnyObject = json.objectForKey("data")!
        let jsonArray = test2 as? NSArray
        //var count = jsonArray?.count
        
        for value in jsonArray!{
            
            let id:Int=value.objectForKey("id") as! Int
            let serviceType:String=value.objectForKey("serviceType") as! String
            let indexCode:String=value.objectForKey("indexCode") as! String
            let indexName:String=value.objectForKey("indexName") as! String
            let indexRange:String=value.objectForKey("indexRange") as! String
            let price:String=value.objectForKey("price") as! String
            
            
            
            
            let obj:IndexSetting=IndexSetting(id :id,serviceType:serviceType,indexCode:indexCode,indexName:indexName,indexRange:indexRange,price:price)
             IndexSettingData += [obj]
            
            
            
        }
    }
    return IndexSettingData
    
}
//指标数据data
//func refreshIndexSetting(select:String) ->NSArray  {
//    
//    let url: NSURL! = NSURL(string:HttpData.http+"/NationalService/MobileServiceTypeAction?operation=_queryIndex")
//    
//    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
//    
//    request.HTTPMethod = "POST"
//    
//    let param:String = "{\"serviceType\":\"\(select)\"}"
//    
//    let data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
//    request.HTTPBody = data;
//    var response:NSURLResponse?
//    var error:NSError?
//    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
//    if (error != nil)
//    {
//        println(error?.code)
//        println(error?.description)
//    }
//    else
//    {
//        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
//        println(jsonString)
//        
//    }
//    
//    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
//    
//    let test1: AnyObject?=json.objectForKey("serverResponse")
//    var IndexSettingData:[IndexSetting] = []
//    let serverResponse:String = test1 as! String
//    if serverResponse == "Success" {
//        let test2: AnyObject = json.objectForKey("data")!
//        let jsonArray = test2 as? NSArray
//        //var count = jsonArray?.count
//        
//        for value in jsonArray!{
//            
//            let id:Int=value.objectForKey("id") as! Int
//            let serviceType:String=value.objectForKey("serviceType") as! String
//            let indexCode:String=value.objectForKey("indexCode") as! String
//            let indexName:String=value.objectForKey("indexName") as! String
//            let indexRange:String=value.objectForKey("indexRange") as! String
//            let typeID:String=value.objectForKey("typeID") as! String
//            
//            
//            
//            let obj:IndexSetting=IndexSetting(id :id,serviceType:serviceType,indexCode:indexCode,indexName:indexName,indexRange:indexRange,typeID:typeID )
//            IndexSettingData += [obj]
//            
//            
//            
//        }
//    }
//    return IndexSettingData
//    
//}
//


//1.1.	根据类型指标值查询价格
func getPrice(serviceType:String,indexValue:String) ->String  {
    let url: NSURL! = NSURL(string: HttpData.http+"/NationalService/MobileServiceTypeAction?operation=_queryPrice")
 
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    
    let param:String = "{\"serviceType\":\"\(serviceType)\",\"indexValue\":\"\(indexValue)\"}"
    println("param\(param)")
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
    //var finishinfo = finishinfo()
    //var FinishData:[finishinfo] = []
    let test1: AnyObject?=json.objectForKey("serverResponse")
    
    var serverResponse:String
    serverResponse = test1 as! String
    println("serverResponse\(serverResponse)")
    var price:String!
    
    if serverResponse == "Success" {
        let test2: AnyObject?=json?.objectForKey("data")
     
        price = test2 as! String
        
       }
    
    println("price\(price)")
    return  price
}