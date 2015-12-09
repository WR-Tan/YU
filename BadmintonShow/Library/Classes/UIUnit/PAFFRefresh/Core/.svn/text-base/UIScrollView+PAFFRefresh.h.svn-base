//
//  luochenxun (luochenxun@foxmail.com)
//
//  Created by luochenxun on 2015-09-02.
//  Copyright (c) 2015年 PinAgn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PAFFRefreshHeader, PAFFRefreshFooter;

@interface UIScrollView (PAFFRefresh)
/** 下拉刷新控件 */
@property(strong, nonatomic) PAFFRefreshHeader *paffHeader;
/** 上拉刷新控件 */
@property(strong, nonatomic) PAFFRefreshFooter *paffFooter;

#pragma mark - other
- (NSInteger)totalDataCount;
@property(copy, nonatomic) void (^reloadDataBlock)(NSInteger totalDataCount);
@end
