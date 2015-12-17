//
//  BSUserModel.h
//  BadmintonShow
//
//  Created by lizhihua on 12/16/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSUserModel : NSObject

//  Base
@property (nonatomic, copy) NSString *objectId ;

//  Profile
@property (nonatomic, copy) NSString *avatarUrl ;
@property (nonatomic, copy) NSString *nickName ;
@property (nonatomic, copy) NSString *userName ;
@property (nonatomic, copy) NSString *YuXiuId ;
@property (nonatomic, copy) NSString *mbLevel ;
@property (nonatomic, copy) NSString *rankLevel ;
@property (nonatomic, copy) NSString *genderStr ;
//  Profile Edit
@property (nonatomic, assign) NSInteger gender ;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger weight ;
@property (nonatomic, strong) NSDate *birthday ;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, copy) NSString *desc;

//  Education
@property (nonatomic, copy) NSString *school;

//  Job
@property (nonatomic, copy) NSString *company;

//  Game
@property (nonatomic, assign) float score ;

@end
