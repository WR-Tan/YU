//
//  BSUser.h
//  BadmintonShow
//
//  Created by lizhihua on 12/17/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSUser : NSObject

// AVObject的objectId
@property (nonatomic, readonly) NSString *userId;

-(instancetype) initWithUserId:(NSString *) userId;

@end
