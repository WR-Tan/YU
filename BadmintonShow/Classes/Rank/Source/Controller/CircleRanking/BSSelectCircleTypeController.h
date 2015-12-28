//
//  BSSelectCircleTypeController.h
//  BadmintonShow
//
//  Created by lizhihua on 12/27/15.
//  Copyright © 2015 LZH. All rights reserved.
//  （公开圈、私密圈）- 选择圈子类型：

#import "BSBaseTableViewController.h"

typedef NS_ENUM(NSUInteger, BSCircleOpenType) {
    BSCircleOpenTypeOpen = 0,
    BSCircleOpenTypePrivate ,
};

@protocol BSSelectCircleTypeControllerDelegate <NSObject>
- (void)didSelectOpenType:(BSCircleOpenType)openType;
@end

@interface BSSelectCircleTypeController : BSBaseTableViewController
@property (nonatomic, weak) id <BSSelectCircleTypeControllerDelegate> delegate ;
@end
