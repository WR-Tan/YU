//
//  BSUserInfo.h
//  BadmintonShow
//
//  Created by lizhihua on 12/17/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSUser.h"
//#import "HFModel.h"

@interface BSUserInfo : NSObject

-(instancetype) initWithUser:(__weak BSUser *) user;
@property (nonatomic, readonly, weak) BSUser *user;

@end


@interface BSUser (UserInfo)
@property (nonatomic, readonly) BSUserInfo *info;
@end