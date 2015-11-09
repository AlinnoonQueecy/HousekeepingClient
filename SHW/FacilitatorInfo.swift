 //
//  FacilitatorInfo.swift
//  SHW
//
//  Created by Zhang on 15/7/17.
//  Copyright (c) 2015年 star. All rights reserved.
//

import Foundation

import UIKit
// 
//var selectInfo:String?
class facilitatorInfo:NSObject {
    var id :Int
    var facilitatorName:String
    //var companyName :String
    var facilitatorID:String
    var officePhone:String
    
    var qqNumber:String
    var contactPhone:String
    var facilitatorProvince:String
    var facilitatorCity:String
    var facilitatorCounty:String
    
    var emailAddress:String
    var contactAddress:String
    var registerTime: String
    var facilitatorLevel:Int
    var creditScore:String
//    var scoreImg:Int
//    var levelImg:Int
    
    var facilitatorIntro: String
    var facilitatorLogo:String
    var facilitatorStatus:String
    var serviceCount: Int

    init( id:Int,facilitatorName:String,facilitatorID:String,officePhone:String,qqNumber:String,contactPhone:String,facilitatorProvince:String,facilitatorCity:String,facilitatorCounty:String,emailAddress:String,contactAddress:String,registerTime: String,facilitatorLevel:Int,creditScore:String ,
        facilitatorIntro: String,facilitatorLogo:String,facilitatorStatus:String,serviceCount: Int){
            self.id = id
            self.facilitatorName = facilitatorName
            //self.companyName = companyName
            self.facilitatorID = facilitatorID
            self.officePhone = officePhone
            
            self.qqNumber = qqNumber
            self.contactPhone = contactPhone
            self.facilitatorProvince = facilitatorProvince
            self.facilitatorCity = facilitatorCity
            self.facilitatorCounty = facilitatorCounty
            
            self.emailAddress = emailAddress
            self.contactAddress = contactAddress
            self.registerTime = registerTime
            self.facilitatorLevel = facilitatorLevel
            self.creditScore = creditScore
            
            self.facilitatorIntro = facilitatorIntro
            self.facilitatorLogo = facilitatorLogo
            self.facilitatorStatus = facilitatorStatus
            self.serviceCount = serviceCount
        
            super.init()
    }
    
}

//1.1. 查询提供某一服务的所有商家
func refreshFacilitator(secondType:String,attributeName:String,upDown:String,facilitatorCounty:String) ->NSArray  {
    let url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorInfoAction?operation=_byServiceType")
    
    print("更新商家信息")
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    let param:String = "{\"type\":\"\(secondType)\",\"attributeName\":\"\(attributeName)\",\"upDown\":\"\(upDown)\",\"facilitatorCounty\":\"\(facilitatorCounty)\"}"
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
    let serverResponse:String = test1 as! String 
    
    var FacilitatorData:[facilitatorInfo] = []
    if  serverResponse == "Success" {
    let test2: AnyObject?=json.objectForKey("data")
    print(test2)
    let jsonArray = test2 as? NSArray
    var count = jsonArray?.count
   
    for value in jsonArray!{
        let id:Int=value.objectForKey("id") as! Int
        let facilitatorName:String=value.objectForKey("facilitatorName") as! String
        //var companyName:String=value.objectForKey("companyName") as! String
        let facilitatorID:String=value.objectForKey("facilitatorID") as! String
        let officePhone:String=value.objectForKey("officePhone") as! String
        
        
        
        let qqNumber:String=value.objectForKey("qqNumber") as! String
        let contactPhone:String=value.objectForKey("contactPhone") as! String
        let facilitatorProvince:String=value.objectForKey("facilitatorProvince") as! String
        let facilitatorCity:String=value.objectForKey("facilitatorCity") as! String
        let facilitatorCounty:String=value.objectForKey("facilitatorCounty") as! String
        
        
        let emailAddress:String=value.objectForKey("emailAddress") as! String
        let contactAddress:String=value.objectForKey("contactAddress") as! String
        let registerTime:String=value.objectForKey("registerTime") as! String
        let facilitatorLevel:Int=value.objectForKey("facilitatorLevel") as! Int
        let creditScore:String = value.objectForKey("creditScore") as! String
        
        
        
        let facilitatorIntro:String=value.objectForKey("facilitatorIntro") as! String
        let facilitatorLogo:String=value.objectForKey("facilitatorLogo") as! String
        let facilitatorStatus:String=value.objectForKey("facilitatorStatus") as! String
        
        let serviceCount:Int=value.objectForKey("serviceCount") as! Int
        var serviceType:String = value.objectForKey("serviceTypeArray") as! String
        let obj:facilitatorInfo = facilitatorInfo(id:id,facilitatorName:facilitatorName,facilitatorID:facilitatorID,officePhone:officePhone,qqNumber:qqNumber,contactPhone:contactPhone,facilitatorProvince:facilitatorProvince,facilitatorCity:facilitatorCity,facilitatorCounty:facilitatorCounty,emailAddress:emailAddress,contactAddress:contactAddress,registerTime: registerTime,facilitatorLevel:facilitatorLevel,creditScore:creditScore,
            facilitatorIntro: facilitatorIntro,facilitatorLogo:facilitatorLogo,facilitatorStatus:facilitatorStatus,serviceCount: serviceCount)
        //println(obj.facilitatorID+" "+obj.facilitatorName);
        //        var FinishiData:[Finishinfo] = []
        FacilitatorData += [obj]
        // obj.confirmTime = a;
        //        var b: AnyObject?=value.objectForKey("customerEvaluate")
        //        finishinfo.customerEvaluate = b
        //        var c: AnyObject?=value.objectForKey("customerName")
        //        finishinfo.customerName = c
        
       }
    }
    return FacilitatorData
    
}
//商家详情
 func refreshFDetail (facilitatorID:String)->facilitatorInfo{
    let url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorInfoAction?operation=_detailQuery")
    print("查询指定facilitatorID商家")
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    let param:String = "{\"facilitatorID\":\"\(facilitatorID)\"}"
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
 
    var detailData:facilitatorInfo?
    let test1: AnyObject?=json.objectForKey("serverResponse")
    
    let serverResponse:String = test1 as! String
    
 
    if  serverResponse == "Success" {
    let basic: AnyObject?=json.objectForKey("basic")
    let id:Int=basic!.objectForKey("id") as! Int
    let facilitatorName1:String=basic!.objectForKey("facilitatorName") as! String
    //var companyName1:String=basic!.objectForKey("companyName") as! String
    let facilitatorID1:String=basic!.objectForKey("facilitatorID") as! String
    let officePhone1:String=basic!.objectForKey("officePhone") as! String
    
    
    
    let qqNumber1:String=basic!.objectForKey("qqNumber") as! String
    let contactPhone1:String=basic!.objectForKey("contactPhone") as! String
    let facilitatorProvince1:String=basic!.objectForKey("facilitatorProvince") as! String
    let facilitatorCity1:String=basic!.objectForKey("facilitatorCity") as! String
    let facilitatorCounty1:String=basic!.objectForKey("facilitatorCounty") as! String
    
    
    let emailAddress1:String=basic!.objectForKey("emailAddress") as! String
    let contactAddress1:String=basic!.objectForKey("contactAddress") as! String
    let registerTime1:String=basic!.objectForKey("registerTime") as! String
    let facilitatorLevel1:Int=basic!.objectForKey("facilitatorLevel") as! Int
    let creditScore1:String = basic!.objectForKey("creditScore") as! String
    
    
    
    let facilitatorIntro1:String=basic!.objectForKey("facilitatorIntro") as! String
    let facilitatorLogo1:String=basic!.objectForKey("facilitatorLogo") as! String
    let facilitatorStatus1:String=basic!.objectForKey("facilitatorStatus") as! String
    
    let serviceCount1:Int=basic!.objectForKey("serviceCount") as! Int
    
    let obj:facilitatorInfo = facilitatorInfo(id:id,facilitatorName:facilitatorName1,facilitatorID:facilitatorID1,officePhone:officePhone1,qqNumber:qqNumber1,contactPhone:contactPhone1,facilitatorProvince:facilitatorProvince1,facilitatorCity:facilitatorCity1,facilitatorCounty:facilitatorCounty1,emailAddress:emailAddress1,contactAddress:contactAddress1,registerTime: registerTime1,facilitatorLevel:facilitatorLevel1,creditScore:creditScore1,
        facilitatorIntro: facilitatorIntro1,facilitatorLogo:facilitatorLogo1,facilitatorStatus:facilitatorStatus1,serviceCount: serviceCount1)
    
      detailData = obj
    }
    
    return detailData!
    
}
 //是否被收藏
 func GetCollect (facilitatorID:String,customerID:String)->String{
    let url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorInfoAction?operation=_detailQuery")
    print("是否被收藏")
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    let param:String = "{\"facilitatorID\":\"\(facilitatorID)\",\"customerID\":\"\(customerID)\"}"
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
    let collect: AnyObject?=json.objectForKey("isCollected")
//    println(collect)
    let isCollected :String = collect as! String
    
    return isCollected
  }
 
 
 
 
//添加收藏时的函数
func addCollection(n:String) ->String  {
    //要改URL
    
    let url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorCollectionAction?operation=_add")
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //要改参数类型
    let param:String = "{\"typeName\":\"\(n)\"}"
    //println("typeName\(select)")
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
 //取消收藏时的函数
 /*func deleteCollection(select:String) ->String  {
    //要改URL
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorCollectionAction?operation=_add")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //要改参数类型
    //var param:String = "{\"customerID\":\"\(customerid)\",\"facilitatorID\":\"\(detailItem.facilitatorID)\",\"facilitatorName\":\"\(detailItem.facilitatorName)\"}"
    
    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
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

    
    
    var serviceresponse: AnyObject?=json.objectForKey("serverResponse")
    var Response :String = serviceresponse as! String
    
    
    return Response
 }*/
 
// 
// class CountyInfo:NSObject {
//    var id :Int
//    var cityCode:String
//    var cityName:String
//    var countyName:String
//    var isCovered:String
//        init( id:Int,cityCode:String,cityName:String,countyName:String,isCovered:String){
//            self.id = id
//            self.cityCode = cityCode
//            self.cityName = cityName
//            self.countyName = countyName
//            self.isCovered = isCovered
//            super.init()
//    }
//    
// }

 func queryCounty(cityName:String) ->NSArray  {
    //要改URL
    
    let url: NSURL! = NSURL(string: HttpData.http+"/NationalService/MobileCountyInfoAction?operation=_querycoveredCounty")
    print(url)
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //要改参数类型
    let param:String = "{\"cityName\":\"\(cityName)\"}"
    print("城市:\(cityName)")
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
    
    //var detailData:CountyInfo!
    let test1: AnyObject?=json.objectForKey("serverResponse")
    let serverResponse:String = test1 as! String
    
    var countyData:[String] = []
    if  serverResponse == "Success" {
    let test2: AnyObject?=json.objectForKey("data")
    print("test2:\(test2)")
    let jsonArray = test2 as? NSArray
    let count = jsonArray?.count
     print("jsonArray:\(jsonArray)")
     print("count:\(count)")
        
        
    for value in jsonArray!{
        
 
       let countyName:String=value.objectForKey("countyName") as! String
 
          
   
            countyData += [countyName]
            
        }
    }
    return countyData
        
 }
 
 
 
 //实时更新客户位置（A）
 func RefreshLocation (customerID:String,realLongitude:String,realLatitude:String)->String{
    let url: NSURL! = NSURL(string:HttpData.http+"/NationalService/MobileCustomerInfoAction?operation=_updateLocation")
    
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    
    let param:String = "{\"customerID\":\"\(customerID)\",\"realLongitude\":\"\(realLongitude)\",\"realLatitude\":\"\(realLatitude)\"}"
    
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
 
