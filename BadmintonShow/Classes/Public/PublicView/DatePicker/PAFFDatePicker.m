//
//  PAFFDatePicker.m
//  1111
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//
// Update by luochenxun - 2015/09/25




#import "PAFFDatePicker.h"
#import "PAFFDatePickerDateModel.h"

#define PAFFPICKER_MAXDATE 2050
#define PAFFPICKER_MINDATE 1915

#define PAFFPICKER_MONTH 12
#define PAFFPICKER_HOUR 24
#define PAFFPICKER_MINUTE 60

#define UU_GRAY [UIColor redColor];
#define UU_BLACK [UIColor blackColor];

#ifndef isIOS7
#define isIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#endif

@interface PAFFDatePicker () {
    UIPickerView *myPickerView;
    
    //日期存储数组
    NSMutableArray *yearArray;
    NSMutableArray *monthArray;
    NSMutableArray *dayArray;
    NSMutableArray *hourArray;
    NSMutableArray *minuteArray;
    
    //限制model
    PAFFDatePickerDateModel *maxDateModel;
    PAFFDatePickerDateModel *minDateModel;
    
    //记录位置
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
    NSInteger hourIndex;
    NSInteger minuteIndex;
}

@end

@implementation PAFFDatePicker

- (id)initWithframe:(CGRect)frame Delegate:(id<PAFFDatePickerDelegate>)delegate PickerStyle:(DateStyle)uuDateStyle {
    self.hasScroll = NO;
    
    self.datePickerStyle = uuDateStyle;
    self.delegate1 = delegate;
    return [self initWithFrame:frame];
}

- (id)initWithframe:(CGRect)frame PickerStyle:(DateStyle)uuDateStyle didSelected:(FinishBlock)finishBlock {

    self.hasScroll = NO;
    
    self.datePickerStyle = uuDateStyle;
    self.finishBlock = finishBlock;
    return [self initWithFrame:frame];
}

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.backgroundColor =[UIColor whiteColor];
//    }
//    return self;
//}
- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.hasScroll = NO;
    }
    return self;
}

#pragma mark - 初始化赋值操作
- (NSMutableArray *)ishave:(id)mutableArray {
    if (mutableArray)
        [mutableArray removeAllObjects];
    else
        mutableArray = [NSMutableArray array];
    return mutableArray;
}

//进行初始化
- (void)drawRect:(CGRect)rect {
    if (self.frame.size.height < 216 || self.frame.size.width < 320)
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 320, 216);
    self.titleLabel.text = @"选择日期";
    yearArray = [self ishave:yearArray];
    monthArray = [self ishave:monthArray];
    dayArray = [self ishave:dayArray];
    hourArray = [self ishave:hourArray];
    minuteArray = [self ishave:minuteArray];
    
    //赋值
    for (int i = 0; i < PAFFPICKER_MINUTE; i++) {
        NSString *num = [NSString stringWithFormat:@"%02d", i];
        if (0 < i && i <= PAFFPICKER_MONTH)
            [monthArray addObject:num];
        if (i < PAFFPICKER_HOUR)
            [hourArray addObject:num];
        [minuteArray addObject:num];
    }
    for (int i = PAFFPICKER_MINDATE; i < PAFFPICKER_MAXDATE; i++) {
        NSString *num = [NSString stringWithFormat:@"%d", i];
        [yearArray addObject:num];
    }
    
    //最大最小限制
    if (self.maxLimitDate) {
        maxDateModel = [[PAFFDatePickerDateModel alloc] initWithDate:self.maxLimitDate];
    } else {
        self.maxLimitDate = [self dateFromString:@"204912312359" withFormat:@"yyyyMMddHHmm"];
        maxDateModel = [[PAFFDatePickerDateModel alloc] initWithDate:self.maxLimitDate];
    }
    //最小限制
    if (self.minLimitDate) {
        minDateModel = [[PAFFDatePickerDateModel alloc] initWithDate:self.minLimitDate];
    } else {
        self.minLimitDate = [self dateFromString:@"191501010000" withFormat:@"yyyyMMddHHmm"];
        minDateModel = [[PAFFDatePickerDateModel alloc] initWithDate:self.minLimitDate];
    }
    
    //获取当前日期，储存当前时间位置
    NSArray *indexArray = [self getNowDate:self.ScrollToDate];
    
    if (!myPickerView) {
        myPickerView =
            [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        myPickerView.showsSelectionIndicator = YES;
        myPickerView.backgroundColor = [UIColor clearColor];
        myPickerView.delegate = self;
        myPickerView.dataSource = self;
        [self addSubview:myPickerView];
    }
    //调整为现在的时间
    for (int i = 0; i < indexArray.count; i++) {
        [myPickerView selectRow:[indexArray[i] integerValue] inComponent:i animated:NO];
    }
    [self playTheDelegate];
    //[self DaysfromYear:[indexArray[0] integerValue] andMonth:[indexArray[1] integerValue]];
}
#pragma mark - 调整颜色

//获取当前时间解析及位置
- (NSArray *)getNowDate:(NSDate *)date {
    NSDate *dateShow;
    if (date) {
        dateShow = date;
    } else {
        dateShow = [NSDate date];
    }
    
    PAFFDatePickerDateModel *model = [[PAFFDatePickerDateModel alloc] initWithDate:dateShow];
    
    [self DaysfromYear:[model.year integerValue] andMonth:[model.month integerValue]];
    
    yearIndex = [model.year intValue] - PAFFPICKER_MINDATE;
    monthIndex = [model.month intValue] - 1;
    dayIndex = [model.day intValue] - 1;
    hourIndex = [model.hour intValue] - 0;
    minuteIndex = [model.minute intValue] - 0;
    
    NSNumber *year = [NSNumber numberWithInteger:yearIndex];
    NSNumber *month = [NSNumber numberWithInteger:monthIndex];
    NSNumber *day = [NSNumber numberWithInteger:dayIndex];
    NSNumber *hour = [NSNumber numberWithInteger:hourIndex];
    NSNumber *minute = [NSNumber numberWithInteger:minuteIndex];
    
    if (self.datePickerStyle == UUDateStyle_YearMonthDayHourMinute)
        return @[ year, month, day, hour, minute ];
    if (self.datePickerStyle == UUDateStyle_YearMonthDay)
        return @[ year, month, day ];
    if (self.datePickerStyle == UUDateStyle_MonthDayHourMinute)
        return @[ month, day, hour, minute ];
    if (self.datePickerStyle == UUDateStyle_HourMinute)
        return @[ hour, minute ];
    if (self.datePickerStyle == UUDateStyle_YearMonth)
        return @[ year, month ];
    return nil;
}

- (void)creatValuePointXs:(NSArray *)xArr withNames:(NSArray *)names {
    for (int i = 0; i < xArr.count; i++) {
        [self addLabelWithNames:names[i] withPointX:[xArr[i] intValue]];
    }
}

- (void)addLabelWithNames:(NSString *)name withPointX:(NSInteger)point_x {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(point_x, 99, 20, 20)];
    label.text = name;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor blackColor];
    label.layer.shadowColor = [[UIColor whiteColor] CGColor];
    label.layer.shadowOpacity = 0.5;
    label.layer.shadowRadius = 5;
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.datePickerStyle == UUDateStyle_YearMonthDayHourMinute) {
        if (isIOS7) {
            [self creatValuePointXs:@[ @"80", @"135", @"190", @"245", @"300" ]
                          withNames:@[ @"年", @"月", @"日", @"时", @"分" ]];
        }
        return 5;
    }
    if (self.datePickerStyle == UUDateStyle_YearMonthDay) {
        if (isIOS7) {
            if ([[UIScreen mainScreen] bounds].size.width > 375) {
                [self creatValuePointXs:@[ @"155", @"215", @"290" ] withNames:@[ @"年", @"月", @"日" ]];
            } else if ([[UIScreen mainScreen] bounds].size.width == 375) {
                [self creatValuePointXs:@[ @"135", @"195", @"270" ] withNames:@[ @"年", @"月", @"日" ]];
            } else
                [self creatValuePointXs:@[ @"110", @"170", @"250" ] withNames:@[ @"年", @"月", @"日" ]];
        }
        return 3;
    }
    if (self.datePickerStyle == UUDateStyle_MonthDayHourMinute) {
        if (isIOS7) {
            [self creatValuePointXs:@[ @"90", @"160", @"230", @"285" ] withNames:@[ @"月", @"日", @"时", @"分" ]];
        }
        return 4;
    }
    if (self.datePickerStyle == UUDateStyle_HourMinute) {
        if (isIOS7) {
            [self creatValuePointXs:@[ @"140", @"245" ] withNames:@[ @"时", @"分" ]];
        }
        return 2;
    }
    if (self.datePickerStyle == UUDateStyle_YearMonth) {
        if (isIOS7) {
            if ([[UIScreen mainScreen] bounds].size.width < 375) {
                [self creatValuePointXs:@[ @"130", @"225" ] withNames:@[ @"年", @"月" ]];
            } else if ([[UIScreen mainScreen] bounds].size.width == 375) {
                [self creatValuePointXs:@[ @"155", @"245" ] withNames:@[ @"年", @"月" ]];
            } else {
                [self creatValuePointXs:@[ @"185", @"275" ] withNames:@[ @"年", @"月" ]];
            }
        }
        return 2;
    }
    
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.datePickerStyle == UUDateStyle_YearMonthDayHourMinute) {
        if (component == 0)
            return PAFFPICKER_MAXDATE - PAFFPICKER_MINDATE;
        if (component == 1)
            return PAFFPICKER_MONTH;
        if (component == 2) {
            return
                [self DaysfromYear:[yearArray[yearIndex] integerValue] andMonth:[monthArray[monthIndex] integerValue]];
        }
        if (component == 3)
            return PAFFPICKER_HOUR;
        if (component == 4)
            return PAFFPICKER_MINUTE;
    }
    if (self.datePickerStyle == UUDateStyle_YearMonthDay) {
        if (component == 0)
            return PAFFPICKER_MAXDATE - PAFFPICKER_MINDATE;
        if (component == 1)
            return PAFFPICKER_MONTH;
        if (component == 2) {
            return
                [self DaysfromYear:[yearArray[yearIndex] integerValue] andMonth:[monthArray[monthIndex] integerValue]];
        }
    }
    if (self.datePickerStyle == UUDateStyle_MonthDayHourMinute) {
        if (component == 0)
            return PAFFPICKER_MONTH;
        if (component == 1) {
            return
                [self DaysfromYear:[yearArray[yearIndex] integerValue] andMonth:[monthArray[monthIndex] integerValue]];
        }
        if (component == 2)
            return PAFFPICKER_HOUR;
        if (component == 3)
            return PAFFPICKER_MINUTE;
    }
    if (self.datePickerStyle == UUDateStyle_HourMinute) {
        if (component == 0)
            return PAFFPICKER_HOUR;
        else
            return PAFFPICKER_MINUTE;
    }
    if (self.datePickerStyle == UUDateStyle_YearMonth) {
        if (component == 0)
            return PAFFPICKER_MAXDATE - PAFFPICKER_MINDATE;
        else
            return PAFFPICKER_MONTH;
    }
    return 0;
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    switch (self.datePickerStyle) {
        case UUDateStyle_YearMonthDayHourMinute: {
            if (component == 0) return 70;
            if (component == 1) return 50;
            if (component == 2) return 50;
            if (component == 3) return 50;
            if (component == 4) return 50;
        } break;
        case UUDateStyle_YearMonthDay: {
            if (component == 0) return 50;
            if (component == 1) return 90;
            if (component == 2) return 50;
        } break;
        case UUDateStyle_MonthDayHourMinute: {
            if (component == 0) return 70;
            if (component == 1) return 60;
            if (component == 2) return 60;
            if (component == 3) return 60;
        } break;
        case UUDateStyle_HourMinute: {
            if (component == 0) return 100;
            if (component == 1) return 100;
        } break;
        case UUDateStyle_YearMonth: {
            if (component == 0) return 100;
            if (component == 1) return 100;
        } break;
        default:
            break;
    }
    
    return 0;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    //滚动
    self.hasScroll = YES;
    
    switch (self.datePickerStyle) {
        case UUDateStyle_YearMonthDayHourMinute: {
        
            if (component == 0) {
                yearIndex = row;
            }
            if (component == 1) {
                monthIndex = row;
            }
            if (component == 2) {
                dayIndex = row;
            }
            if (component == 3) {
                hourIndex = row;
            }
            if (component == 4) {
                minuteIndex = row;
            }
            if (component == 0 || component == 1 || component == 2) {
                [self DaysfromYear:[yearArray[yearIndex] integerValue] andMonth:[monthArray[monthIndex] integerValue]];
                if (dayArray.count - 1 < dayIndex) {
                    dayIndex = dayArray.count - 1;
                }
                //                [pickerView reloadComponent:2];
            }
        } break;
        
        case UUDateStyle_YearMonthDay: {
        
            if (component == 0) {
                yearIndex = row;
            }
            if (component == 1) {
                monthIndex = row;
            }
            if (component == 2) {
                dayIndex = row;
            }
            if (component == 0 || component == 1) {
                [self DaysfromYear:[yearArray[yearIndex] integerValue] andMonth:[monthArray[monthIndex] integerValue]];
                if (dayArray.count - 1 < dayIndex) {
                    dayIndex = dayArray.count - 1;
                }
                //                [pickerView reloadComponent:2];
            }
        } break;
        
        case UUDateStyle_MonthDayHourMinute: {
            if (component == 1) {
                dayIndex = row;
            }
            if (component == 2) {
                hourIndex = row;
            }
            if (component == 3) {
                minuteIndex = row;
            }
            if (component == 0) {
                monthIndex = row;
                if (dayArray.count - 1 < dayIndex) {
                    dayIndex = dayArray.count - 1;
                }
                //                [pickerView reloadComponent:1];
            }
            [self DaysfromYear:[yearArray[yearIndex] integerValue] andMonth:[monthArray[monthIndex] integerValue]];
            
        } break;
        
        case UUDateStyle_HourMinute: {
            if (component == 3) {
                hourIndex = row;
            }
            if (component == 4) {
                minuteIndex = row;
            }
        } break;
        case UUDateStyle_YearMonth: {
            if (component == 0) {
                yearIndex = row;
            }
            if (component == 1) {
                monthIndex = row;
            }
            if (component == 0) {
                [self DaysfromYear:[yearArray[yearIndex] integerValue] andMonth:[monthArray[monthIndex] integerValue]];
                if (monthArray.count - 1 < monthIndex) {
                    monthIndex = monthArray.count - 1;
                }
            }
            
        } break;
        default:
            break;
    }
    
    [self playTheDelegate];
    
    [pickerView reloadAllComponents];
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    UILabel *customLabel = (UILabel *)view;
    if (!customLabel) {
        customLabel = [[UILabel alloc] init];
        customLabel.textAlignment = NSTextAlignmentCenter;
        [customLabel setFont:[UIFont systemFontOfSize:18]];
    }
    UIColor *textColor = [UIColor blackColor];
    NSString *title;
    
    switch (self.datePickerStyle) {
        case UUDateStyle_YearMonthDayHourMinute: {
            if (component == 0) {
                title = yearArray[row];
                textColor = [self returnYearColorRow:row];
            }
            if (component == 1) {
                title = monthArray[row];
                textColor = [self returnMonthColorRow:row];
            }
            if (component == 2) {
                title = dayArray[row];
                textColor = [self returnDayColorRow:row];
            }
            if (component == 3) {
                title = hourArray[row];
                textColor = [self returnHourColorRow:row];
            }
            if (component == 4) {
                title = minuteArray[row];
                textColor = [self returnMinuteColorRow:row];
            }
        } break;
        
        case UUDateStyle_YearMonthDay: {
            if (component == 0) {
                title = yearArray[row];
                textColor = [self returnYearColorRow:row];
            }
            if (component == 1) {
                title = monthArray[row];
                textColor = [self returnMonthColorRow:row];
            }
            if (component == 2) {
                title = dayArray[row];
                textColor = [self returnDayColorRow:row];
            }
        } break;
        
        case UUDateStyle_MonthDayHourMinute: {
            if (component == 0) {
                title = monthArray[row];
                textColor = [self returnMonthColorRow:row];
            }
            if (component == 1) {
                title = dayArray[row];
                textColor = [self returnDayColorRow:row];
            }
            if (component == 2) {
                title = hourArray[row];
                textColor = [self returnHourColorRow:row];
            }
            if (component == 3) {
                title = minuteArray[row];
                textColor = [self returnMinuteColorRow:row];
            }
        } break;
        
        case UUDateStyle_HourMinute: {
            if (component == 0) {
                title = hourArray[row];
                textColor = [self returnHourColorRow:row];
            }
            if (component == 1) {
                title = minuteArray[row];
                textColor = [self returnMinuteColorRow:row];
            }
        } break;
        case UUDateStyle_YearMonth: {
            if (component == 0) {
                title = yearArray[row];
                textColor = [self returnYearColorRow:row];
            }
            if (component == 1) {
                title = monthArray[row];
                textColor = [self returnMonthColorRow:row];
            }
            
        } break;
        default:
            break;
    }
    customLabel.text = title;
    customLabel.textColor = textColor;
    return customLabel;
}

#pragma mark - 代理回调方法
- (void)playTheDelegate {
    NSDate *date = [self
        dateFromString:[NSString stringWithFormat:@"%@%@%@%@%@", yearArray[yearIndex], monthArray[monthIndex],
                                                  dayArray[dayIndex], hourArray[hourIndex], minuteArray[minuteIndex]]
            withFormat:@"yyyyMMddHHmm"];
    if ([date compare:self.minLimitDate] == NSOrderedAscending) {
        NSArray *array = [self getNowDate:self.minLimitDate];
        for (int i = 0; i < array.count; i++) {
            [myPickerView selectRow:[array[i] integerValue] inComponent:i animated:YES];
        }
    } else if ([date compare:self.maxLimitDate] == NSOrderedDescending) {
        NSArray *array = [self getNowDate:self.maxLimitDate];
        for (int i = 0; i < array.count; i++) {
            [myPickerView selectRow:[array[i] integerValue] inComponent:i animated:YES];
        }
    }
    
    NSString *strWeekDay =
        [self getWeekDayWithYear:yearArray[yearIndex] month:monthArray[monthIndex] day:dayArray[dayIndex]];
        
    // block 回调
    if (self.finishBlock) {
        self.finishBlock(yearArray[yearIndex], monthArray[monthIndex], dayArray[dayIndex], hourArray[hourIndex],
                         minuteArray[minuteIndex], strWeekDay);
    }
    //代理回调
    [self.delegate1 datePicker:self
                          year:yearArray[yearIndex]
                         month:monthArray[monthIndex]
                           day:dayArray[dayIndex]
                          hour:hourArray[hourIndex]
                        minute:minuteArray[minuteIndex]
                       weekDay:strWeekDay];
}

#pragma mark - 数据处理
//通过日期求星期
- (NSString *)getWeekDayWithYear:(NSString *)year month:(NSString *)month day:(NSString *)day {
    NSInteger yearInt = [year integerValue];
    NSInteger monthInt = [month integerValue];
    NSInteger dayInt = [day integerValue];
    int c = 20;               //世纪
    int y = (int)yearInt - 1; //年
    int d = (int)dayInt;
    int m = (int)monthInt;
    int w = (y + (y / 4) + (c / 4) - 2 * c + (26 * (m + 1) / 10) + d - 1) % 7;
    NSString *weekDay = @"";
    switch (w) {
        case 0:
            weekDay = @"周日";
            break;
        case 1:
            weekDay = @"周一";
            break;
        case 2:
            weekDay = @"周二";
            break;
        case 3:
            weekDay = @"周三";
            break;
        case 4:
            weekDay = @"周四";
            break;
        case 5:
            weekDay = @"周五";
            break;
        case 6:
            weekDay = @"周六";
            break;
        default:
            break;
    }
    return weekDay;
}

//根据string返回date
- (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

//通过年月求每月天数
- (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month {
    NSInteger num_year = year;
    NSInteger num_month = month;
    
    BOOL isrunNian = num_year % 4 == 0 ? (num_year % 100 == 0 ? (num_year % 400 == 0 ? YES : NO) : YES) : NO;
    switch (num_month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12: {
            [self setdayArray:31];
            return 31;
        } break;
        case 4:
        case 6:
        case 9:
        case 11: {
            [self setdayArray:30];
            return 30;
        } break;
        case 2: {
            if (isrunNian) {
                [self setdayArray:29];
                return 29;
            } else {
                [self setdayArray:28];
                return 28;
            }
        } break;
        default:
            break;
    }
    return 0;
}

//设置每月的天数数组
- (void)setdayArray:(NSInteger)num {
    [dayArray removeAllObjects];
    for (int i = 1; i <= num; i++) {
        [dayArray addObject:[NSString stringWithFormat:@"%02d", i]];
    }
}

- (UIColor *)returnYearColorRow:(NSInteger)row {
    if ([yearArray[row] intValue] < [minDateModel.year intValue] ||
        [yearArray[row] intValue] > [maxDateModel.year intValue]) {
        return UU_GRAY;
    } else {
        return UU_BLACK;
    }
}
- (UIColor *)returnMonthColorRow:(NSInteger)row {

    if ([yearArray[yearIndex] intValue] < [minDateModel.year intValue] ||
        [yearArray[yearIndex] intValue] > [maxDateModel.year intValue]) {
        return UU_GRAY;
    } else if ([yearArray[yearIndex] intValue] > [minDateModel.year intValue] &&
               [yearArray[yearIndex] intValue] < [maxDateModel.year intValue]) {
        return UU_BLACK;
    } else if ([minDateModel.year intValue] == [maxDateModel.year intValue]) {
        if ([monthArray[row] intValue] >= [minDateModel.month intValue] &&
            [monthArray[row] intValue] <= [maxDateModel.month intValue]) {
            return UU_BLACK;
        } else {
            return UU_GRAY;
        }
    } else if ([yearArray[yearIndex] intValue] == [minDateModel.year intValue]) {
        if ([monthArray[row] intValue] >= [minDateModel.month intValue]) {
            return UU_BLACK;
        } else {
            return UU_GRAY;
        }
    } else {
        if ([monthArray[row] intValue] > [maxDateModel.month intValue]) {
            return UU_GRAY;
        } else {
            return UU_BLACK;
        }
    }
}
- (UIColor *)returnDayColorRow:(NSInteger)row {
    if ([yearArray[yearIndex] intValue] < [minDateModel.year intValue] ||
        [yearArray[yearIndex] intValue] > [maxDateModel.year intValue]) {
        return UU_GRAY;
    } else if ([yearArray[yearIndex] intValue] > [minDateModel.year intValue] &&
               [yearArray[yearIndex] intValue] < [maxDateModel.year intValue]) {
        return UU_BLACK;
    } else if ([minDateModel.year intValue] == [maxDateModel.year intValue]) {
        if ([monthArray[monthIndex] intValue] > [minDateModel.month intValue] &&
            [monthArray[monthIndex] intValue] < [maxDateModel.month intValue]) {
            return UU_BLACK;
        } else if ([minDateModel.month intValue] == [maxDateModel.month intValue]) {
            if ([dayArray[row] intValue] >= [minDateModel.day intValue] &&
                [dayArray[row] intValue] <= [maxDateModel.day intValue]) {
                return UU_BLACK;
            } else {
                return UU_GRAY;
            }
        } else {
            return UU_GRAY;
        }
    } else if ([yearArray[yearIndex] intValue] == [minDateModel.year intValue]) {
        if ([monthArray[monthIndex] intValue] < [minDateModel.month intValue]) {
            return UU_GRAY;
        } else if ([monthArray[monthIndex] intValue] == [minDateModel.month intValue]) {
            if ([dayArray[row] intValue] >= [minDateModel.day intValue]) {
                return UU_BLACK;
            } else {
                return UU_GRAY;
            }
        } else {
            return UU_BLACK;
        }
    } else {
        if ([monthArray[monthIndex] intValue] > [maxDateModel.month intValue]) {
            return UU_GRAY;
        } else if ([monthArray[monthIndex] intValue] == [maxDateModel.month intValue]) {
            if ([dayArray[row] intValue] <= [maxDateModel.day intValue]) {
                return UU_BLACK;
            } else {
                return UU_GRAY;
            }
        } else {
            return UU_BLACK;
        }
    }
}
- (UIColor *)returnHourColorRow:(NSInteger)row {
    if ([yearArray[yearIndex] intValue] < [minDateModel.year intValue] ||
        [yearArray[yearIndex] intValue] > [maxDateModel.year intValue]) {
        return UU_GRAY;
    } else if ([yearArray[yearIndex] intValue] > [minDateModel.year intValue] &&
               [yearArray[yearIndex] intValue] < [maxDateModel.year intValue]) {
        return UU_BLACK;
    } else if ([minDateModel.year intValue] == [maxDateModel.year intValue]) {
        if ([monthArray[monthIndex] intValue] > [minDateModel.month intValue] &&
            [monthArray[monthIndex] intValue] < [maxDateModel.month intValue]) {
            return UU_BLACK;
        } else if ([minDateModel.month intValue] == [maxDateModel.month intValue]) {
            if ([dayArray[dayIndex] intValue] > [minDateModel.day intValue] &&
                [dayArray[dayIndex] intValue] < [maxDateModel.day intValue]) {
                return UU_BLACK;
            } else if ([minDateModel.day intValue] == [maxDateModel.day intValue]) {
                if ([hourArray[row] intValue] >= [minDateModel.hour intValue] &&
                    [hourArray[row] intValue] <= [maxDateModel.hour intValue]) {
                    return UU_BLACK;
                } else {
                    return UU_GRAY;
                }
            } else {
                return UU_GRAY;
            }
        } else {
            return UU_GRAY;
        }
    } else if ([yearArray[yearIndex] intValue] == [minDateModel.year intValue]) {
        if ([monthArray[monthIndex] intValue] < [minDateModel.month intValue]) {
            return UU_GRAY;
        } else if ([monthArray[monthIndex] intValue] == [minDateModel.month intValue]) {
            if ([dayArray[dayIndex] intValue] < [minDateModel.day intValue]) {
                return UU_GRAY;
            } else if ([dayArray[dayIndex] intValue] == [minDateModel.day intValue]) {
                if ([hourArray[row] intValue] < [minDateModel.hour intValue]) {
                    return UU_GRAY;
                } else {
                    return UU_BLACK;
                }
            } else {
                return UU_BLACK;
            }
        } else {
            return UU_BLACK;
        }
    } else {
        if ([monthArray[monthIndex] intValue] > [maxDateModel.month intValue]) {
            return UU_GRAY;
        } else if ([monthArray[monthIndex] intValue] == [maxDateModel.month intValue]) {
            if ([dayArray[dayIndex] intValue] < [maxDateModel.day intValue]) {
                return UU_BLACK;
            } else if ([dayArray[dayIndex] intValue] == [maxDateModel.day intValue]) {
                if ([hourArray[row] intValue] > [maxDateModel.hour intValue]) {
                    return UU_GRAY;
                } else {
                    return UU_BLACK;
                }
            } else {
                return UU_BLACK;
            }
        } else {
            return UU_BLACK;
        }
    }
}
- (UIColor *)returnMinuteColorRow:(NSInteger)row {

    if ([yearArray[yearIndex] intValue] < [minDateModel.year intValue] ||
        [yearArray[yearIndex] intValue] > [maxDateModel.year intValue]) {
        return UU_GRAY;
    } else if ([yearArray[yearIndex] intValue] > [minDateModel.year intValue] &&
               [yearArray[yearIndex] intValue] < [maxDateModel.year intValue]) {
        return UU_BLACK;
    } else if ([minDateModel.year intValue] == [maxDateModel.year intValue]) {
        if ([monthArray[monthIndex] intValue] > [minDateModel.month intValue] &&
            [monthArray[monthIndex] intValue] < [maxDateModel.month intValue]) {
            return UU_BLACK;
        } else if ([minDateModel.month intValue] == [maxDateModel.month intValue]) {
            if ([dayArray[dayIndex] intValue] > [minDateModel.day intValue] &&
                [dayArray[dayIndex] intValue] < [maxDateModel.day intValue]) {
                return UU_BLACK;
            } else if ([minDateModel.day intValue] == [maxDateModel.day intValue]) {
                if ([hourArray[hourIndex] intValue] > [minDateModel.hour intValue] &&
                    [hourArray[hourIndex] intValue] < [maxDateModel.hour intValue]) {
                    return UU_BLACK;
                } else if ([minDateModel.hour intValue] == [maxDateModel.hour intValue]) {
                    if ([minuteArray[row] intValue] <= [maxDateModel.minute intValue] &&
                        [minuteArray[row] intValue] >= [minDateModel.minute intValue]) {
                        return UU_BLACK;
                    } else {
                        return UU_GRAY;
                    }
                } else {
                    return UU_GRAY;
                }
            } else {
                return UU_GRAY;
            }
        } else {
            return UU_GRAY;
        }
    } else if ([yearArray[yearIndex] intValue] == [minDateModel.year intValue]) {
        if ([monthArray[monthIndex] intValue] < [minDateModel.month intValue]) {
            return UU_GRAY;
        } else if ([monthArray[monthIndex] intValue] == [minDateModel.month intValue]) {
            if ([dayArray[dayIndex] intValue] < [minDateModel.day intValue]) {
                return UU_GRAY;
            } else if ([dayArray[dayIndex] intValue] == [minDateModel.day intValue]) {
                if ([hourArray[hourIndex] intValue] < [minDateModel.hour intValue]) {
                    return UU_GRAY;
                } else if ([hourArray[hourIndex] intValue] == [minDateModel.hour intValue]) {
                    if ([minuteArray[row] intValue] < [minDateModel.minute intValue]) {
                        return UU_GRAY;
                    } else {
                        return UU_BLACK;
                    }
                } else {
                    return UU_BLACK;
                }
            } else {
                return UU_BLACK;
            }
        } else {
            return UU_BLACK;
        }
    } else {
        if ([monthArray[monthIndex] intValue] > [maxDateModel.month intValue]) {
            return UU_GRAY;
        } else if ([monthArray[monthIndex] intValue] == [maxDateModel.month intValue]) {
            if ([dayArray[dayIndex] intValue] < [maxDateModel.day intValue]) {
                return UU_BLACK;
            } else if ([dayArray[dayIndex] intValue] == [maxDateModel.day intValue]) {
                if ([hourArray[hourIndex] intValue] > [maxDateModel.hour intValue]) {
                    return UU_GRAY;
                } else if ([hourArray[hourIndex] intValue] == [maxDateModel.hour intValue]) {
                    if ([minuteArray[row] intValue] <= [maxDateModel.minute intValue]) {
                        return UU_BLACK;
                    }else{
                        return UU_GRAY;
                    }
                }else{
                    return UU_BLACK;
                }
                
                
            }else{
                return UU_BLACK;
            }
        }else{
            return UU_BLACK;
        }
    }
}
@end
