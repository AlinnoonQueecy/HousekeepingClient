//
//  CollectionData.swift
//  SHW
//
//  Created by Zhang on 15/7/18.
//  Copyright (c) 2015年 star. All rights reserved.
//

import Foundation

import UIKit
//
//var selectInfo:String?
//class CollectionInfo:NSObject {
//    var id :Int
//    var facilitatorName:String
//    //var companyName :String
//    var facilitatorID:String
//    var officePhone:String
//    
//    var qqNumber:String
//    var contactPhone:String
//    var facilitatorProvince:String
//    var facilitatorCity:String
//    var facilitatorCounty:String
//    
//    var emailAddress:String
//    var contactAddress:String
//    var registerTime: String
//    var facilitatorLevel:Int
//    var creditScore:String
//    //    var scoreImg:Int
//    //    var levelImg:Int
//    
//    var facilitatorIntro: String
//    var facilitatorLogo:String
//    var facilitatorStatus:String
//    var serviceCount: Int
//    
//    init( id:Int,facilitatorName:String,facilitatorID:String,officePhone:String,qqNumber:String,contactPhone:String,facilitatorProvince:String,facilitatorCity:String,facilitatorCounty:String,emailAddress:String,contactAddress:String,registerTime: String,facilitatorLevel:Int,creditScore:String ,
//        facilitatorIntro: String,facilitatorLogo:String,facilitatorStatus:String,serviceCount: Int){
//            self.id = id
//            self.facilitatorName = facilitatorName
//            //self.companyName = companyName
//            self.facilitatorID = facilitatorID
//            self.officePhone = officePhone
//            
//            self.qqNumber = qqNumber
//            self.contactPhone = contactPhone
//            self.facilitatorProvince = facilitatorProvince
//            self.facilitatorCity = facilitatorCity
//            self.facilitatorCounty = facilitatorCounty
//            
//            self.emailAddress = emailAddress
//            self.contactAddress = contactAddress
//            self.registerTime = registerTime
//            self.facilitatorLevel = facilitatorLevel
//            self.creditScore = creditScore
//            
//            self.facilitatorIntro = facilitatorIntro
//            self.facilitatorLogo = facilitatorLogo
//            self.facilitatorStatus = facilitatorStatus
//            self.serviceCount = serviceCount
//            
//            super.init()
//    }
//    
//}

//收藏的商家
//func refreshFCollection(customerID:String,serviceType:String,attributeName:String,upDown:String) ->[facilitatorInfo]  {
//    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorCollectionAction?operation=_query")
//    
//    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
//    
//    request.HTTPMethod = "POST"
//    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
//    var param:String = "{\"customerID\":\"\(customerID)\",\"serviceType\":\"\(serviceType)\",\"attributeName\":\"\(attributeName)\",\"upDown\":\"\(upDown)\"}"
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
//    //var finishinfo = finishinfo()
//    //var FinishData:[finishinfo] = []
//    var test1: AnyObject?=json.objectForKey("serverResponse")
//       var CollectionData:[facilitatorInfo] = []
//    var response1 :String = test1 as! String
//    if  response1 == "Success"{
//    var test2: AnyObject?=json.objectForKey("data")
//   
//    let jsonArray = test2 as? NSArray
//     var count = jsonArray?.count
// 
//    for value in jsonArray!{
//        var id:Int=value.objectForKey("id") as! Int
//        var facilitatorName:String=value.objectForKey("facilitatorName") as! String
//        var companyName:String=value.objectForKey("companyName") as! String
//        var facilitatorID:String=value.objectForKey("facilitatorID") as! String
//        var officePhone:String=value.objectForKey("officePhone") as! String
//        
//        
//        
//        var qqNumber:String=value.objectForKey("qqNumber") as! String
//        var contactPhone:String=value.objectForKey("contactPhone") as! String
//        var facilitatorProvince:String=value.objectForKey("facilitatorProvince") as! String
//        var facilitatorCity:String=value.objectForKey("facilitatorCity") as! String
//        var facilitatorCounty:String=value.objectForKey("facilitatorCounty") as! String
//        
//        
//        var emailAddress:String=value.objectForKey("emailAddress") as! String
//        var contactAddress:String=value.objectForKey("contactAddress") as! String
//        var registerTime:String=value.objectForKey("registerTime") as! String
//        var facilitatorLevel:Int=value.objectForKey("facilitatorLevel") as! Int
//        var creditScore:String = value.objectForKey("creditScore") as! String
//        
//        
//        
//        var facilitatorIntro:String=value.objectForKey("facilitatorIntro") as! String
//        var facilitatorLogo:String=value.objectForKey("facilitatorLogo") as! String
//        var facilitatorStatus:String=value.objectForKey("facilitatorStatus") as! String
//        
//        var serviceCount:Int=value.objectForKey("serviceCount") as! Int
//        
//        let obj:facilitatorInfo = facilitatorInfo(id:id,facilitatorName:facilitatorName,facilitatorID:facilitatorID,officePhone:officePhone,qqNumber:qqNumber,contactPhone:contactPhone,facilitatorProvince:facilitatorProvince,facilitatorCity:facilitatorCity,facilitatorCounty:facilitatorCounty,emailAddress:emailAddress,contactAddress:contactAddress,registerTime: registerTime,facilitatorLevel:facilitatorLevel,creditScore:creditScore,
//            facilitatorIntro: facilitatorIntro,facilitatorLogo:facilitatorLogo,facilitatorStatus:facilitatorStatus,serviceCount: serviceCount)
//
//        
//           CollectionData += [obj]
//       
//        }
//    }
// 
//    return CollectionData
//    
//}
//查询收藏的人员(A)
func refreshSCollection(customerID:String) ->[ServantInfo]  {
    let url: NSURL! = NSURL(string: HttpData.http+"/NationalService/MobileServantCollectionAction?operation=_query")
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
 
    let param:String = "{\"customerID\":\"\(customerID)\"}"
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
   
    var CollectionSData:[ServantInfo] = []
    let test1: AnyObject?=json.objectForKey("serverResponse")
    let response1 :String = test1 as! String
    if  response1 == "Success"{
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
            
            
        CollectionSData += [obj]
        
        }
        
    }

    return CollectionSData
    
}

//1.1. 查询指定facilitatorID商家
//func queryFacilitator(facilitatorID:String) ->facilitatorInfo  {
//    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorInfoAction?operation=_detailQuery")
//    println("查询指定facilitatorID商家")
//    
//    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
//    
//    request.HTTPMethod = "POST"
//    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
//    var param:String = "{\"facilitatorID\":\"\(facilitatorID)\"}"
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
//    var test1: AnyObject?=json.objectForKey("serverResponse")
//    var test2: AnyObject?=json.objectForKey("data")
//    let jsonArray = test2 as? NSArray
//  
//    var value: AnyObject? = test2
//    
//    var FacilitatorData:facilitatorInfo
// 
//        var id:Int=value!.objectForKey("id") as! Int
//        var facilitatorName:String=value!.objectForKey("facilitatorName") as! String
//        var companyName:String=value!.objectForKey("companyName") as! String
//        var facilitatorID:String=value!.objectForKey("facilitatorID") as! String
//        var officePhone:String=value!.objectForKey("officePhone") as! String
//        
//        
//        
//        var qqNumber:String=value!.objectForKey("qqNumber") as! String
//        var contactPhone:String=value!.objectForKey("contactPhone") as! String
//        var facilitatorProvince:String=value!.objectForKey("facilitatorProvince") as! String
//        var facilitatorCity:String=value!.objectForKey("facilitatorCity") as! String
//        var facilitatorCounty:String=value!.objectForKey("facilitatorCounty") as! String
//        
//        
//        var emailAddress:String=value!.objectForKey("emailAddress") as! String
//        var contactAddress:String=value!.objectForKey("contactAddress") as! String
//        var registerTime:String=value!.objectForKey("registerTime") as! String
//        var facilitatorLevel:Int=value!.objectForKey("facilitatorLevel") as! Int
//        var creditScore:String = value!.objectForKey("creditScore") as! String
//        
//        
//        
//        var facilitatorIntro:String=value!.objectForKey("facilitatorIntro") as! String
//        var facilitatorLogo:String=value!.objectForKey("facilitatorLogo") as! String
//        var facilitatorStatus:String=value!.objectForKey("facilitatorStatus") as! String
//        
//        var serviceCount:Int=value!.objectForKey("serviceCount") as! Int
//        
//        let obj:facilitatorInfo = facilitatorInfo(id:id,facilitatorName:facilitatorName,facilitatorID:facilitatorID,officePhone:officePhone,qqNumber:qqNumber,contactPhone:contactPhone,facilitatorProvince:facilitatorProvince,facilitatorCity:facilitatorCity,facilitatorCounty:facilitatorCounty,emailAddress:emailAddress,contactAddress:contactAddress,registerTime: registerTime,facilitatorLevel:facilitatorLevel,creditScore:creditScore,
//            facilitatorIntro: facilitatorIntro,facilitatorLogo:facilitatorLogo,facilitatorStatus:facilitatorStatus,serviceCount: serviceCount)
//    
//        FacilitatorData = obj
// 
//    return FacilitatorData
//    
//}
//
//
