//
//  AlipayMethod.h
//  AliSDKDemo
//
//  Created by 张迪 on 15/8/16.
//  Copyright (c) 2015年 Alipay.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayInfo.h"
#import <UIKit/UIKit.h>
@interface AlipayMethod : NSObject

+(void)pay:(PayInfo *)product;

@end
