//
//  finishiorder.swift
//  SHW
//
//  Created by Zhang on 15/7/7.
//  Copyright (c) 2015年 star. All rights reserved.
//
//
import Foundation
import UIKit
//var FinishiData:[Finishinfo] = []

class Finishinfo:NSObject {
    var id:Int
    var orderNo:String
    var customerID:String
    var customerName:String
    var servantID:String
    
    
    var servantName:String
    var serviceType:String
    var orderTime:String
    var serviceContent:String
    var payTime:String
    
    
    var commentTime:String
    var confirmTime:String
    var payType:String
    var contactAddress:String
    var servicePrice:Float
    
    
    var paidAmount:Float
    var orderStatus:String
    var remarks:String
    var contactPhone:String
    var servantPhone:String
   
    init(confirmTime:String, customerID:String,customerName:String, id:Int, orderNo:String,orderStatus:String,orderTime:String, paidAmount:Float,remarks:String,servantID:String,servantName:String,serviceContent:String,servicePrice:Float ,serviceType:String,contactPhone:String,payTime:String,commentTime:String,payType:String,contactAddress:String,servantPhone:String
              ){
        self.confirmTime = confirmTime
        self.customerID = customerID
        self.customerName = customerName
        self.id = id
        self.orderNo = orderNo
            
        self.orderStatus = orderStatus
        self.orderTime = orderTime
        self.paidAmount = paidAmount
        self.remarks = remarks
        self.servantID = servantID
                

        self.servantName = servantName
        self.serviceContent = serviceContent
        self.servicePrice = servicePrice
        self.serviceType = serviceType
        self.contactPhone = contactPhone
                
                
                self.payTime = payTime
                self.commentTime = commentTime
                self.payType = payType
                self.contactAddress = contactAddress
                 self.servantPhone = servantPhone
                
        super.init()
    }
    
}





//查询订单(A)
func refreshOrderData(customerID:String,orderStatus:String) ->NSArray  {
    
    let url: NSURL! = NSURL(string: HttpData.http+"/NationalService/MobileServiceOrderAction?operation=_queryCOrder")
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    let param:String = "{\"customerID\":\"\(customerID)\",\"orderStatus\":\"\(orderStatus)\"}"
    println(param)
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
    
    var FinishiData:[Finishinfo] = []
    let test1: AnyObject?=json.objectForKey("serverResponse")
    let  response1 :String = test1 as! String
    if  response1 == "Success"{
        let test2: AnyObject?=json.objectForKey("data")
        let jsonArray = test2 as? NSArray
        _ = jsonArray?.count
        
        for value in jsonArray!{
            let confirmTime:String=value.objectForKey("confirmTime") as! String
            let customerID:String=value.objectForKey("customerID") as! String
            let customerName:String=value.objectForKey("customerName") as! String
            let id:Int=value.objectForKey("id") as! Int
            let orderNo:String=value.objectForKey("orderNo") as! String
            
            let orderStatus:String=value.objectForKey("orderStatus") as! String
            let orderTime:String=value.objectForKey("orderTime") as! String
            let paidAmount:Float=value.objectForKey("paidAmount") as! Float
            let remarks:String=value.objectForKey("remarks") as! String
            let servantID:String=value.objectForKey("servantID") as! String
            
            
            let servantName:String=value.objectForKey("servantName") as! String
            let serviceContent:String=value.objectForKey("serviceContent") as! String
            let servicePrice:Float=value.objectForKey("servicePrice") as! Float
            let serviceType:String=value.objectForKey("serviceType") as! String
            let contactPhone:String=value.objectForKey("contactPhone") as! String
            
            let payTime:String=value.objectForKey("payTime") as! String
            let commentTime:String=value.objectForKey("commentTime") as! String
            let payType:String=value.objectForKey("payType") as! String
            let contactAddress:String=value.objectForKey("contactAddress") as! String
            let servantPhone:String=value.objectForKey("servantPhone") as! String

            
            
            
            let obj:Finishinfo=Finishinfo(confirmTime: confirmTime, customerID: customerID, customerName: customerName, id: id, orderNo: orderNo, orderStatus: orderStatus, orderTime: orderTime, paidAmount: paidAmount, remarks: remarks, servantID: servantID, servantName: servantName, serviceContent: serviceContent, servicePrice: servicePrice, serviceType: serviceType,contactPhone:contactPhone,payTime:payTime,commentTime:commentTime,payType:payType,contactAddress:contactAddress,servantPhone:servantPhone)
            
            FinishiData += [obj]
          
        }
    }
    return FinishiData
    
}


////1.1.	确认服务完成(A)
func vetifyFinish(orderNo:String) ->String  {

    let url: NSURL! = NSURL(string: HttpData.http+"/NationalService/MobileServiceOrderAction?operation=_vetifyFinish")

    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)

    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    let param:String = "{\"orderNo\":\"\(orderNo)\"}"
    print("VetifyFinish:\(param)")
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
    let  response1 :String = test1 as! String
    print("response1:\(response1)")
    return response1

}
////1.1.接受该人员服务(A)
func confirmServant(orderNo:String) ->String  {
    
    let url: NSURL! = NSURL(string: HttpData.http+"/NationalService/MobileServiceOrderAction?operation=_vetifyAccept")
    
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
    
    
    
    let test1: AnyObject?=json.objectForKey("serverResponse")
    let  response1 :String = test1 as! String
    print("response1:\(response1)")
    return response1
    
}
////1.1.拒绝该人员服务(A)
func RefuseServant(orderNo:String) ->String  {
    
    let url: NSURL! = NSURL(string: HttpData.http+"/NationalService/MobileServiceOrderAction?operation=_vetifyRefuse")
    
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
    
    
    
    let test1: AnyObject?=json.objectForKey("serverResponse")
    let  response1 :String = test1 as! String
    print("response1:\(response1)")
    return response1
    
}
//

//
////orderNo:订单编号
////customerID：客户ID
////contactPhone：联系人电话
////facilitatorID：公司名字
////reason：申请理由
////money：退款金额
//
////退款申请
//class RefundInfo:NSObject {
//    var id:Int
//    var orderNo:String
//    var alipayOrderID:String
//    var reason:String
//    var money:Float
//    
//    var status:String
//    var applyTime:String
//    var confirmTime:String
//    var refundDate:String
//    var customerID:String
//    
//    var customerPhone:String
//    var facilitatorID:String
//    var batchNo:String
//    
//
//    init(id:Int,orderNo:String,alipayOrderID:String,reason:String,money:Float,status:String,
//       applyTime:String,confirmTime:String,refundDate:String,customerID:String,customerPhone:String,facilitatorID:String,batchNo:String ){
//        
//            
//            self.id = id
//            self.orderNo = orderNo
//            self.alipayOrderID = alipayOrderID
//            self.reason = reason
//            self.money = money
//           
//            self.status = status
//            self.applyTime = applyTime
//            self.confirmTime = confirmTime
//            self.refundDate = refundDate
//            self.customerID = customerID
//           
//       
//            self.customerPhone = customerPhone
//            self.facilitatorID = facilitatorID
//            self.batchNo = batchNo
//             
//            super.init()
//    }
//    
//}
//
//
////申请退款
//func getRefund(orderNo:String,customerID:String,contactPhone:String,facilitatorID:String,reason:String,money:String) ->RefundInfo  {
//    
//    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileRefundAction?operation=_apply")
//    
//    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
//    
//    request.HTTPMethod = "POST"
//    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
//    var param:String = "{\"orderNo\":\"\(orderNo)\",\"customerID\":\"\(customerID)\",\"contactPhone\":\"\(contactPhone)\",\"facilitatorID\":\"\(facilitatorID)\",\"reason\":\"\(reason)\",\"money\":\"\(money)\"}"
//    println("param:\(param)")
//    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
//    println("data:\(data)")
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
//    
//    var FinishiData:RefundInfo!
//    var test1: AnyObject?=json.objectForKey("serverResponse")
//    var  response1 :String = test1 as! String
//    if  response1 == "Success"{
//        var value: AnyObject?=json.objectForKey("data")
////        let jsonArray = test2 as? NSArray
////        var count = jsonArray?.count
//        
////        for value in jsonArray!{
//            var id:Int=value!.objectForKey("id") as! Int
//            var orderNo:String=value!.objectForKey("orderNo") as! String
//            var alipayOrderID:String=value!.objectForKey("alipayOrderID") as! String
//            var reason:String=value!.objectForKey("reason") as! String
//            var money:Float=value!.objectForKey("money") as! Float
//           
//            
//            var status:String=value!.objectForKey("status") as! String
//            var applyTime:String=value!.objectForKey("applyTime") as! String
//            var confirmTime:String=value!.objectForKey("confirmTime") as! String
//            var refundDate:String=value!.objectForKey("refundDate") as! String
//            var customerID:String=value!.objectForKey("customerID") as! String
//             
//            var customerPhone:String=value!.objectForKey("customerPhone") as! String
//            var facilitatorID:String=value!.objectForKey("facilitatorID") as! String
//            var batchNo:String=value!.objectForKey("batchNo") as! String
//                         
//            let obj:RefundInfo=RefundInfo(id:id,orderNo:orderNo,alipayOrderID:alipayOrderID,reason:reason,money:money,status:status,applyTime:applyTime,confirmTime:confirmTime,refundDate:refundDate,customerID:customerID,customerPhone:customerPhone,facilitatorID:facilitatorID,batchNo:batchNo)
//                
//             
//            FinishiData = obj
//         
////        }
//    }
//    return FinishiData
//    
//}

//
////查询退款订单的详情
//
//func RefundOrderDetail(orderNo:String) ->RefundInfo  {
//    
//    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileRefundAction?operation=_query")
//    
//    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
//    
//    request.HTTPMethod = "POST"
//    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
//    var param:String = "{\"orderNo\":\"\(orderNo)\"}"
//    println("param:\(param)")
//    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
//    println("data:\(data)")
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
//    
//    var FinishiData:RefundInfo!
//    var test1: AnyObject?=json.objectForKey("serverResponse")
//    var  response1 :String = test1 as! String
//    if  response1 == "Success"{
//        var value: AnyObject?=json.objectForKey("data")
//        //        let jsonArray = test2 as? NSArray
//        //        var count = jsonArray?.count
//        
//        //        for value in jsonArray!{
//        var id:Int=value!.objectForKey("id") as! Int
//        var orderNo:String=value!.objectForKey("orderNo") as! String
//        var alipayOrderID:String=value!.objectForKey("alipayOrderID") as! String
//        var reason:String=value!.objectForKey("reason") as! String
//        var money:Float=value!.objectForKey("money") as! Float
//        
//        
//        var status:String=value!.objectForKey("status") as! String
//        var applyTime:String=value!.objectForKey("applyTime") as! String
//        var confirmTime:String=value!.objectForKey("confirmTime") as! String
//        var refundDate:String=value!.objectForKey("refundDate") as! String
//        var customerID:String=value!.objectForKey("customerID") as! String
//        
//        var customerPhone:String=value!.objectForKey("customerPhone") as! String
//        var facilitatorID:String=value!.objectForKey("facilitatorID") as! String
//        var batchNo:String=value!.objectForKey("batchNo") as! String
//        
//        let obj:RefundInfo=RefundInfo(id:id,orderNo:orderNo,alipayOrderID:alipayOrderID,reason:reason,money:money,status:status,applyTime:applyTime,confirmTime:confirmTime,refundDate:refundDate,customerID:customerID,customerPhone:customerPhone,facilitatorID:facilitatorID,batchNo:batchNo)
//        
//        
//        FinishiData = obj
//        
//        //        }
//    }
//    return FinishiData
//    
//}
//
////更新退款信息
//func UpdateRefund(orderNo:String,reason:String,money:String) ->String  {
//    
//    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileRefundAction?operation=_update")
//    
//    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
//    
//    request.HTTPMethod = "POST"
//    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
//    var param:String = "{\"orderNo\":\"\(orderNo)\",\"reason\":\"\(reason)\",\"money\":\"\(money)\"}"
//    println("param\(param)")
//    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
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
//    
//    
//    var test1: AnyObject?=json.objectForKey("serverResponse")
//    var  response1 :String = test1 as! String
//    println("response1:\(response1)")
//    return response1
//    
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
