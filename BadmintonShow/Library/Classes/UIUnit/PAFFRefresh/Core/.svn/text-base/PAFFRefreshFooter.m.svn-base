//
//  luochenxun (luochenxun@foxmail.com)
//
//  Created by luochenxun on 2015-09-02.
//  Copyright (c) 2015年 PinAgn. All rights reserved.
//

#import "PAFFRefreshFooter.h"

@interface PAFFRefreshFooter ()

@end

@implementation PAFFRefreshFooter

#pragma mark - 构造方法
+ (instancetype)footerWithRefreshingBlock:
        (PAFFRefreshComponentRefreshingBlock)refreshingBlock {
  PAFFRefreshFooter *cmp = [[self alloc] init];
  cmp.refreshingBlock = refreshingBlock;
  return cmp;
}
+ (instancetype)footerWithRefreshingTarget:(id)target
                          refreshingAction:(SEL)action {
  PAFFRefreshFooter *cmp = [[self alloc] init];
  [cmp setRefreshingTarget:target refreshingAction:action];
  return cmp;
}

#pragma mark - 重写父类的方法
- (void)prepare {
  [super prepare];
  
  // 设置自己的高度
  self.mj_h = PAFFRefreshFooterHeight;
  
  // 默认是自动隐藏
  self.automaticallyHidden = YES;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  
  if (newSuperview) {
    // 监听scrollView数据的变化
    [self.scrollView setReloadDataBlock:^(NSInteger totalDataCount) {
      if (self.isAutomaticallyHidden) {
        self.hidden = (self.scrollView.totalDataCount == 0);
      }
    }];
  }
}

#pragma mark - 公共方法
- (void)noticeNoMoreData {
  self.state = PAFFRefreshStateNoMoreData;
}

- (void)resetNoMoreData
{
    self.state = PAFFRefreshStateIdle;
}
@end
