//
//  BSProfileBusiness.h
//  BadmintonShow
//
//  Created by lizhihua on 12/16/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BSProfileUserModel;

@interface BSProfileBusiness : NSObject

+ (void)getProflieMessageFromNet:(void (^)(BSProfileUserModel *profileUserMoel, NSError *err))block;

+ (BSProfileUserModel *)getUserProflieFromUserDefault;
    
@end
