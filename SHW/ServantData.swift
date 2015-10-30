//
//  ServantInfo.swift
//  SHW
//
//  Created by Zhang on 15/7/19.
//  Copyright (c) 2015年 star. All rights reserved.
//

import Foundation
import UIKit
class ServantInfo:NSObject {
    
    var id :Int
    var servantID:String
    var idCardNo:String
    var servantName:String
    var phoneNo :String
    
    
    var servantMobil:String
    var servantNationality:String
    var isMarried:Bool
    var educationLevel:String
    var trainingIntro:String
    
    
    var registerDate:String
    var servantProvince:String
    var servantCity:String
    var servantCounty:String
    var contactAddress:String
    
    
    var serviceArea:String
     var qqNumber:String
    var servantBirthday:String
    var servantGender:String
    var headPicture:String
    
    var workYears:Float
    var servantHonors:String
    var servantIntro:String
    var isStayHome:Bool
    var holidayInMonth:Int
    
    
    var servantScore: String
    var servantStatus:String
    var clientClick:Int
    var servantCategory: String
    var serviceItems:String
    
    
    var serviceCount: Int
    var careerType:String
    var servantState:String
    var registerLongitude:Double
    var registerLatitude:Double
    
    var realLongitude:Double
    var realLatitude:Double
    var emailAddress:String
    var servantAge:Int

//    var  serviceType :String
    
    init( id :Int,servantID:String,idCardNo:String,servantName:String,phoneNo :String,servantMobil:String,servantNationality:String
       ,isMarried:Bool,educationLevel:String,trainingIntro:String,registerDate:String,servantProvince:String,servantCity:String,servantCounty:String,contactAddress:String, serviceArea:String,qqNumber:String,servantBirthday:String,servantGender:String,headPicture:String
        ,workYears:Float,servantHonors:String,servantIntro:String,isStayHome:Bool,holidayInMonth:Int,servantScore: String,servantStatus:String,clientClick:Int,servantCategory: String,serviceItems:String,serviceCount: Int,careerType:String,servantState:String,registerLongitude:Double,registerLatitude:Double,realLongitude:Double,realLatitude:Double,emailAddress:String,servantAge:Int
        
        ){
            self.id = id
            self.servantID = servantID
            self.idCardNo = idCardNo
            self.servantName = servantName
            self.phoneNo = phoneNo
            
            self.servantMobil = servantMobil
            self.servantNationality = servantNationality
            self.isMarried = isMarried
            self.educationLevel = educationLevel
            self.trainingIntro = trainingIntro
            
            self.registerDate = registerDate
            self.servantProvince = servantProvince
            self.servantCity = servantCity
            self.servantCounty = servantCounty
            self.contactAddress = contactAddress
            
            
            self.serviceArea = serviceArea
            self.qqNumber = qqNumber
            self.servantBirthday = servantBirthday
            self.servantGender = servantGender
            self.headPicture = headPicture
            
            
            self.workYears = workYears
            self.servantHonors = servantHonors
            self.servantIntro = servantIntro
            self.isStayHome = isStayHome
            self.holidayInMonth = holidayInMonth
            
            
            self.servantScore = servantScore
            self.servantStatus = servantStatus
            self.clientClick = clientClick
            self.servantCategory = servantCategory
            self.serviceItems = serviceItems
            
            self.serviceCount = serviceCount
            self.careerType = careerType
            self.servantState = servantState
            self.registerLongitude = registerLongitude
            self.registerLatitude = registerLatitude
            
            self.realLongitude = realLongitude
            self.realLatitude = realLatitude
            self.emailAddress = emailAddress
            self.servantAge = servantAge
            
            super.init()
    }
    
}
//1.2. 查询提供某一服务的所有人员(A)
func refreshServant(serviceType:String,attributeName:String,upDown:String,serviceArea:String) ->NSArray  {
    
    let url: NSURL! = NSURL(string: HttpData.http+"/NationalService/MobileServantInfoAction?operation=_queryServants")
    
    print("更新人员信息")
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    let param:String = "{\"serviceItem\":\"\(serviceType)\",\"attributeName\":\"\(attributeName)\",\"upDown\":\"\(upDown)\",\"serviceArea\":\"\(serviceArea)\"}"
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

    let test1: AnyObject?=json.objectForKey("serverResponse")
    let serverResponse:String = test1 as! String
    var ServantData:[ServantInfo] = []
    if serverResponse == "Success" {
        let test2: AnyObject?=json.objectForKey("data")
        let jsonArray = test2 as? NSArray
        _ = jsonArray?.count
        
        for value in jsonArray!{
            let id:Int=value.objectForKey("id") as! Int
            let servantID:String=value.objectForKey("servantID") as! String
            let idCardNo:String=value.objectForKey("idCardNo") as! String

            let servantName:String=value.objectForKey("servantName") as! String
            let phoneNo:String=value.objectForKey("phoneNo") as! String
            
            
            
            let servantMobil:String=value.objectForKey("servantMobil") as! String
            let servantNationality:String=value.objectForKey("servantNationality") as! String
            let isMarried:Bool=value.objectForKey("isMarried") as! Bool

            let educationLevel:String=value.objectForKey("educationLevel") as! String
            let trainingIntro:String=value.objectForKey("trainingIntro") as! String
            
            
            
            let registerDate:String=value.objectForKey("registerDate") as! String
            let servantProvince:String=value.objectForKey("servantProvince") as! String
            let servantCity:String=value.objectForKey("servantCity") as! String
            let servantCounty:String=value.objectForKey("servantCounty") as! String
            let contactAddress:String=value.objectForKey("contactAddress") as! String
            
            
            
            let serviceArea:String=value.objectForKey("serviceArea") as! String
            let qqNumber:String=value.objectForKey("qqNumber") as! String
            let servantBirthday:String=value.objectForKey("servantBirthday") as! String
              let servantGender:String=value.objectForKey("servantGender") as! String
            let headPicture:String=value.objectForKey("headPicture") as! String
            
            
            
            let workYears:Float=value.objectForKey("workYears") as! Float
            let servantHonors:String=value.objectForKey("servantHonors") as! String
            let servantIntro:String = value.objectForKey("servantIntro") as! String
            let isStayHome:Bool = value.objectForKey("isStayHome") as! Bool
            let holidayInMonth:Int=value.objectForKey("holidayInMonth") as! Int
            
            
            let servantScore:String=value.objectForKey("servantScore") as! String
            let servantStatus:String=value.objectForKey("servantStatus") as! String
             let clientClick:Int = value.objectForKey("clientClick") as! Int
            let servantCategory:String = value.objectForKey("servantCategory") as! String
            let serviceItems:String = value.objectForKey("serviceItems") as! String
            
            
            let serviceCount:Int = value.objectForKey("serviceCount") as! Int
            let careerType:String = value.objectForKey("careerType") as! String
            let servantState:String = value.objectForKey("servantState") as! String
            let registerLongitude:Double = value.objectForKey("registerLongitude") as! Double
            let registerLatitude:Double = value.objectForKey("registerLatitude") as! Double
          
            
            let realLongitude:Double = value.objectForKey("realLongitude") as! Double
            let realLatitude:Double = value.objectForKey("realLatitude") as! Double
           
            let emailAddress:String = value.objectForKey("emailAddress") as! String
            let servantAge:Int = value.objectForKey("servantAge") as! Int
            
            
            let obj:ServantInfo = ServantInfo(id :id,servantID:servantID,idCardNo:idCardNo,servantName:servantName,phoneNo :phoneNo,servantMobil:servantMobil,servantNationality:servantNationality
                ,isMarried:isMarried,educationLevel:educationLevel,trainingIntro:trainingIntro,registerDate:registerDate,servantProvince:servantProvince,servantCity:servantCity,servantCounty:servantCounty,contactAddress:contactAddress, serviceArea:serviceArea,qqNumber:qqNumber,servantBirthday:servantBirthday,servantGender:servantGender,headPicture:headPicture
                ,workYears:workYears,servantHonors:servantHonors,servantIntro:servantIntro,isStayHome:isStayHome,holidayInMonth:holidayInMonth,servantScore: servantScore,servantStatus:servantStatus,clientClick:clientClick,servantCategory: servantCategory,serviceItems:serviceItems,serviceCount: serviceCount,careerType:careerType,servantState:servantState,registerLongitude:registerLongitude,registerLatitude:registerLatitude,realLongitude:realLongitude,realLatitude:realLatitude,emailAddress:emailAddress,servantAge:servantAge)
            
            ServantData += [obj]
            
        }
    }
    return ServantData
    
}

 


//查询某人员是否被收藏（A）
func GetServantCollect (servantID:String,customerID:String)->String{
    let url: NSURL! = NSURL(string: HttpData.http+"/NationalService/MobileServantCollectionAction?operation=_collectionQuery")
  
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    let param:String = "{\"servantID\":\"\(servantID)\",\"customerID\":\"\(customerID)\"}"
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
    print("json:\(json)")
    
     var isCollected :String = ""
     let test1: AnyObject?=json.objectForKey("serverResponse")
     let  serviceresponse:String = test1  as! String
    
     if  serviceresponse == "Success"{
        
   let collect: AnyObject?=json.objectForKey("isCollected")
        isCollected = collect as! String
        
       print("isCollected\(isCollected)")
    }
    
    
    return isCollected
}
//取消人员收藏时的函数（A）
func deleteSCollection(customerID:String,servantID:String) ->String  {
//要改URL
    let url: NSURL! = NSURL(string: HttpData.http+"/NationalService/MobileServantCollectionAction?operation=_delete")

let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)

request.HTTPMethod = "POST"
//要改参数类型
let param:String = "{\"customerID\":\"\(customerID)\",\"servantID\":\"\(servantID)\"}"

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
//添加人员收藏时的函数(A)
func addSCollection(customerid:String,servantid:String,servantname:String) ->String  {
    //要改URL
    
    let url: NSURL! = NSURL(string:HttpData.http+"/NationalService/MobileServantCollectionAction?operation=_add")
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //要改参数类型
    print("servantname\(servantname)")
   let param:String = "{\"customerID\":\"\(customerid)\",\"servantID\":\"\(servantid)\",\"servantName\":\"\(servantname)\"}"
     print(param)
    print("typeName\(servantname)")
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






//class CommentInfo:NSObject {
//    
//    var id :Int
//    var servantID:String
//    var servantName:String
//    var customerID :String
//    var customerName:String
//    var commentContent:String
//    var commentDate:String
//    
//    init(id:Int,servantID:String,servantName:String,customerID:String,customerName:String,commentContent:String,commentDate:String ){
//            self.id = id
//            self.servantID = servantID
//            self.servantName = servantName
//            self.customerID = customerID
//            self.customerName = customerName
//            self.commentContent = commentContent
//            self.commentDate = commentDate
//        
//            super.init()
//    }
//    
//}
class CommentInfo:NSObject {
    
    var id :Int
    var servantID:String
    var servantName:String
    var customerID :String
    var customerName:String
    var commentContent:String
    var commentDate:String
    
    init(id:Int,servantID:String,servantName:String,customerID:String,customerName:String,commentContent:String,commentDate:String ){
        self.id = id
        self.servantID = servantID
        self.servantName = servantName
        self.customerID = customerID
        self.customerName = customerName
        self.commentContent = commentContent
        self.commentDate = commentDate
        
        super.init()
    }
    
}
//查询客户对人员的评价(A)
func getSconmmentData(servantID:String) ->NSArray  {
    let url: NSURL! = NSURL(string: HttpData.http+"/NationalService/MobileServantInfoAction?operation=_queryComment")
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
 
    let param:String = "{\"servantID\":\"\(servantID)\"}"
    print("评价param\(param)")
    
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
    var CommentData:[CommentInfo] = []
    let test1: AnyObject?=json.objectForKey("serverResponse")
    let response1 :String = test1 as! String
    if response1 == "Success" {
    let test2: AnyObject?=json.objectForKey("data")
    let jsonArray = test2 as? NSArray
  //  var count = jsonArray?.count
    
    for value in jsonArray!{
        let id:Int=value.objectForKey("id") as! Int
        let servantID:String=value.objectForKey("servantID") as! String
        let servantName:String=value.objectForKey("servantName") as! String
        let customerID:String=value.objectForKey("customerID") as! String
         let customerName:String=value.objectForKey("customerName") as! String
        let commentContent:String=value.objectForKey("commentContent") as! String
        let commentDate:String=value.objectForKey("commentDate") as! String
        
        let obj:CommentInfo = CommentInfo(id:id,servantID:servantID,servantName:servantName,customerID:customerID,customerName:customerName,commentContent:commentContent,commentDate:commentDate)
        
        CommentData += [obj]
        
        }
    }
    return CommentData
    
}
//判断是不是有评论
func getResponse(servantID:String) ->String  {
    let url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileServiceOrderAction?operation=_queryServantComment")
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    
    let param:String = "{\"servantID\":\"\(servantID)\"}"
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
 
        
        
 return  serverResponse
}



