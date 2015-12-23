//
//  BSTimeManager.h
//  BadmintonShow
//
//  Created by lizhihua on 12/21/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AppTimeManager  [BSTimeManager manager]

@interface BSTimeManager : NSObject

// 时间管理类单例
+ (instancetype)manager;

@property (nonatomic, strong) NSDate *lastSuccessRankRequestDate;

@end
