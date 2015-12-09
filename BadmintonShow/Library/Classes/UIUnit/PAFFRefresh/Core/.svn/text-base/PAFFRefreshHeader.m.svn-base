//
//  luochenxun (luochenxun@foxmail.com)
//
//  Created by luochenxun on 2015-09-02.
//  Copyright (c) 2015年 PinAgn. All rights reserved.
//
//

#import "PAFFRefreshHeader.h"

@interface PAFFRefreshHeader ()

@end

@implementation PAFFRefreshHeader
#pragma mark - 构造方法
- (instancetype)init {
  if (self = [super init]) {
    _refreshTimeout = 5; // 默认超时时间，5S
  }
  
  return self;
}

+ (instancetype)headerWithRefreshingBlock:
        (PAFFRefreshComponentRefreshingBlock)refreshingBlock {
  PAFFRefreshHeader *cmp = [[self alloc] init];
  cmp.refreshingBlock = refreshingBlock;
  return cmp;
}
+ (instancetype)headerWithRefreshingTarget:(id)target
                          refreshingAction:(SEL)action {
  PAFFRefreshHeader *cmp = [[self alloc] init];
  [cmp setRefreshingTarget:target refreshingAction:action];
  return cmp;
}

#pragma mark - 覆盖父类的方法
- (void)prepare {
  [super prepare];
  
  // 设置key
  self.lastUpdatedTimeKey = PAFFRefreshHeaderLastUpdatedTimeKey;
  
  // 设置高度
  self.mj_h = PAFFRefreshHeaderHeight;
}

- (void)placeSubviews {
  [super placeSubviews];
  
  // 设置y值(当自己的高度发生改变了，肯定要重新调整Y值，所以放到placeSubviews方法中设置y值)
  self.mj_y = -self.mj_h - self.ignoredScrollViewContentInsetTop;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
  [super scrollViewContentOffsetDidChange:change];
  
  // 在刷新的refreshing状态
  if (self.state == PAFFRefreshStateRefreshing) {
    // sectionheader停留解决
    return;
  }
  
  // 跳转到下一个控制器时，contentInset可能会变
  _scrollViewOriginalInset = self.scrollView.contentInset;
  
  // 当前的contentOffset
  CGFloat offsetY = self.scrollView.mj_offsetY;
  // 头部控件刚好出现的offsetY
  CGFloat happenOffsetY = -self.scrollViewOriginalInset.top;
  
  // 如果是向上滚动到看不见头部控件，直接返回
  if (offsetY >= happenOffsetY)
    return;
    
  // 普通 和 即将刷新 的临界点
  CGFloat normal2pullingOffsetY = happenOffsetY - self.mj_h;
  CGFloat pullingPercent = (happenOffsetY - offsetY) / self.mj_h;
  if (self.scrollView.isDragging) { // 如果正在拖拽
    self.pullingPercent = pullingPercent;
    if (self.state == PAFFRefreshStateIdle && offsetY < normal2pullingOffsetY) {
      // 转为即将刷新状态
      self.state = PAFFRefreshStatePulling;
    } else if (self.state == PAFFRefreshStatePulling &&
               offsetY >= normal2pullingOffsetY) {
      // 转为普通状态
      self.state = PAFFRefreshStateIdle;
    }
  } else if (self.state == PAFFRefreshStatePulling) { // 即将刷新 && 手松开
    // 开始刷新
    [self beginRefreshing];
    // delay timeout to end refresh , is timeout <=0 , do not end the refresh
    if (_refreshTimeout > 0) {
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                   (int64_t)(_refreshTimeout * 1000000000ull * 0.8)),
                     dispatch_get_main_queue(), ^{
                       [self endRefreshing];
                     });
    }
  } else if (pullingPercent < 1) {
    self.pullingPercent = pullingPercent;
  }
}

- (void)setState:(PAFFRefreshState)state {
  PAFFRefreshCheckState
  
      // 根据状态做事情
      if (state == PAFFRefreshStateIdle) {
    if (oldState != PAFFRefreshStateRefreshing)
      return;
      
    // 保存刷新时间
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date]
                                              forKey:self.lastUpdatedTimeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 恢复inset和offset
    [UIView animateWithDuration:PAFFRefreshSlowAnimationDuration
        animations:^{
          self.scrollView.mj_insetT -= self.mj_h;
          
          // 自动调整透明度
          if (self.isAutomaticallyChangeAlpha)
            self.alpha = 0.0;
        }
        completion:^(BOOL finished) {
          self.pullingPercent = 0.0;
        }];
  }
  else if (state == PAFFRefreshStateRefreshing) {
    [UIView animateWithDuration:PAFFRefreshFastAnimationDuration
        animations:^{
          // 增加滚动区域
          CGFloat top = self.scrollViewOriginalInset.top + self.mj_h;
          self.scrollView.mj_insetT = top;
          
          // 设置滚动位置
          self.scrollView.mj_offsetY = -top;
        }
        completion:^(BOOL finished) {
          [self executeRefreshingCallback];
        }];
  }
}

#pragma mark - 公共方法
- (void)endRefreshing {
  if ([self.scrollView isKindOfClass:[UICollectionView class]]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [super endRefreshing];
        });
    } else {
        [super endRefreshing];
    }
}

- (NSDate *)lastUpdatedTime
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:self.lastUpdatedTimeKey];
}
@end
