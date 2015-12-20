//
//  BSAppContext.h
//  BadmintonShow
//
//  Created by lizhihua on 12/18/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSProfileUserModel.h"

#define AppContext [BSAppContext instance]

@interface BSAppContext : NSObject

+ (BSAppContext *)instance;

/// The Current User
@property (nonatomic ,strong) BSProfileUserModel *user;


@end
