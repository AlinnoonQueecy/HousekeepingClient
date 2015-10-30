//
//  ServiceItemData.swift
//  SHW
//
//  Created by Zhang on 15/7/20.
//  Copyright (c) 2015年 star. All rights reserved.
//

import Foundation
import UIKit

class serviceItemInfo:NSObject {
    var id :Int
    var itemName :String
    var facilitatorName:String
    var facilitatorID:String
    var serviceType:String
    
    var itemIntro:String
    var priceDescription:String
    var servicePicture:String
    var isPackage:Bool
    var itemType:String
 
    
    
    
    init( id:Int,itemName:String,facilitatorName :String,facilitatorID:String,serviceType:String,itemIntro:String,priceDescription:String,servicePicture:String,isPackage:Bool,itemType:String){
            self.id = id
            self.facilitatorName = facilitatorName
            self.itemName = itemName
            self.facilitatorID = facilitatorID
            self.serviceType = serviceType
            
            self.itemIntro = itemIntro
            self.priceDescription = priceDescription
            self.servicePicture = servicePicture
            self.isPackage = isPackage
            self.itemType = itemType
        
            
            super.init()
    }
    
}


func refreshCommonItem(facilitatorID:String) ->NSArray  {
    let url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorInfoAction?operation=_detailQuery")
    print("查询指定refreshCommonItem")
    
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
    //var finishinfo = finishinfo()
    //var FinishData:[finishinfo] = []
    //var test1: AnyObject?=json.objectForKey("serverResponse")
    let common: AnyObject?=json.objectForKey("commonItems")
    let jsonArray = common as? NSArray
   // var count = jsonArray?.count
    var CommonData:[serviceItemInfo] = []
    for value in jsonArray!{
        let id:Int=value.objectForKey("id") as! Int
        let itemName:String=value.objectForKey("itemName") as! String
        let facilitatorName:String=value.objectForKey("facilitatorName") as! String
        let facilitatorID:String=value.objectForKey("facilitatorID") as! String
        let serviceType:String=value.objectForKey("serviceType") as! String
        
        
        
        let itemIntro:String=value.objectForKey("itemIntro") as! String
        let priceDescription:String=value.objectForKey("priceDescription") as! String
        let servicePicture:String=value.objectForKey("servicePicture") as! String
        let isPackage:Bool=value.objectForKey("isPackage") as! Bool
        let itemType:String=value.objectForKey("itemType") as! String
        
//        println("这个id是\(id)")
        
        let obj:serviceItemInfo = serviceItemInfo(id:id,itemName:itemName,facilitatorName:facilitatorName,facilitatorID:facilitatorID,serviceType:serviceType,itemIntro:itemIntro,priceDescription:priceDescription,servicePicture:servicePicture,isPackage:isPackage,itemType:itemType )
       
        CommonData += [obj]
        
    }
    return CommonData
    
}


func refreshPackageItem(facilitatorID:String) ->NSArray  {
    let url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorInfoAction?operation=_detailQuery")
    print("查询指定refreshPackageItem")
    
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
    //var finishinfo = finishinfo()
    //var FinishData:[finishinfo] = []
    //var test1: AnyObject?=json.objectForKey("serverResponse")
    let common: AnyObject?=json.objectForKey("packageItems")
    let jsonArray = common as? NSArray
    //var count = jsonArray?.count
    var ServiceItemData:[serviceItemInfo] = []
    for value in jsonArray!{
        let id:Int=value.objectForKey("id") as! Int
        let itemName:String=value.objectForKey("itemName") as! String
        let facilitatorName:String=value.objectForKey("facilitatorName") as! String
        let facilitatorID:String=value.objectForKey("facilitatorID") as! String
        let serviceType:String=value.objectForKey("serviceType") as! String
        
        
        
        let itemIntro:String=value.objectForKey("itemIntro") as! String
        let priceDescription:String=value.objectForKey("priceDescription") as! String
        let servicePicture:String=value.objectForKey("servicePicture") as! String
        let isPackage:Bool=value.objectForKey("isPackage") as! Bool
        let itemType:String=value.objectForKey("itemType") as! String
        
        
        let obj:serviceItemInfo = serviceItemInfo(id:id,itemName:itemName,facilitatorName:facilitatorName,facilitatorID:facilitatorID,serviceType:serviceType,itemIntro:itemIntro,priceDescription:priceDescription,servicePicture:servicePicture,isPackage:isPackage,itemType:itemType
        )
        
        ServiceItemData += [obj]
        
    }
    return ServiceItemData
    
}




