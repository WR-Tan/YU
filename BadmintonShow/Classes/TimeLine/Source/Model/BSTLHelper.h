//
//  BSTLHelper.h
//  BadmintonShow
//
//  Created by lizhihua on 12/26/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYKit.h" 

@interface BSTLHelper : NSObject

/// Image resource bundle
+ (NSBundle *)bundle;

/// Image cache
+ (YYMemoryCache *)imageCache;

/// Get image from bundle with cache.
+ (UIImage *)imageNamed:(NSString *)name;

/// Convert date to friendly description.
+ (NSString *)stringWithTimelineDate:(NSDate *)date;

/// Convert number to friendly description.
+ (NSString *)shortedNumberDesc:(NSUInteger)number;

@end

