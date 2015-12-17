//
//  BSConfig.m
//  BadmintonShow
//
//  Created by lizhihua on 12/17/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSConfig.h"



/// APP渠道号
#define APP_CHANNEL_ID @"IOS-biaozhun"

@implementation BSConfig

static BSConfig *_instance = nil;

+ (BSConfig *)instance {
    static dispatch_once_t dt;
    dispatch_once(&dt, ^{
        _instance = [[BSConfig alloc] init];
    });
    
    return _instance;
}

- (void)setApiType:(NSInteger)apiType {
    _apiType = apiType;
    
    switch (_apiType) {
        case API_TYPE_STG: // 测试的配置
            break;
          
        case API_TYPE_PRD: // 生产的配置
            break;
            
        default:
            break;
    }
    
}

@end
