//
//  NSDatex.m
//  MemoLite
//
//  Created by czh0766 on 11-10-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NSDate+x.h"
#import "NSDictionary+x.h"

static NSDate* now;
static NSMutableDictionary* monthTable;

@implementation NSDate (x)

+(void)initialize {
    monthTable = [[NSMutableDictionary alloc] initWithCapacity:12];
    [monthTable setInt:1 forKey:@"Jan"];
    [monthTable setInt:2 forKey:@"Feb"];
    [monthTable setInt:3 forKey:@"Mar"];
    [monthTable setInt:4 forKey:@"Apr"];
    [monthTable setInt:5 forKey:@"May"];
    [monthTable setInt:6 forKey:@"Jun"];
    [monthTable setInt:7 forKey:@"Jul"];
    [monthTable setInt:8 forKey:@"Aug"];
    [monthTable setInt:9 forKey:@"Sep"];
    [monthTable setInt:10 forKey:@"Oct"];
    [monthTable setInt:11 forKey:@"Nov"];
    [monthTable setInt:12 forKey:@"Dec"];
}

+(id) now {
    if (now == nil) {
        [NSDate sync];
    }
    return now;
}

+(id) sync {
    now = [NSDate date];
    return now;
}

+(id) dateWithYear:(int)year Month:(int)month Day:(int)day {
    return [NSDate dateWithYear:year Month:month Day:day Hour:0 Minute:0];
}

+(id) dateWithYear:(int)year Month:(int)month Day:(int)day Hour:(int)hour Minute:(int)minute {
    NSDateComponents* comp = [[NSDateComponents alloc] init];
    [comp setYear:year];
    [comp setMonth:month];
    [comp setDay:day];
    [comp setHour:hour];
    [comp setMinute:minute];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    return [calendar dateFromComponents:comp];
}

+(id) dateWithTimestamp:(NSString*)timestamp {
    NSTimeInterval interval = [timestamp longLongValue];
    return [NSDate dateWithTimeIntervalSince1970:interval];
}

//Tue Feb 14 00:06:16 +0800 2012
+(id) dateWithTimestamp2:(NSString*)timestamp {
    NSArray* array = [timestamp componentsSeparatedByString:@" "];
    int month = [monthTable intForKey:array[1]];
    int day = [array[2] intValue];
    int year = [array[(array.count - 1)] intValue];
    
    NSArray* array2 = [array[3] componentsSeparatedByString:@":"];
    int hour = [array2[0] intValue];
    int minute = [array2[1] intValue];
    //int second = [[array2 objectAtIndex:2] intValue];
    
    return [NSDate dateWithYear:year Month:month Day:day Hour:hour Minute:minute];
}

-(id) dateByAddingDays:(int)days {   
    NSTimeInterval interval = 86400 * days;
    return [self dateByAddingTimeInterval:interval];
}

-(id) yesterday {
    return [self dateByAddingDays:-1];
}

-(id) tomorrow {
    return [self dateByAddingDays:1];
}

-(int) year {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comp = [calendar components:NSYearCalendarUnit fromDate:self];
    return comp.year;
}

-(int) month {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comp = [calendar components:NSMonthCalendarUnit fromDate:self];
    return comp.month;
}

-(int) day {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comp = [calendar components:NSDayCalendarUnit fromDate:self];
    return comp.day;
}

-(int) hour {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comp = [calendar components:NSHourCalendarUnit fromDate:self];
    return comp.hour;
}

-(int) minute {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comp = [calendar components:NSMinuteCalendarUnit fromDate:self];
    return comp.minute;
}

-(int) second {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comp = [calendar components:NSSecondCalendarUnit fromDate:self];
    return comp.second;
}

-(int) weekday {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comp = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    return comp.weekday;
}

-(BOOL) isEqualToYMD:(NSDate *)date {
    return [self year] == [date year] && [self month] == [date month] && [self day] == [date day];
}

-(int) dayIntervalSinceDate:(NSDate *)date {
    NSTimeInterval interval = [self timeIntervalSinceDate:date];
    return interval / 86400;
}

- (NSString *)toDateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:self];
}

- (NSString *)toTimeString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm"];
    return [formatter stringFromDate:self];
}

- (void)zeroOutTimeComponents:(NSDateComponents **)components {
    [*components setHour:0];
    [*components setMinute:0];
    [*components setSecond:0];
}

- (NSDate *)firstDayOfCurrentMonth {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    // Start out by getting just the year, month and day components of the current date.
    NSDate *currentDate = self;
    NSDateComponents *components = [gregorianCalendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                                        fromDate:currentDate];
    
    // Change the Day component to 1 (for the first day of the month), and zero out the time components.
    [components setDay:1];
    [self zeroOutTimeComponents:&components];
    
    return [gregorianCalendar dateFromComponents:components];
}

-(NSDate *)firstDayOfNextMonth {
    NSDate *firstDayOfCurrentMonth = [self firstDayOfCurrentMonth];
    
    // Set up a "plus 1 month" component.
    NSDateComponents *plusOneMonthComponent = [[NSDateComponents alloc] init];
	[plusOneMonthComponent setMonth:1];
    
    // Add 1 month to firstDayOfCurrentMonth.
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [gregorianCalendar dateByAddingComponents:plusOneMonthComponent
                                              toDate:firstDayOfCurrentMonth
                                             options:0];
}

@end
