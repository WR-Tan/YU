//
//  BSAVBusiness+Register.m
//  BadmintonShow
//
//  Created by LZH on 15/11/21.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSAVBusiness+Register.h"
#import "AVUser.h"

@implementation BSAVBusiness (Register)


+ (void)checkPlayerInfoExistence:(void (^)(bool isExisted))result{

    // not now, (seems useless)
#if 0
    //  1.通过查询获取playerInfo对象
    AVQuery *query = [AVQuery queryWithClassName:@"PlayerInfo"];
    [query whereKey:@"userObjectId" equalTo:[AVUser currentUser].objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        AVObject *playerInfo = [objects firstObject];
        if (playerInfo) {
            result(YES);
        }else{
            result(NO);
        }
    }];
#endif
}


+ (void)createPlayerInfo:(void (^)(bool success))result{
    
    AVObject *playerInfo = [AVObject objectWithClassName:@"PlayerInfo"];
    playerInfo[@"userObjectId"] = [AVUser currentUser].objectId;
    [playerInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            result(YES);
        }else{
            result(NO);
        }
    }];
}

@end