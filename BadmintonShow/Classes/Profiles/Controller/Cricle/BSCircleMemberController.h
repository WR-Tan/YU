//
//  BSCircleMemberController.h
//  BadmintonShow
//
//  Created by lizhihua on 16/1/6.
//  Copyright © 2016年 LZH. All rights reserved.
//

#import "BSBasePlayerRankingController.h"

@class BSCircleModel;

@interface BSCircleMemberController : BSBasePlayerRankingController
@property (nonatomic, strong) BSCircleModel *circle;
@end
