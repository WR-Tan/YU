//
//  GeneralUtil.h
//  iThunder
//
//  Created by wihing on 12-9-24.
//  Copyright (c) 2012年 czh0766. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define L(string) [[NSBundle mainBundle] localizedStringForKey:(string) value:@"" table:nil]


@interface GeneralUtil : NSObject

+ (NSString *)sizeStringOfSizeInBytes:(int64_t)sizeInBytes;

+ (UInt64)freeDiskSpaceSize;

+ (void)playSound:(NSString*)soundName;

+ (CGFloat)screenHeight;

+ (NSString *)bundleVersion;

@end
