//
//  BSSetGameTypeController.h
//  BadmintonShow
//
//  Created by lizhihua on 12/20/15.
//  Copyright © 2015 LZH. All rights reserved.
//  设置比赛类型： 男单，女单，男双，女双，混双

#import "BSBaseTableViewController.h"
#import "BSAddGameBusiness.h"

typedef NS_OPTIONS(NSInteger, BMTGameType) {
    BMTGameTypeManSingle = 0,
    BMTGameTypeMenDouble,
    BMTGameTypeWomanSingle,
    BMTGameTypeWomenDouble,
    BMTGameTypeMixDouble,
};

@protocol BSSetGameTypeControllerDelegate <NSObject>
- (void)selectedBMTGameType:(BMTGameType)btmGameType;
@end

@interface BSSetGameTypeController : BSBaseTableViewController
@property (nonatomic, assign) BMTGameType bmtGameType ;
@property (nonatomic, weak) id <BSSetGameTypeControllerDelegate> delegate;
@end
