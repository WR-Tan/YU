//
//  BSCircleBusiness.h
//  BadmintonShow
//
//  Created by lizhihua on 12/24/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSCircleBusiness : NSObject


+ (void)queryRecommendedCircleWithBlock:(BSArrayResultBlock)block;

+ (void)queryCircleWithType:(NSString *)typeString  block:(BSArrayResultBlock)block;


@end
