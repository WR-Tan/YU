//
//  luochenxun (luochenxun@foxmail.com)
//
//  Created by luochenxun on 2015-09-02.
//  Copyright (c) 2015年 PinAgn. All rights reserved.
//

#import "PAFFRefreshAutoStateFooter.h"

@interface PAFFRefreshAutoStateFooter () {
  /** 显示刷新状态的label */
  __weak UILabel *_stateLabel;
}
/** 所有状态对应的文字 */
@property(strong, nonatomic) NSMutableDictionary *stateTitles;
@end

@implementation PAFFRefreshAutoStateFooter
#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles {
  if (!_stateTitles) {
    self.stateTitles = [NSMutableDictionary dictionary];
  }
  return _stateTitles;
}

- (UILabel *)stateLabel {
  if (!_stateLabel) {
    [self addSubview:_stateLabel = [UILabel label]];
  }
  return _stateLabel;
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(PAFFRefreshState)state {
  if (title == nil)
    return;
  self.stateTitles[@(state)] = title;
  self.stateLabel.text = self.stateTitles[@(self.state)];
}

#pragma mark - 私有方法
- (void)stateLabelClick {
  if (self.state == PAFFRefreshStateIdle) {
    [self beginRefreshing];
  }
}

#pragma mark - 重写父类的方法
- (void)prepare {
  [super prepare];
  
  // 初始化文字
  [self setTitle:PAFFRefreshAutoFooterIdleText forState:PAFFRefreshStateIdle];
  [self setTitle:PAFFRefreshAutoFooterRefreshingText
        forState:PAFFRefreshStateRefreshing];
  [self setTitle:PAFFRefreshAutoFooterNoMoreDataText
        forState:PAFFRefreshStateNoMoreData];
        
  // 监听label
  self.stateLabel.userInteractionEnabled = YES;
  [self.stateLabel
      addGestureRecognizer:[[UITapGestureRecognizer alloc]
                               initWithTarget:self
                                       action:@selector(stateLabelClick)]];
}

- (void)placeSubviews {
  [super placeSubviews];
  
  // 状态标签
  self.stateLabel.frame = self.bounds;
}

- (void)setState:(PAFFRefreshState)state {
  PAFFRefreshCheckState
  
      if (self.isRefreshingTitleHidden && state == PAFFRefreshStateRefreshing) {
    self.stateLabel.text = nil;
    } else {
        self.stateLabel.text = self.stateTitles[@(state)];
    }
}
@end