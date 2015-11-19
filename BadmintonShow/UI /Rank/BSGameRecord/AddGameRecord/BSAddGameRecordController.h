//
//  BSAddGameRecordController.h
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSBaseTableViewController.h"

@class BSGameModel ;
@class AVObject ;

@protocol BSAddGameRecordControllerDelegate <NSObject>
// 上传比赛
- (void)saveGameObject:(AVObject *)gameObject;

@end

@interface BSAddGameRecordController : BSBaseTableViewController

@property (nonatomic, weak) id<BSAddGameRecordControllerDelegate> delegate ;


@end
