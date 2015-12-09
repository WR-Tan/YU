//
//  luochenxun (luochenxun@foxmail.com)
//
//  Created by luochenxun on 2015-09-02.
//  Copyright (c) 2015年 PinAgn. All rights reserved.
//

#import "PAFFRefreshComponent.h"
#import "PAFFRefreshConst.h"
#import "UIView+PAFFExtension.h"

@interface PAFFRefreshComponent ()
@property(strong, nonatomic) UIPanGestureRecognizer *pan;
@end

@implementation PAFFRefreshComponent
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    // 准备工作
    [self prepare];
    
    // 默认是普通状态
    self.state = PAFFRefreshStateIdle;
  }
  return self;
}

- (void)prepare {
  // 基本属性
  self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  self.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  [self placeSubviews];
}

- (void)placeSubviews {
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  
  // 如果不是UIScrollView，不做任何事情
  if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]])
    return;
    
  // 旧的父控件移除监听
  [self removeObservers];
  
  if (newSuperview) { // 新的父控件
    // 设置宽度
    self.mj_w = newSuperview.mj_w;
    // 设置位置
    self.mj_x = 0;
    
    // 记录UIScrollView
    _scrollView = (UIScrollView *)newSuperview;
    // 设置永远支持垂直弹簧效果
    _scrollView.alwaysBounceVertical = YES;
    // 记录UIScrollView最开始的contentInset
    _scrollViewOriginalInset = self.scrollView.contentInset;
    
    // 添加监听
    [self addObservers];
  }
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  
  if (self.state == PAFFRefreshStateWillRefresh) {
    // 预防view还没显示出来就调用了beginRefreshing
    self.state = PAFFRefreshStateRefreshing;
  }
}

#pragma mark - KVO监听
- (void)addObservers {
  NSKeyValueObservingOptions options =
      NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
  [self.scrollView addObserver:self
                    forKeyPath:PAFFRefreshKeyPathContentOffset
                       options:options
                       context:nil];
  [self.scrollView addObserver:self
                    forKeyPath:PAFFRefreshKeyPathContentSize
                       options:options
                       context:nil];
  self.pan = self.scrollView.panGestureRecognizer;
  [self.pan addObserver:self
             forKeyPath:PAFFRefreshKeyPathPanState
                options:options
                context:nil];
}

- (void)removeObservers {
  [self.superview removeObserver:self
                      forKeyPath:PAFFRefreshKeyPathContentOffset];
  [self.superview removeObserver:self forKeyPath:PAFFRefreshKeyPathContentSize];
  ;
  [self.pan removeObserver:self forKeyPath:PAFFRefreshKeyPathPanState];
  self.pan = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  // 遇到这些情况就直接返回
  if (!self.userInteractionEnabled)
    return;
    
  // 这个就算看不见也需要处理
  if ([keyPath isEqualToString:PAFFRefreshKeyPathContentSize]) {
    [self scrollViewContentSizeDidChange:change];
  }
  
  // 看不见
  if (self.hidden)
    return;
  if ([keyPath isEqualToString:PAFFRefreshKeyPathContentOffset]) {
    [self scrollViewContentOffsetDidChange:change];
  } else if ([keyPath isEqualToString:PAFFRefreshKeyPathPanState]) {
    [self scrollViewPanStateDidChange:change];
  }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
}

#pragma mark - 公共方法
#pragma mark 设置回调对象和回调方法
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action {
  self.refreshingTarget = target;
  self.refreshingAction = action;
}

#pragma mark 进入刷新状态
- (void)beginRefreshing {
  [UIView animateWithDuration:PAFFRefreshFastAnimationDuration
                   animations:^{
                     self.alpha = 1.0;
                   }];
  self.pullingPercent = 1.0;
  // 只要正在刷新，就完全显示
  if (self.window) {
    self.state = PAFFRefreshStateRefreshing;
  } else {
    self.state = PAFFRefreshStateWillRefresh;
    // 刷新(预防从另一个控制器回到这个控制器的情况，回来要重新刷新一下)
    [self setNeedsDisplay];
  }
}

#pragma mark 结束刷新状态
- (void)endRefreshing {
  self.state = PAFFRefreshStateIdle;
}

#pragma mark 是否正在刷新
- (BOOL)isRefreshing {
  return self.state == PAFFRefreshStateRefreshing ||
         self.state == PAFFRefreshStateWillRefresh;
}

#pragma mark 自动切换透明度
- (void)setAutoChangeAlpha:(BOOL)autoChangeAlpha {
  self.automaticallyChangeAlpha = autoChangeAlpha;
}

- (void)setAutomaticallyChangeAlpha:(BOOL)automaticallyChangeAlpha {
  _automaticallyChangeAlpha = automaticallyChangeAlpha;
  
  if (self.isRefreshing)
    return;
    
  if (automaticallyChangeAlpha) {
    self.alpha = self.pullingPercent;
  } else {
    self.alpha = 1.0;
  }
}

#pragma mark 根据拖拽进度设置透明度
- (void)setPullingPercent:(CGFloat)pullingPercent {
  _pullingPercent = pullingPercent;
  
  if (self.isRefreshing)
    return;
    
  if (self.isAutomaticallyChangeAlpha) {
    self.alpha = pullingPercent;
  }
}

#pragma mark - 内部方法
- (void)executeRefreshingCallback {
  dispatch_async(dispatch_get_main_queue(), ^{
    if (self.refreshingBlock) {
      self.refreshingBlock();
    }
    if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
      PAFFRefreshMsgSend(PAFFRefreshMsgTarget(self.refreshingTarget),
                         self.refreshingAction, self);
    }
  });
}
@end

@implementation UILabel(PAFFRefresh)
+ (instancetype)label
{
    UILabel *label = [[self alloc] init];
    label.font = PAFFRefreshLabelFont;
    label.textColor = PAFFRefreshLabelTextColor;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    return label;
}
@end