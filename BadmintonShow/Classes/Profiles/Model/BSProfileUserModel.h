//
//  BSProfileUser.h
//  BadmintonShow
//
//  Created by lizhihua on 12/14/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSProfileUserModel : NSObject

//  Profile
@property (nonatomic, copy) NSString *avatarUrl ;
@property (nonatomic, copy) NSString *nickName ;
@property (nonatomic, copy) NSString *userName ;
@property (nonatomic, copy) NSString *yuxiuId ;
@property (nonatomic, copy) NSString *level ;

//  Profile Edit
@property (nonatomic, assign) NSInteger gender ;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger weight ;
@property (nonatomic, strong) NSDate *birthday ;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *street;


@property (nonatomic, copy) NSString *desc;

@end
