//
//  Util.h
//  BookKeeping
//
//  Created by wihing on 12-6-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit+x.h"

@interface Util : NSObject

+ (NSString *)formatDoubleToString:(double)number;
+ (CGFloat)degreesToRadians:(CGFloat)degrees;

+ (void)playClickSound;
+ (void)playSlashSound;
+ (void)playPushSound;
+ (void)playPopSound;

+ (NSString *)sizeStringOfSizeInBytes:(int64_t)sizeInBytes;
+ (UInt64)freeDiskSpaceSize;

+ (CGFloat)screenHeight;

+ (NSString *)bundleVersion;

+ (NSString *)GUIDString;

+ (BOOL)iPhone;

@end
