//
//  BSProfileUser.h
//  BadmintonShow
//
//  Created by lizhihua on 12/14/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BSProfileUserModel : NSObject

@property (nonatomic, copy) NSString *objectId ;

//  Profile
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *yuxiuId;
@property (nonatomic, copy) NSString *QRCode;
@property (nonatomic, copy) NSString *genderStr;

@property (nonatomic, assign) NSInteger mbLevel ;
@property (nonatomic, assign) NSInteger rankLevel ;

//  Profile Edit
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger weight;
@property (nonatomic, strong) NSDate *birthday;
@property (nonatomic, copy) NSString *region; // 广东 深圳
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *street;
//  Education
@property (nonatomic, copy) NSString *school;
//  Job
@property (nonatomic, copy) NSString *company;

@property (nonatomic, copy) NSString *desc;

@end
