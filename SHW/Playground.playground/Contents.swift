//: Playground - noun: a place where people can play

import UIKit


var url: NSURL! = NSURL(string:"http://219.216.65.182:8080/NationalService/MobileFacilitatorAdvertiseAction?operation=_query")
    
var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)

request.HTTPMethod = "POST"

//var param:String  = "{\"orderNo\":\"2015090133552\",\"score\":\"5\",\"commentContent\":\"11111111\"}"
//var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
request.HTTPBody = data;
var response:NSURLResponse?
var error:NSError?
var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
if (error != nil)
{
    print(error?.code)
    print(error?.description)
}
else
{
    var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
    print(jsonString)
    
}

let json:AnyObject! = try? NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments)
//var finishinfo = finishinfo()
//var FinishData:[finishinfo] = []
var test1: AnyObject?=json.objectForKey("serverResponse")
var test2: AnyObject?=json.objectForKey("data")
//var test3:AnyObject? = json.objectForKey("types")
let jsonArray = test2 as? NSArray
var count = jsonArray?.count
for value in jsonArray!{
    var confirmTime:String=value.objectForKey("countyName") as! String
 
}



