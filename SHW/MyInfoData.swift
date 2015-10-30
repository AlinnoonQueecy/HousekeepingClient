//
//  MyInfoData.swift
//  SHW
//
//  Created by Zhang on 15/7/29.
//  Copyright (c) 2015年 star. All rights reserved.
//
import Foundation

import UIKit

class MyInfo:NSObject {
    
    var id :Int
    var customerID:String
    var customerName:String
    var loginPassword:String
    var qqNumber:String
    
    var phoneNo :String
    var mobilePhone:String
    var emailAddress:String
    var contactAddress:String
    var customerProvince:String
    
    
    var customerCity:String
    var customerCounty:String
    var customerBirthday:String
    var registerDate:String
    var idCardNo:String
    
    var customerGender:String
    var headPicture:String
    var registerLongitude:Double
    var registerLatitude:Double
    var realLongitude:Double
    
    var realLatitude:Double
    
    init( id :Int,customerID:String,idCardNo:String,customerName:String,phoneNo :String,mobilePhone:String,loginPassword:String
        ,registerDate:String,customerProvince:String,customerCity:String,customerCounty:String,customerBirthday:String,contactAddress:String,qqNumber:String, customerGender:String,headPicture:String
        ,registerLongitude:Double,registerLatitude:Double,realLongitude:Double,realLatitude:Double,emailAddress:String
        
        ){
            self.id = id
            self.customerID = customerID
            self.idCardNo = idCardNo
            self.customerName = customerName
            self.phoneNo = phoneNo
            
            self.mobilePhone = mobilePhone
            self.loginPassword = loginPassword
            self.registerDate = registerDate
            self.customerProvince = customerProvince
            self.customerCity = customerCity
            
            self.customerCounty = customerCounty
            self.customerBirthday = customerBirthday
            self.contactAddress = contactAddress
            self.qqNumber = qqNumber
            self.customerGender = customerGender
            
            self.headPicture = headPicture
            self.registerLongitude = registerLongitude
            self.registerLatitude = registerLatitude
            self.realLongitude = realLongitude
            self.realLatitude = realLatitude
            
            
            self.emailAddress = emailAddress
           
            
            super.init()
    }
    
}
//得到个人信息（A）
func QueryInfo(customerid:String) ->MyInfo  {
    let url: NSURL! = NSURL(string: HttpData.http+"/NationalService/MobileCustomerInfoAction?operation=_queryByID")
    
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    
    let param:String = "{\"customerID\":\"\(customerid)\"}"
    print("customerID:\(customerid)")
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
    var MyInfoData:MyInfo!
    let response1:String = test1 as! String
    print(response1)
    if  response1 == "Success" {
        print("行不行")
       let value: AnyObject?  =  json.objectForKey("data")
  

        print("行")
        let  id:Int =  value!.objectForKey("id") as! Int
        print(id)
         print("行")
        let customerID:String=value!.objectForKey("customerID") as! String
        print(customerID)
        let customerName:String=value!.objectForKey("customerName") as! String
        let customerGender:String=value!.objectForKey("customerGender") as! String
        let customerBirthday:String=value!.objectForKey("customerBirthday") as! String
        
        
        
        let idCardNo:String=value!.objectForKey("idCardNo") as! String
        
        let phoneNo:String=value!.objectForKey("phoneNo") as! String
        let mobilePhone:String=value!.objectForKey("mobilePhone") as! String
        let emailAddress:String=value!.objectForKey("emailAddress") as! String
        let customerProvince:String=value!.objectForKey("customerProvince") as! String
        
        let registerDate:String=value!.objectForKey("registerDate") as! String
        
        
        let customerCity:String=value!.objectForKey("customerCity") as! String
        let customerCounty:String=value!.objectForKey("customerCounty") as! String
        let contactAddress:String=value!.objectForKey("contactAddress") as! String
        let qqNumber:String = value!.objectForKey("qqNumber") as! String
        let loginPassword:String = value!.objectForKey("loginPassword") as! String
        
        
        
        let headPicture:String = value!.objectForKey("headPicture") as! String
        let registerLongitude:Double = value!.objectForKey("registerLongitude") as! Double
        let registerLatitude:Double = value!.objectForKey("registerLatitude") as! Double

        let realLongitude:Double = value!.objectForKey("realLongitude") as! Double
        let realLatitude:Double = value!.objectForKey("realLatitude") as! Double
        
        
          print("行不行")
        let obj:MyInfo = MyInfo(id :id,customerID:customerID,idCardNo:idCardNo,customerName:customerName,phoneNo :phoneNo,mobilePhone:mobilePhone,loginPassword:loginPassword
            ,registerDate:registerDate,customerProvince:customerProvince,customerCity:customerCity,customerCounty:customerCounty,customerBirthday:customerBirthday,contactAddress:contactAddress,qqNumber:qqNumber,customerGender:customerGender,headPicture:headPicture,registerLongitude:registerLongitude,registerLatitude:registerLatitude,realLongitude:realLongitude,realLatitude:realLatitude,emailAddress:emailAddress)
        
        MyInfoData = obj
        
    }
    return MyInfoData
    
    
}
