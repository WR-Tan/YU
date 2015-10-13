//
//  CommonUtils.h
//  OnlineDiagnose
//
//  Created by AllenMa on 3/15/15.
//  Copyright (c) 2015 AllenMa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtils : NSObject
/*********************    系统版本   ****************************/
+ (NSString *)getSystemVersion;
+ (CGFloat)systemVersion;
+ (NSString *)systemVersionString;
+ (BOOL)iOS5;
+ (BOOL)iOS6;
+ (BOOL)iOS7;
+ (BOOL)iOS8;   // iOS8 以上
+ (BOOL)IOSVersionWithFromVersion:(int)fromVersion toVersion:(int)toVersion;

+ (BOOL)retinaDisplay;


@end
