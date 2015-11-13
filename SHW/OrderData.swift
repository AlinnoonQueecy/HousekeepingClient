//
//  OrderData.swift
//  SHW
//
//  Created by Zhang on 15/8/5.
//  Copyright (c) 2015年 star. All rights reserved.
//

import Foundation
import UIKit

//根据订单编号查找订单详细信息
func getOrderData(orderNo:String) ->Finishinfo  {
    let url: NSURL! = NSURL(string:HttpData.http+"/NationalService/MobileServiceOrderAction?operation=_queryDetail")
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    let param:String = "{\"orderNo\":\"\(orderNo)\"}"
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
     var orderData:Finishinfo?
    let test1: AnyObject?=json.objectForKey("serverResponse")
    let response1 :String = test1 as! String
    if  response1 == "Success"{
    let value: AnyObject?=json.objectForKey("data")
 
 
            let confirmTime:String=value!.objectForKey("confirmTime") as! String
            let customerID:String=value!.objectForKey("customerID") as! String
            let customerName:String=value!.objectForKey("customerName") as! String
            let id:Int=value!.objectForKey("id") as! Int
            let orderNo:String=value!.objectForKey("orderNo") as! String
            
            let orderStatus:String=value!.objectForKey("orderStatus") as! String
            let orderTime:String=value!.objectForKey("orderTime") as! String
            let paidAmount:Float=value!.objectForKey("paidAmount") as! Float
            let remarks:String=value!.objectForKey("remarks") as! String
            let servantID:String=value!.objectForKey("servantID") as! String
            
            
            let servantName:String=value!.objectForKey("servantName") as! String
            let serviceContent:String=value!.objectForKey("serviceContent") as! String
            let servicePrice:Float=value!.objectForKey("servicePrice") as! Float
            let serviceType:String=value!.objectForKey("serviceType") as! String
            let contactPhone:String=value!.objectForKey("contactPhone") as! String
            
            let payTime:String=value!.objectForKey("payTime") as! String
            let commentTime:String=value!.objectForKey("commentTime") as! String
            let payType:String=value!.objectForKey("payType") as! String
            let contactAddress:String=value!.objectForKey("contactAddress") as! String
            let servantPhone:String=value!.objectForKey("servantPhone") as! String
        
        
            
        let obj:Finishinfo=Finishinfo(confirmTime: confirmTime, customerID: customerID, customerName: customerName, id: id, orderNo: orderNo, orderStatus: orderStatus, orderTime: orderTime, paidAmount: paidAmount, remarks: remarks, servantID: servantID, servantName: servantName, serviceContent: serviceContent, servicePrice: servicePrice, serviceType: serviceType,contactPhone:contactPhone,payTime:payTime,commentTime:commentTime,payType:payType,contactAddress:contactAddress,servantPhone:servantPhone)
        
          orderData = obj
    
    }
    
    return orderData!
    
}


////客户直接下单（A）
func QureyDeclare (customerID:String,customerName:String,servantID:String,servantName:String,phoneNo:String,serviceTime:String,serviceProvince:String,serviceCity:String,serviceCounty:String,serviceAddress:String,serviceLongitude:String,serviceLatitude:String,salary:String,serviceType:String,remarks:String,isDirected:String)->String{
    let url: NSURL! = NSURL(string:HttpData.http+"/NationalService/MobileServiceDeclareAction?operation=_add")
 
    let request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    
    let param:String = "{\"customerID\":\"\(customerID)\",\"customerName\":\"\(customerName)\",\"servantID\":\"\(servantID)\",\"servantName\":\"\(servantName)\",\"phoneNo\":\"\(phoneNo)\",\"serviceTime\":\"\(serviceTime)\",\"serviceProvince\":\"\(serviceProvince)\",\"serviceCity\":\"\(serviceCity)\",\"serviceCounty\":\"\(serviceCounty)\",\"serviceAddress\":\"\(serviceAddress)\",\"serviceLongitude\":\"\(serviceLongitude)\",\"serviceLatitude\":\"\(serviceLatitude)\",\"salary\":\"\(salary)\",\"serviceType\":\"\(serviceType)\",\"remarks\":\"\(remarks)\",\"isDirected\":\"\(isDirected)\"}"
    
    print("param")
    print(param)
    
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
    //        var dic = dict as! NSDictionary
    print(json)
    let serverResponse = json!.objectForKey("serverResponse") as? String
    
    return serverResponse!
}


