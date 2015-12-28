//
//  BSSelectCircleCategoryController.h
//  BadmintonShow
//
//  Created by lizhihua on 12/27/15.
//  Copyright © 2015 LZH. All rights reserved.
//  选择圈子分类

#import "BSBaseTableViewController.h"

@protocol BSSelectCircleCategoryControllerDelegate <NSObject>
- (void)didSelectCircleCategory:(NSString *)category;
@end

@interface BSSelectCircleCategoryController : BSBaseTableViewController
@property (nonatomic, assign) NSUInteger selectType;
@property (nonatomic, weak) id <BSSelectCircleCategoryControllerDelegate> delegate;
@end
