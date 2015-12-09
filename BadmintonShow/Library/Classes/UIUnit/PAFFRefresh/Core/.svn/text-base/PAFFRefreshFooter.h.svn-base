//
//  luochenxun (luochenxun@foxmail.com)
//
//  Created by luochenxun on 2015-09-02.
//  Copyright (c) 2015年 PinAgn. All rights reserved.
//
//  上拉刷新控件

#import "PAFFRefreshComponent.h"

@interface PAFFRefreshFooter : PAFFRefreshComponent
/** 创建footer */
+ (instancetype)footerWithRefreshingBlock:
        (PAFFRefreshComponentRefreshingBlock)refreshingBlock;
/** 创建footer */
+ (instancetype)footerWithRefreshingTarget:(id)target
                          refreshingAction:(SEL)action;
                          
/** 提示没有更多的数据 */
- (void)noticeNoMoreData;
/** 重置没有更多的数据（消除没有更多数据的状态） */
- (void)resetNoMoreData;

/** 忽略多少scrollView的contentInset的bottom */
@property(assign, nonatomic) CGFloat ignoredScrollViewContentInsetBottom;

/** 自动根据有无数据来显示和隐藏（有数据就显示，没有数据隐藏） */
@property (assign, nonatomic, getter=isAutomaticallyHidden) BOOL automaticallyHidden;
@end
