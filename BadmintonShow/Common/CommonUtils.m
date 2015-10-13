//
//  CommonUtils.m
//  OnlineDiagnose
//
//  Created by AllenMa on 3/15/15.
//  Copyright (c) 2015 AllenMa. All rights reserved.
//

#import "CommonUtils.h"

@implementation CommonUtils
#pragma mark -System Version

+ (NSString *)getSystemVersion
{
    return [NSString stringWithFormat:@"iOS/%@", [self systemVersionString]];
}

+ (BOOL)iOS5
{
    static BOOL iOS5 = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iOS5 = [self systemVersion] >= 5 && [self systemVersion] < 6;
    });
    return iOS5;
}

+ (BOOL)iOS6
{
    static BOOL iOS6 = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iOS6 = [self systemVersion] >= 6 && [self systemVersion] < 7;
    });
    return iOS6;
}

+ (BOOL)iOS7
{
    static BOOL iOS7 = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iOS7 = [self systemVersion] - 7 > -DBL_EPSILON && [self systemVersion] < 8;
    });
    return iOS7;
}

+ (BOOL)iOS8
{
    static BOOL iOS8 = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iOS8 = [self systemVersion] - 8 > -DBL_EPSILON;
    });
    return iOS8;
}

+ (BOOL)IOSVersionWithFromVersion:(int)fromVersion toVersion:(int)toVersion //[fromVersion,toVersion)
{
    CGFloat version = [self systemVersion];
    BOOL flag = (version-fromVersion > - 0.01 && version - toVersion < - 0.01);
    return  flag;
}

+ (CGFloat)systemVersion
{
    static CGFloat systemVersion = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = [[UIDevice currentDevice] systemVersion].floatValue;
    });
    return systemVersion;
}

+ (NSString *)systemVersionString
{
    static NSString *systemVersionString;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersionString = [[UIDevice currentDevice] systemVersion];
    });
    return systemVersionString;
}

+ (BOOL)retinaDisplay
{
    static BOOL retinaDisplay = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        retinaDisplay = abs([UIScreen mainScreen].scale - 2) < DBL_EPSILON;
    });
    return retinaDisplay;
}
@end
