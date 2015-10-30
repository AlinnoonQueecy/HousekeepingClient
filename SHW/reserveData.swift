//
//  reserveData.swift
//  SHW
//
//  Created by Zhang on 15/7/17.
//  Copyright (c) 2015年 star. All rights reserved.


import Foundation
import UIKit
//var FinishiData:[Finishinfo] = []

class DeclaresInfo:NSObject {
    var id:Int
    var customerID:String
    var customerName:String
    var servantID:String
    var servantName:String
    
    
    var phoneNo  :String
    var declareTime:String
    var serviceTime:String
    var serviceProvince:String
    var serviceCity:String
    
    
    var serviceCounty:String
    var serviceAddress:String
    var serviceLongitude:String
    var serviceLatitude:String
    var salary:Double
    
    var serviceType:String
    var remarks:String
    var isAccepted:Int
    var orderNo:String
    
    init(id:Int,customerID:String,customerName:String,servantID:String
        ,servantName:String,phoneNo  :String,declareTime:String,serviceTime:String,serviceProvince:String,serviceCity:String,serviceCounty:String,serviceAddress:String,serviceLongitude:String,serviceLatitude:String,salary:Double,serviceType:String,remarks:String,isAccepted:Int,orderNo:String){
            
             self.id = id
            self.customerID = customerID
            self.customerName = customerName
            self.servantID = servantID
            self.servantName = servantName
            
            
            self.phoneNo = phoneNo
            self.declareTime = declareTime
            self.serviceTime = serviceTime
            self.serviceProvince = serviceProvince
            self.serviceCity = serviceCity
            
            self.serviceCounty = serviceCounty
            self.serviceAddress = serviceAddress
            self.serviceLongitude = serviceLongitude
            self.serviceLatitude = serviceLatitude
            self.salary = salary
            
            
            self.serviceType = serviceType
            self.remarks = remarks
            self.isAccepted = isAccepted
            self.orderNo = orderNo
            
            super.init()
    }
    
}


//查询自己发布的需求(A)
func QueryDeclareData(customerID:String,isAccepted:Int) ->NSArray  {
    
    let url: NSURL! = NSURL(string: HttpData.http+"/NationalService/MobileServiceDeclareAction?operation=_queryDeclares")
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    let param:String = "{\"customerID\":\"\(customerID)\",\"isAccepted\":\"\(isAccepted)\"}"
    print("param:\(param)")
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
    
    
    var DeclaresData:[DeclaresInfo] = []
    let test1: AnyObject?=json.objectForKey("serverResponse")
    let  response1 :String = test1 as! String
    if  response1 == "Success"{
        let test2: AnyObject?=json.objectForKey("data")
        let jsonArray = test2 as? NSArray
        _ = jsonArray?.count
        
        for value in jsonArray!{
            
             let id:Int=value.objectForKey("id") as! Int
            let servantID:String=value.objectForKey("servantID") as! String
            let servantName:String=value.objectForKey("servantName")
                as! String
            let customerID:String=value.objectForKey("customerID") as! String
            let customerName:String=value.objectForKey("customerName") as! String
            
            
            let phoneNo:String=value.objectForKey("phoneNo") as! String
            let declareTime:String=value.objectForKey("declareTime") as! String
            let serviceTime:String=value.objectForKey("serviceTime") as! String
            let serviceProvince:String=value.objectForKey("serviceProvince") as! String
            let serviceCity:String=value.objectForKey("serviceCity") as! String
            
            
            let serviceCounty:String=value.objectForKey("serviceCounty") as! String
            let serviceAddress:String=value.objectForKey("serviceAddress") as! String
            let serviceLongitude:String=value.objectForKey("serviceLongitude") as! String
            let serviceLatitude:String=value.objectForKey("serviceLatitude") as! String
            let salary:Double=value.objectForKey("salary") as! Double
            
            
            let serviceType:String=value.objectForKey("serviceType") as! String
            let remarks:String=value.objectForKey("remarks") as! String
            let isAccepted:Int=value.objectForKey("isAccepted") as! Int
            let orderNo:String=value.objectForKey("orderNo") as! String
         
            
            let obj:DeclaresInfo=DeclaresInfo(id:id,customerID:customerID,customerName:customerName,servantID:servantID,servantName:servantName,phoneNo:phoneNo,declareTime:declareTime,serviceTime:serviceTime,serviceProvince:serviceProvince,serviceCity:serviceCity,serviceCounty:serviceCounty,serviceAddress:serviceAddress,serviceLongitude:serviceLongitude,serviceLatitude:serviceLatitude,salary:salary,serviceType:serviceType,remarks:remarks,isAccepted:isAccepted,orderNo:orderNo)
            
            DeclaresData += [obj]
           
        }
    }
    return DeclaresData
    
}


//取消发布的需求的函数（A）
func deleteDeclare(id:Int) ->String  {
    //要改URL
    let url: NSURL! = NSURL(string: HttpData.http+"/NationalService/MobileServiceDeclareAction?operation=_cancle")
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //要改参数类型
    let param:String = "{\"id\":\"\(id)\"}"
    
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
    
    
    let serviceresponse: AnyObject?=json.objectForKey("serverResponse")
    let Response :String = serviceresponse as! String
    
    
    return Response
}





 