//
//  NSDatex.h
//  MemoLite
//
//  Created by czh0766 on 11-10-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (x)

+(id) now;

+(id) sync;

+(id) dateWithYear:(int)year Month:(int)month Day:(int)day;

+(id) dateWithYear:(int)year Month:(int)month Day:(int)day Hour:(int)hour Minute:(int)minute;

+(id) dateWithTimestamp:(NSString*)timestamp;

+(id) dateWithTimestamp2:(NSString*)timestamp;

-(id) dateByAddingDays:(int)days;

-(id) yesterday; 

-(id) tomorrow;

-(int) year;

-(int) month;

-(int) day;

-(int) hour;

-(int) minute;

-(int) second;

-(int) weekday;

-(BOOL) isEqualToYMD:(NSDate *)date;

-(int) dayIntervalSinceDate:(NSDate *)date;

- (NSString *)toDateString;

- (NSString *)toTimeString;

- (NSDate *)firstDayOfNextMonth;
@end
