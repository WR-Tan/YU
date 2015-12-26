//
//  BSTLModel.h
//  BadmintonShow
//
//  Created by lizhihua on 12/25/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSBaseModel.h"
#import "AVOSCloud.h"
#import "BSProfileUserModel.h"

@interface BSTLModel : BSBaseModel

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) NSUInteger attitudesCount; // 点赞
@property (nonatomic, assign) NSUInteger commentsCount; // 评论
@property (nonatomic, strong) BSProfileUserModel *user;
@property (nonatomic, strong) NSArray *pics;

+ (BSTLModel *)modelWithAVObject:(AVObject *)object;

@end
