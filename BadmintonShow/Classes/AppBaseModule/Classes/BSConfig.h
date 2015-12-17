//
//  BSConfig.h
//  BadmintonShow
//
//  Created by lizhihua on 12/17/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

#define API_TYPE_STG 0    //线上测试环境 //用于和服务端联调
#define API_TYPE_PRD 1    //生产环境

@interface BSConfig : NSObject
// app id
@property(nonatomic, copy) NSString *appId;  //用于离线缓存的key
// 本应用在appStore的ID
//@property(nonatomic, copy) NSString *appStoreId;

// 统计用id
//@property(nonatomic, copy) NSString *mobStatId;

// Client name.
@property(nonatomic, copy) NSString *clientName;

// app名称比如新路由或百度智家
@property(nonatomic, copy) NSString *appName;

// Client version.
@property(nonatomic, copy) NSString *version;

@property(nonatomic, copy) NSString *apiHost; //远程接口host

@property(nonatomic, assign) NSInteger apiType; //开发环境: 0  测试环境: 1 生产环境: 2

@property(nonatomic, strong) NSString *channelId; //渠道号

@property(nonatomic, assign) NSString *appDescription; //当前版本描述

@property(nonatomic, copy) NSString *apnsCertName; //apns证书名称

@property (nonatomic, copy) NSString *bsAppID;        //APP 渠道号

@property (nonatomic, copy) NSString *bsApiVersion;		//版本兼容

+ (BSConfig *)instance;

- (void)initEnv;

- (NSString *)apiHostWithApiType:(NSInteger)apiType;


@end
