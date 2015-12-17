//
//  BSUserModel.m
//  BadmintonShow
//
//  Created by lizhihua on 12/16/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSUserModel.h"

@implementation BSUserModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"YuXiuId":@"yuxiuId",
             @"nickName":@"nickname"
             };
}


@end
