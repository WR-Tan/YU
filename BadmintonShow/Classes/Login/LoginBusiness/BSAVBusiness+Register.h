//
//  BSAVBusiness+Register.h
//  BadmintonShow
//
//  Created by LZH on 15/11/21.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSAVBusiness.h"
#import <AVQuery.h>


@interface BSAVBusiness (Register)

//  查询是否存在
+ (void)checkPlayerInfoExistence:(void (^)(bool isExisted))result;

//  创建附属的PlayerInfo
+ (void)createPlayerInfo:(void (^)(bool success))result;

@end
