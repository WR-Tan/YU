//
//  luochenxun (luochenxun@foxmail.com)
//
//  Created by luochenxun on 2015-09-02.
//  Copyright (c) 2015年 PinAgn. All rights reserved.
//
//  下拉刷新控件:负责监控用户下拉的状态

#import "PAFFRefreshComponent.h"

@interface PAFFRefreshHeader : PAFFRefreshComponent

/** 创建header */
+ (instancetype)headerWithRefreshingBlock:(PAFFRefreshComponentRefreshingBlock)refreshingBlock;
/** 创建header */
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 这个key用来存储上一次下拉刷新成功的时间 */
@property (copy, nonatomic) NSString *lastUpdatedTimeKey;
/** 上一次下拉刷新成功的时间 */
@property (strong, nonatomic, readonly) NSDate *lastUpdatedTime;

/** 忽略多少scrollView的contentInset的top */
@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetTop;

/** 下拉刷新的超时时间，如果小于等于0表示永不超时 */
@property (assign, nonatomic) CGFloat refreshTimeout;
@end
