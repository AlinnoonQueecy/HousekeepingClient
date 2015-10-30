//: Playground - noun: a place where people can play

import Foundation
import UIKit


//var selectInfo:String?
class facilitatorInfo:NSObject {
    var id :Int
    var facilitatorName:String
    var companyName :String
    var facilitatorID:String
    var officePhone:String
    
    var qqNumber:String
    var contactPhone:String
    var province:String
    var city:String
    var county:String
    
    var emailAddress:String
    var contactAddress:String
    var registerTime: String
    var facilitatorLevel:Int
    var creditScore:Int
    //    var scoreImg:Int
    //    var levelImg:Int
    
    var facilitatorIntro: String
    var facilitatorLogo:String
    var facilitatorStatus:String
    var serviceCount: Int
    
    init( id:Int,facilitatorName:String,companyName :String,facilitatorID:String,officePhone:String,qqNumber:String,contactPhone:String,province:String,city:String,county:String,emailAddress:String,contactAddress:String,registerTime: String,facilitatorLevel:Int,creditScore:Int,
        facilitatorIntro: String,facilitatorLogo:String,facilitatorStatus:String,serviceCount: Int){
            self.id = id
            self.facilitatorName = facilitatorName
            self.companyName = companyName
            self.facilitatorID = facilitatorID
            self.officePhone = officePhone
            
            self.qqNumber = qqNumber
            self.contactPhone = contactPhone
            self.province = province
            self.city = city
            self.county = county
            
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



//创建NSURL
//var url: NSURL! = NSURL(string:  "http://59.46.2.105:8080/FamilyServiceSystem/MobileHomePictureAction?operation=_query")
var url: NSURL! = NSURL(string:"http://59.46.2.105:8080/FamilyServiceSystem/MobileServiceTypeAction?operation=_queryByName")

var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)

request.HTTPMethod = "POST"

var param:String = "{\"typeName\":\"家政\"}"
println("typeName\(select)")
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
    println("jsonString\(jsonString)")
    
}

let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)

var test1: AnyObject?=json.objectForKey("serverResponse")
//var ServiceTypeData:ServiceType?
//var serverResponse:String = test1 as! String
